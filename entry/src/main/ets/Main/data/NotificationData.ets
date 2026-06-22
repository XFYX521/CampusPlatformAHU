/**
 * 点赞通知数据模型
 *
 * 当用户的评论被点赞时，后端创建一条通知记录。
 */

// 通知来源用户（谁点了赞）
export interface NotificationFromUser {
  id: number;
  username: string;
  nickname: string;
  avatar: string;
}

// 单条通知
@Observed
export class NotificationItem {
  id: string = '';
  type: string = 'comment_like';       // 通知类型，当前仅 comment_like
  from_user: NotificationFromUser = { id: 0, username: '', nickname: '', avatar: '' };
  comment_id: string = '';             // 被点赞的评论ID
  comment_content: string = '';        // 评论内容（摘要）
  window_name: string = '';            // 食堂窗口名称
  window_id: string = '';              // 窗口ID（可用来跳转）
  created_at: string = '';             // 通知时间
  is_read: boolean = false;            // 是否已读

  constructor(data?: Partial<NotificationItem>) {
    if (data) {
      this.id = data.id || '';
      this.type = data.type || 'comment_like';
      this.from_user = data.from_user !== undefined ? data.from_user :
        { id: 0, username: '', nickname: '', avatar: '' };
      this.comment_id = data.comment_id || '';
      this.comment_content = data.comment_content || '';
      this.window_name = data.window_name || '';
      this.window_id = data.window_id || '';
      this.created_at = data.created_at || '';
      this.is_read = data.is_read !== undefined ? data.is_read : false;
    }
  }
}

// 通知列表响应
export interface NotificationListResponse {
  code: number;
  message: string;
  data?: NotificationItem[];
}

// 未读数量数据
export interface UnreadCountData {
  count: number;
}

// 未读数量响应
export interface UnreadCountResponse {
  code: number;
  message: string;
  data?: UnreadCountData;
}

// 标记已读响应
export interface MarkReadResponse {
  code: number;
  message: string;
}
