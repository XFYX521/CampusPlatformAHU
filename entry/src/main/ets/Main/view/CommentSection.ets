import http from '@ohos.net.http';
import { promptAction } from '@kit.ArkUI';
import {
  CommentItem,
  CommentListResponse,
  PostCommentResponse,
  VoteResponse,
  DeleteCommentResponse
} from '../data/CommentData';
import { CommentItemComponent } from './CommentItemComponent';

/**
 * 食堂窗口评论区组件
 *
 * API规格：
 *   GET    /api/canteen/windows/comments?id=窗口ID
 *   POST   /api/canteen/windows/comments?id=窗口ID  Header:Bearer token
 *   DELETE /api/canteen/comments?id=评论ID          Header:Bearer token
 *   POST   /api/canteen/comments/vote?id=评论ID     Header:Bearer token
 */
@Component
export struct CommentSection {
  // 窗口ID（字符串，如 "1101"）
  @Prop windowId: string = '';

  // 评论列表
  @State commentList: CommentItem[] = [];
  @State isLoading: boolean = false;
  @State isPosting: boolean = false;

  // 排序模式：votes（按投票数）| time（按时间）
  @State sortMode: string = 'votes';

  // 新评论内容
  @State newCommentContent: string = '';

  // 用户认证信息
  @StorageLink('token') token: string = '';
  @StorageLink('isLoggedIn') isLoggedIn: boolean = false;

  // API基础URL
  private readonly baseUrl: string = "https://backend.hoshikaze.top/api/canteen";

  // 组件即将显示时加载评论
  aboutToAppear() {
    if (this.windowId !== '') {
      this.loadComments();
    }
  }

  build() {
    Column() {
      // 评论区标题
      this.CommentHeader()

      // 发表评论区域
      this.PostCommentArea()

      // 排序切换
      this.SortBar()

      // 评论列表
      this.CommentList()
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding(16)
    .margin({ top: 16 })
  }

  // ==================== 评论区标题 ====================
  @Builder
  CommentHeader() {
    Row() {
      Text('评论区')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.content_main_title_font_color'))

      Blank()

      Text(`${this.commentList.length}条评论`)
        .fontSize(14)
        .fontColor($r('app.color.font_tertiary'))
    }
    .width('100%')
    .margin({ bottom: 16 })
  }

  // ==================== 发表评论区域 ====================
  @Builder
  PostCommentArea() {
    Column() {
      // 输入框
      TextArea({ placeholder: '写下你的评论...', text: this.newCommentContent })
        .width('100%')
        .height(80)
        .backgroundColor($r('app.color.page_bg_color'))
        .borderRadius(8)
        .padding(12)
        .fontSize(14)
        .fontColor($r('app.color.font_primary'))
        .onChange((value: string) => {
          if (value.length <= 500) {
            this.newCommentContent = value;
          }
        })

      // 底部操作栏
      Row() {
        Text(`${this.newCommentContent.length}/500`)
          .fontSize(12)
          .fontColor($r('app.color.font_tertiary'))

        Blank()

        // 发表按钮
        Button(this.isPosting ? '发表中...' : '发表')
          .height(32)
          .fontSize(14)
          .fontColor(Color.White)
          .backgroundColor($r('app.color.button_bg_color'))
          .borderRadius(16)
          .padding({ left: 16, right: 16 })
          .enabled(this.canPost())
          .opacity(this.canPost() ? 1 : 0.5)
          .onClick(() => this.postComment())
      }
      .width('100%')
      .margin({ top: 8 })
    }
    .width('100%')
    .margin({ bottom: 16 })
  }

  // ==================== 排序切换（点击切换按热度 / 按时间）====================
  @Builder
  SortBar() {
    Row() {
      Blank()

      // ≡ 图标（三条横线）
      Column({ space: 3 }) {
        Divider()
          .width(12)
          .height(1.5)
          .color($r('app.color.font_tertiary'))
          .borderRadius(1)
        Divider()
          .width(12)
          .height(1.5)
          .color($r('app.color.font_tertiary'))
          .borderRadius(1)
        Divider()
          .width(12)
          .height(1.5)
          .color($r('app.color.font_tertiary'))
          .borderRadius(1)
      }
      .padding(4)
      .margin({ right: 4 })

      // 当前排序模式（点击切换）
      Text(this.sortMode === 'votes' ? '按热度' : '按时间')
        .fontSize(13)
        .fontColor($r('app.color.font_tertiary'))
        .fontWeight(FontWeight.Medium)
        .padding({ top: 4, bottom: 4 })
        .onClick(() => {
          this.sortMode = this.sortMode === 'votes' ? 'time' : 'votes';
          this.loadComments();
        })
    }
    .width('100%')
    .margin({ bottom: 8 })
  }

  // ==================== 评论列表 ====================
  @Builder
  CommentList() {
    if (this.isLoading) {
      // 加载中
      Column() {
        LoadingProgress()
          .width(32)
          .height(32)
          .color($r('app.color.button_bg_color'))

        Text('加载中...')
          .fontSize(14)
          .fontColor($r('app.color.font_tertiary'))
          .margin({ top: 8 })
      }
      .width('100%')
      .height(100)
      .justifyContent(FlexAlign.Center)
    } else if (this.commentList.length === 0) {
      // 暂无评论
      Column() {
        Text('暂无评论，快来发表第一条评论吧！')
          .fontSize(14)
          .fontColor($r('app.color.font_tertiary'))
      }
      .width('100%')
      .height(80)
      .justifyContent(FlexAlign.Center)
    } else {
      // 评论列表 - 使用独立的@Component来避免@Builder传参不刷新的问题
      ForEach(this.commentList, (comment: CommentItem, index: number) => {
        CommentItemComponent({
          comment: comment,
          onVote: (commentId: string, voteType: number) => {
            this.handleVote(commentId, voteType);
          },
          onDelete: (commentId: string) => {
            this.deleteComment(commentId);
          }
        })

        // 分隔线
        if (index < this.commentList.length - 1) {
          Divider()
            .width('100%')
            .height(0.5)
            .color('#F0F0F0')
            .margin({ top: 12, bottom: 12 })
        }
      }, (comment: CommentItem) => comment.id)
    }
  }

  // ==================== 工具方法 ====================

  /** 本地更新投票状态（赞、踩、取消、切换），避免全量刷新 */
  private updateVoteLocally(commentId: string, voteType: number): void {
    const comment = this.commentList.find(c => c.id === commentId);
    if (!comment) return;

    const oldVote = comment.my_vote;

    if (voteType === 1) { // 点赞
      if (oldVote === 1) {
        // 取消赞
        comment.likes -= 1;
        comment.my_vote = null;
      } else {
        // 新增赞
        comment.likes += 1;
        if (oldVote === -1) comment.dislikes -= 1;
        comment.my_vote = 1;
      }
    } else { // 点踩
      if (oldVote === -1) {
        // 取消踩
        comment.dislikes -= 1;
        comment.my_vote = null;
      } else {
        // 新增踩
        comment.dislikes += 1;
        if (oldVote === 1) comment.likes -= 1;
        comment.my_vote = -1;
      }
    }

    // 更新数组引用以触发 @State 重新渲染
    this.commentList = [...this.commentList];

    // 投票模式下重新排序（票数变了）
    if (this.sortMode === 'votes') {
      this.sortComments();
    }
  }

  /** 判断是否可以发表评论 */
  private canPost(): boolean {
    return !this.isPosting &&
           this.newCommentContent.trim() !== '' &&
           this.newCommentContent.length <= 500 &&
           this.isLoggedIn;
  }

  /** 按当前排序模式重新排序 */
  private sortComments(): void {
    if (!this.commentList || this.commentList.length === 0) return;
    const sorted = [...this.commentList];
    if (this.sortMode === 'votes') {
      // 按投票得分（赞-踩）降序
      sorted.sort((a, b) => (b.likes - b.dislikes) - (a.likes - a.dislikes));
    } else {
      // 按时间降序（最新在前）
      sorted.sort((a, b) => b.created_at.localeCompare(a.created_at));
    }
    this.commentList = sorted;
  }

  // ==================== API 调用 ====================

  /**
   * GET /api/canteen/windows/comments?id=窗口ID
   * 加载评论列表
   */
  async loadComments(): Promise<void> {
    if (this.windowId === '') {
      return;
    }

    this.isLoading = true;
    const httpRequest = http.createHttp();
    const url = `${this.baseUrl}/windows/comments?id=${this.windowId}`;

    try {
      const headers: Record<string, string> = {
        "Content-Type": "application/json"
      };
      if (this.isLoggedIn && this.token) {
        headers["Authorization"] = `Bearer ${this.token}`;
      }

      const response = await httpRequest.request(url, {
        method: http.RequestMethod.GET,
        header: headers,
        connectTimeout: 15000,
        readTimeout: 15000
      });

      console.info("[CommentSection] 加载评论响应:", response.responseCode, response.result);

      if (response.responseCode === 200) {
        let result: CommentListResponse;
        if (typeof response.result === 'string') {
          result = JSON.parse(response.result);
        } else {
          result = response.result as CommentListResponse;
        }

        if (result.code === 200 && result.data) {
          this.commentList = result.data;
          this.sortComments();
        } else {
          const msg = result.message ? result.message : '加载失败';
          console.error("[CommentSection] 业务错误:", msg);
        }
      } else {
        console.error("[CommentSection] HTTP错误:", response.responseCode);
      }
    } catch (error) {
      console.error("[CommentSection] 加载评论失败:", error);
    } finally {
      this.isLoading = false;
      httpRequest.destroy();
    }
  }

  /**
   * POST /api/canteen/windows/comments?id=窗口ID
   * 发表评论
   */
  async postComment(): Promise<void> {
    if (!this.isLoggedIn || !this.token || this.token === '') {
      promptAction.showToast({ message: '请先登录' });
      return;
    }

    const content = this.newCommentContent.trim();
    if (content === '') {
      promptAction.showToast({ message: '请输入评论内容' });
      return;
    }

    if (this.windowId === '') {
      promptAction.showToast({ message: '窗口ID无效' });
      return;
    }

    this.isPosting = true;
    const httpRequest = http.createHttp();
    const url = `${this.baseUrl}/windows/comments?id=${this.windowId}`;

    try {
      const response = await httpRequest.request(url, {
        method: http.RequestMethod.POST,
        header: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${this.token}`
        },
        extraData: JSON.stringify({ content: content }),
        connectTimeout: 15000,
        readTimeout: 15000
      });

      console.info("[CommentSection] 发表评论响应:", response.responseCode);

      if (response.responseCode === 200) {
        let result: PostCommentResponse;
        if (typeof response.result === 'string') {
          result = JSON.parse(response.result as string);
        } else {
          result = response.result as PostCommentResponse;
        }

        if (result.code === 200) {
          promptAction.showToast({ message: '评论发表成功' });
          this.newCommentContent = '';
          this.loadComments();
        } else {
          const msg = result.message ? result.message : '评论发表失败';
          promptAction.showToast({ message: msg });
        }
      } else if (response.responseCode === 401) {
        promptAction.showToast({ message: '登录已过期，请重新登录' });
        AppStorage.setOrCreate('token', '');
        AppStorage.setOrCreate('isLoggedIn', false);
      } else {
        promptAction.showToast({ message: '发表失败，请稍后重试' });
      }
    } catch (error) {
      console.error("[CommentSection] 发表评论失败:", error);
      promptAction.showToast({ message: '网络错误，请重试' });
    } finally {
      this.isPosting = false;
      httpRequest.destroy();
    }
  }

  /**
   * POST /api/canteen/comments/vote?id=评论ID
   * 点赞/点踩
   */
  async handleVote(commentId: string, voteType: number): Promise<void> {
    if (!this.isLoggedIn || !this.token) {
      promptAction.showToast({ message: '请先登录' });
      return;
    }

    const httpRequest = http.createHttp();
    const url = `${this.baseUrl}/comments/vote?id=${commentId}`;

    try {
      const response = await httpRequest.request(url, {
        method: http.RequestMethod.POST,
        header: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${this.token}`
        },
        extraData: JSON.stringify({ type: voteType }),
        connectTimeout: 10000,
        readTimeout: 10000
      });

      console.info("[CommentSection] 投票响应:", response.responseCode, response.result);

      if (response.responseCode === 200) {
        let result: VoteResponse;
        if (typeof response.result === 'string') {
          result = JSON.parse(response.result);
        } else {
          result = response.result as VoteResponse;
        }

        if (result.code === 200) {
          // 本地更新投票状态，避免全量刷新导致滚动位置重置
          this.updateVoteLocally(commentId, voteType);
        } else {
          const msg = result.message ? result.message : '操作失败';
          promptAction.showToast({ message: msg });
        }
      } else if (response.responseCode === 401) {
        promptAction.showToast({ message: '登录已过期，请重新登录' });
        AppStorage.setOrCreate('token', '');
        AppStorage.setOrCreate('isLoggedIn', false);
      }
    } catch (error) {
      console.error("[CommentSection] 投票失败:", error);
    } finally {
      httpRequest.destroy();
    }
  }

  /**
   * DELETE /api/canteen/comments?id=评论ID
   * 删除评论
   */
  async deleteComment(commentId: string): Promise<void> {
    if (!this.isLoggedIn || !this.token) {
      promptAction.showToast({ message: '请先登录' });
      return;
    }

    const httpRequest = http.createHttp();
    const url = `${this.baseUrl}/comments?id=${commentId}`;

    try {
      const response = await httpRequest.request(url, {
        method: http.RequestMethod.DELETE,
        header: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${this.token}`
        },
        connectTimeout: 10000,
        readTimeout: 10000
      });

      console.info("[CommentSection] 删除评论响应:", response.responseCode, response.result);

      if (response.responseCode === 200) {
        let result: DeleteCommentResponse;
        if (typeof response.result === 'string') {
          result = JSON.parse(response.result);
        } else {
          result = response.result as DeleteCommentResponse;
        }

        if (result.code === 200) {
          promptAction.showToast({ message: '评论已删除' });
          this.commentList = this.commentList.filter(c => c.id !== commentId);
        } else {
          const msg = result.message ? result.message : '删除失败';
          promptAction.showToast({ message: msg });
        }
      } else if (response.responseCode === 401) {
        promptAction.showToast({ message: '登录已过期，请重新登录' });
        AppStorage.setOrCreate('token', '');
        AppStorage.setOrCreate('isLoggedIn', false);
      }
    } catch (error) {
      console.error("[CommentSection] 删除评论失败:", error);
      promptAction.showToast({ message: '网络错误，请重试' });
    } finally {
      httpRequest.destroy();
    }
  }
}
