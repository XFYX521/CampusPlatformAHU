import { CommentItem } from '../data/CommentData';

/**
 * 单条评论子组件
 * 字段名严格对齐实际API返回格式
 * 使用 @ObjectLink 接收 @Observed 对象，支持深度观察
 */
@Component
export struct CommentItemComponent {
  @ObjectLink comment: CommentItem;

  // 当前登录用户名（用来判断删除按钮显隐）
  @StorageLink('username') currentUsername: string = '';

  // 头像图片加载失败时显示文字兜底
  @State private avatarLoadFailed: boolean = false;

  onVote?: (commentId: string, voteType: number) => void = undefined;
  onDelete?: (commentId: string) => void = undefined;

  // 头像完整URL（后端文件路径基址 + 文件名）
  private readonly avatarBaseUrl: string = 'https://backend.hoshikaze.top/avatars/';

  build() {
    Column() {
      // ── 用户信息行 ──
      Row() {
        // 头像：有图片URL时加载图片，失败/无图时显示首字母
        if (this.hasAvatarImage() && !this.avatarLoadFailed) {
          // 远程图片头像
          Image(this.getAvatarUrl())
            .width(36)
            .height(36)
            .borderRadius(18)
            .objectFit(ImageFit.Cover)
            .onError(() => {
              this.avatarLoadFailed = true;
            })
        } else {
          // 兜底：首字母
          Column() {
            Text(this.getAvatarChar())
              .fontSize(16)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
          }
          .width(36)
          .height(36)
          .borderRadius(18)
          .backgroundColor($r('app.color.button_bg_color'))
          .justifyContent(FlexAlign.Center)
        }

        // 昵称 + 时间
        Column() {
          Text(this.getDisplayName())
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor($r('app.color.font_primary'))

          Text(this.formatTime(this.comment.created_at))
            .fontSize(12)
            .fontColor($r('app.color.font_tertiary'))
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 8 })
        .layoutWeight(1)
      }
      .width('100%')

      // ── 评论内容 ──
      Text(this.comment.content ? this.comment.content : '')
        .fontSize(14)
        .fontColor($r('app.color.font_primary'))
        .width('100%')
        .margin({ top: 8 })

      // ── 点赞/点踩 + 删除（右侧） ──
      Row({ space: 16 }) {
        Row({ space: 4 }) {
          Text('👍').fontSize(14)
          Text(this.safeNum(this.comment.likes))
            .fontSize(12)
            .fontColor(this.comment.my_vote === 1
              ? $r('app.color.button_bg_color') : $r('app.color.font_tertiary'))
        }
        .onClick(() => {
          if (this.onVote) { this.onVote(this.comment.id, 1); }
        })

        Row({ space: 4 }) {
          Text('👎').fontSize(14)
          Text(this.safeNum(this.comment.dislikes))
            .fontSize(12)
            .fontColor(this.comment.my_vote === -1
              ? Color.Red : $r('app.color.font_tertiary'))
        }
        .onClick(() => {
          if (this.onVote) { this.onVote(this.comment.id, -1); }
        })

        // 弹性空白 → 把删除推到右侧
        Blank().layoutWeight(1)

        // 删除（仅自己的评论）
        if (this.isOwnComment()) {
          Text('删除')
            .fontSize(12)
            .fontColor(Color.Red)
            .onClick(() => {
              this.showDeleteConfirm();
            })
        }
      }
      .width('100%')
      .margin({ top: 8 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  // ============ 工具方法 ============

  /** 删除确认弹窗 */
  private showDeleteConfirm(): void {
    AlertDialog.show({
      title: '确认删除',
      message: '删除后不可恢复，确定要删除这条评论吗？',
      autoCancel: true,
      alignment: DialogAlignment.Center,
      primaryButton: {
        value: '取消',
        fontColor: $r('app.color.font_tertiary'),
        action: () => {}
      },
      secondaryButton: {
        value: '确认删除',
        fontColor: $r('app.color.button_bg_color'),
        action: () => {
          if (this.onDelete) {
            this.onDelete(this.comment.id);
          }
        }
      }
    });
  }

  /** 头像首字母 */
  private getAvatarChar(): string {
    const name = this.comment.user?.nickname || this.comment.user?.username || '';
    return name.length > 0 ? name.charAt(0).toUpperCase() : '?';
  }

  /** 显示名：昵称 > 用户名 > 匿名 */
  private getDisplayName(): string {
    if (this.comment.user?.nickname) return this.comment.user.nickname;
    if (this.comment.user?.username) return this.comment.user.username;
    return '匿名用户';
  }

  /** 是否自己的评论 */
  private isOwnComment(): boolean {
    if (!this.currentUsername) return false;
    const u = this.comment.user;
    return u?.username === this.currentUsername || u?.nickname === this.currentUsername;
  }

  /** 安全数字转字符串 */
  private safeNum(val: number | undefined | null): string {
    if (val === undefined || val === null) return '0';
    return String(val);
  }

  /** 头像文件名是否非空 */
  private hasAvatarImage(): boolean {
    const avatar = this.comment.user?.avatar;
    return avatar !== undefined && avatar !== null && avatar.trim() !== '';
  }

  /** 构造头像完整URL */
  private getAvatarUrl(): string {
    const avatar = this.comment.user?.avatar || '';
    if (avatar.startsWith('http://') || avatar.startsWith('https://')) {
      return avatar;
    }
    // 文件名 → 拼接完整URL
    return `${this.avatarBaseUrl}${avatar}`;
  }

  /** 格式化时间：服务器UTC+0 → 东八区，1天内→X小时前，超出→YYYY-MM-DD */
  private formatTime(dateStr: string): string {
    if (!dateStr) return '';
    try {
      // 支持 "2026-06-19T14:30:00" / "2026-06-19 14:30:00" / "2026-06-18"
      let date: Date;
      const normalized = dateStr.replace(' ', 'T');
      if (normalized.includes('T')) {
        date = new Date(normalized);
        // UTC → 东八区（+8小时）
        date.setTime(date.getTime() + 8 * 3600000);
      } else {
        // 纯日期按当天0点（东八区）
        const parts = dateStr.split('-');
        date = new Date(parseInt(parts[0]), parseInt(parts[1]) - 1, parseInt(parts[2]));
      }

      const now = new Date();
      const diffMs = now.getTime() - date.getTime();
      const diffMinutes = Math.floor(diffMs / 60000);

      if (diffMinutes < 1) return '刚刚';
      if (diffMinutes < 60) return `${diffMinutes}分钟前`;

      const diffHours = Math.floor(diffMinutes / 60);
      if (diffHours < 24) return `${diffHours}小时前`;

      // 超出1天 → 显示年月日
      const y = date.getFullYear();
      const m = String(date.getMonth() + 1).padStart(2, '0');
      const d = String(date.getDate()).padStart(2, '0');
      return `${y}-${m}-${d}`;
    } catch (e) {
      return dateStr;
    }
  }
}
