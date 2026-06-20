// 评论所属用户信息
export interface CommentUser {
  id: number;
  username: string;
  nickname: string;
  avatar: string;
}

// 单条评论（使用 @Observed 支持深度观察）
@Observed
export class CommentItem {
  id: string = '';
  window_id: number = 0;
  content: string = '';
  image?: string = '';
  likes: number = 0;
  dislikes: number = 0;
  created_at: string = '';      // "2026-06-18"
  my_vote: number | null = null;  // 1=赞, -1=踩, null=未投
  user: CommentUser = { id: 0, username: '', nickname: '', avatar: '' };

  // 构造函数，支持从接口创建
  constructor(data?: Partial<CommentItem>) {
    if (data) {
      this.id = data.id || '';
      this.window_id = data.window_id || 0;
      this.content = data.content || '';
      this.image = data.image;
      this.likes = data.likes || 0;
      this.dislikes = data.dislikes || 0;
      this.created_at = data.created_at || '';
      this.my_vote = data.my_vote !== undefined ? data.my_vote : null;
      this.user = data.user || { id: 0, username: '', nickname: '', avatar: '' };
    }
  }
}

// 评论列表响应
export interface CommentListResponse {
  code: number;
  message: string;
  data?: CommentItem[];
}

// 发表评论成功后返回的ID
export interface PostCommentIdData {
  id: string;
}

// 发表评论响应
export interface PostCommentResponse {
  code: number;
  message: string;
  data?: PostCommentIdData;
}

// 点赞/点踩响应
export interface VoteResponse {
  code: number;
  message: string;
}

// 删除评论响应
export interface DeleteCommentResponse {
  code: number;
  message: string;
}
