import http from '@ohos.net.http';
import { promptAction } from '@kit.ArkUI';
import router from '@ohos.router';
import {
  NotificationItem,
  NotificationListResponse,
  MarkReadResponse,
  NotificationFromUser
} from '../data/NotificationData';

/**
 * 通知消息页面
 */

@Entry
@Component
export struct NotificationPage {
  @Consume('appPathStack') appPathStack: NavPathStack;

  @StorageLink('token') token: string = '';
  @StorageLink('isLoggedIn') isLoggedIn: boolean = false;

  @State notificationList: NotificationItem[] = [];
  @State isLoading: boolean = false;

  private readonly baseUrl: string = "https://backend.hoshikaze.top/api";

  aboutToAppear() {
    this.loadNotifications();
  }

  build() {
    NavDestination() {
      Column() {
        this.NavBar()
        this.MainContent()
      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.page_bg_color'))
    }
    .hideTitleBar(true)
  }

  @Builder
  NavBar() {
    Row() {
      Image($r('app.media.IMG_0221'))
        .width(24)
        .height(24)
        .onClick(() => {
          this.appPathStack.pop();
        })
      Blank()
      Text('消息通知')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.page_title_font_color'))
      Blank()
      if (this.hasUnread()) {
        Text('全部已读')
          .fontSize(14)
          .fontColor($r('app.color.button_bg_color'))
          .onClick(() => {
            this.markAllAsRead();
          })
      } else {
        Blank().width(48)
      }
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(Color.White)
  }

  @Builder
  MainContent() {
    if (!this.isLoggedIn) {
      Column() {
        Text('请先登录后查看通知')
          .fontSize(16)
          .fontColor($r('app.color.font_tertiary'))
          .margin({ bottom: 20 })
        Button('去登录')
          .fontSize(14)
          .fontColor(Color.White)
          .backgroundColor($r('app.color.button_bg_color'))
          .borderRadius(20)
          .height(40)
          .width(120)
          .onClick(() => {
            this.appPathStack.pushPathByName('LoginPage', null);
          })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    } else if (this.isLoading && this.notificationList.length === 0) {
      Column() {
        LoadingProgress()
          .width(32)
          .height(32)
          .color($r('app.color.button_bg_color'))
        Text('加载中...')
          .fontSize(14)
          .fontColor($r('app.color.font_tertiary'))
          .margin({ top: 12 })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    } else if (this.notificationList.length === 0) {
      Column() {
        Text('\uD83D\uDCED')
          .fontSize(48)
          .margin({ bottom: 16 })
        Text('暂无通知消息')
          .fontSize(16)
          .fontColor($r('app.color.font_tertiary'))
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    } else {
      List() {
        ForEach(this.notificationList, (item: NotificationItem) => {
          ListItem() {
            this.RenderNotificationCard(item)
          }
        }, (item: NotificationItem) => item.id)
      }
      .width('100%')
      .edgeEffect(EdgeEffect.Spring)
    }
  }

  @Builder
  RenderNotificationCard(item: NotificationItem) {
    Row({ space: 12 }) {
      // Avatar area
      Stack() {
        if (this.hasAvatarImage(item.from_user.avatar)) {
          Image(this.getAvatarUrl(item.from_user.avatar))
            .width(44)
            .height(44)
            .borderRadius(22)
            .objectFit(ImageFit.Cover)
        } else {
          Column() {
            Text(this.getAvatarChar(item.from_user))
              .fontSize(18)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
          }
          .width(44)
          .height(44)
          .borderRadius(22)
          .backgroundColor($r('app.color.button_bg_color'))
          .justifyContent(FlexAlign.Center)
        }
        if (!item.is_read) {
          Circle({ width: 10, height: 10 })
            .fill(Color.Red)
            .position({ x: 34, y: 0 })
        }
        Text('\uD83D\uDC4D')
          .fontSize(12)
          .position({ x: 30, y: 30 })
      }
      .width(44)
      .height(44)

      // Content area
      Column({ space: 4 }) {
        Row({ space: 4 }) {
          Text(this.getDisplayName(item.from_user))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor($r('app.color.font_primary'))
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Text('\u8D5E\u4E86\u4F60\u7684\u8BC4\u8BBA')
            .fontSize(14)
            .fontColor($r('app.color.font_secondary'))
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')

        if (item.window_name) {
          // 食堂窗口名称
          Text('\u7A97\u53E3\uFF1A' + item.window_name)
            .fontSize(13)
            .fontColor($r('app.color.font_tertiary'))
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }

        if (item.comment_content) {
          // 评论内容预览
          Text(this.truncateContent(item.comment_content))
            .fontSize(13)
            .fontColor('#999999')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .backgroundColor('#F5F5F5')
            .borderRadius(6)
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .width('100%')
        }

        Text(this.formatTime(item.created_at))
          .fontSize(12)
          .fontColor($r('app.color.font_tertiary'))
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 14, bottom: 14 })
    .backgroundColor(item.is_read ? Color.White : '#FFF8F0')
    .onClick(() => {
      if (!item.is_read) {
        this.markNotificationRead(item.id);
      }
      this.navigateToWindow(item);
    })
  }

  // ==================== API ====================

  async loadNotifications(): Promise<void> {
    if (!this.isLoggedIn || !this.token) {
      return;
    }
    this.isLoading = true;
    const httpRequest = http.createHttp();
    try {
      const response = await httpRequest.request(
        this.baseUrl + '/notifications?page=1&page_size=50',
        {
          method: http.RequestMethod.GET,
          header: {
            "Content-Type": "application/json",
            "Authorization": 'Bearer ' + this.token
          },
          connectTimeout: 15000,
          readTimeout: 15000
        }
      );
      if (response.responseCode === 200) {
        let result: NotificationListResponse;
        if (typeof response.result === 'string') {
          result = JSON.parse(response.result as string);
        } else {
          result = response.result as NotificationListResponse;
        }
        if (result.code === 200 && result.data) {
          this.notificationList = result.data.map((item: NotificationItem) => new NotificationItem(item));
          this.updateUnreadCount();
        }
      }
    } catch (error) {
      console.error('[NotificationPage] load error:', error);
    } finally {
      this.isLoading = false;
      httpRequest.destroy();
    }
  }

  async markNotificationRead(id: string): Promise<void> {
    const httpRequest = http.createHttp();
    try {
      await httpRequest.request(
        this.baseUrl + '/notifications/mark-read?id=' + id,
        {
          method: http.RequestMethod.POST,
          header: {
            "Content-Type": "application/json",
            "Authorization": 'Bearer ' + this.token
          },
          connectTimeout: 10000,
          readTimeout: 10000
        }
      );
      const target = this.notificationList.find((n: NotificationItem) => n.id === id);
      if (target) {
        target.is_read = true;
      }
      this.updateUnreadCount();
    } catch (error) {
      console.error('[NotificationPage] mark read error:', error);
    } finally {
      httpRequest.destroy();
    }
  }

  async markAllAsRead(): Promise<void> {
    const httpRequest = http.createHttp();
    try {
      await httpRequest.request(
        this.baseUrl + '/notifications/mark-all-read',
        {
          method: http.RequestMethod.POST,
          header: {
            "Content-Type": "application/json",
            "Authorization": 'Bearer ' + this.token
          },
          connectTimeout: 10000,
          readTimeout: 10000
        }
      );
      for (const item of this.notificationList) {
        item.is_read = true;
      }
      AppStorage.setOrCreate('unreadNotificationCount', 0);
      promptAction.showToast({ message: '已全部标记为已读' });
    } catch (error) {
      console.error('[NotificationPage] mark all error:', error);
    } finally {
      httpRequest.destroy();
    }
  }

  // ==================== Helpers ====================

  private hasUnread(): boolean {
    return this.notificationList.some((n: NotificationItem) => !n.is_read);
  }

  private updateUnreadCount(): void {
    const count = this.notificationList.filter((n: NotificationItem) => !n.is_read).length;
    AppStorage.setOrCreate('unreadNotificationCount', count);
  }

  private navigateToWindow(item: NotificationItem): void {
    if (item.window_id) {
      const params: Record<string, Object> = {
        'windowId': item.window_id as Object,
        'windowName': item.window_name as Object
      };
      router.pushUrl({
        url: 'Main/pages/WindowDetailPage',
        params: params
      });
    }
  }

  private getDisplayName(user: NotificationFromUser): string {
    if (user.nickname) {
      return user.nickname;
    }
    if (user.username) {
      return user.username;
    }
    return '匿名用户';
  }

  private getAvatarChar(user: NotificationFromUser): string {
    const name = user.nickname || user.username || '';
    if (name.length > 0) {
      return name.charAt(0).toUpperCase();
    }
    return '?';
  }

  private hasAvatarImage(avatar: string): boolean {
    return avatar !== undefined && avatar !== null && avatar.trim() !== '';
  }

  private getAvatarUrl(avatar: string): string {
    if (avatar.startsWith('http://') || avatar.startsWith('https://')) {
      return avatar;
    }
    return 'https://backend.hoshikaze.top/avatars/' + avatar;
  }

  private truncateContent(content: string): string {
    if (!content) {
      return '';
    }
    if (content.length > 60) {
      return content.substring(0, 60) + '...';
    }
    return content;
  }

  private formatTime(dateStr: string): string {
    if (!dateStr) {
      return '';
    }
    try {
      let date: Date;
      const normalized = dateStr.replace(' ', 'T');
      if (normalized.includes('T')) {
        date = new Date(normalized);
        date.setTime(date.getTime() + 8 * 3600000);
      } else {
        const parts = dateStr.split('-');
        date = new Date(parseInt(parts[0]), parseInt(parts[1]) - 1, parseInt(parts[2]));
      }
      const now = new Date();
      const diffMs = now.getTime() - date.getTime();
      const diffMinutes = Math.floor(diffMs / 60000);
      if (diffMinutes < 1) {
        return '刚刚';
      }
      if (diffMinutes < 60) {
        return diffMinutes + '分钟前';
      }
      const diffHours = Math.floor(diffMinutes / 60);
      if (diffHours < 24) {
        return diffHours + '小时前';
      }
      const diffDays = Math.floor(diffHours / 24);
      if (diffDays < 7) {
        return diffDays + '天前';
      }
      const y = date.getFullYear();
      const m = String(date.getMonth() + 1).padStart(2, '0');
      const d = String(date.getDate()).padStart(2, '0');
      return y + '-' + m + '-' + d;
    } catch (e) {
      return dateStr;
    }
  }
}
