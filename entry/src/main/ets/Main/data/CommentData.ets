// 评论所属用户信息
export interface CommentUser {
  id: number;
  username: string;
  nickname: string;
  avatar: string;
}

// 单条评论
export interface CommentItem {
  id: string;
  window_id: number;
  content: string;
  image?: string;
  likes: number;
  dislikes: number;
  created_at: string;      // "2026-06-18"
  my_vote: number | null;  // 1=赞, -1=踩, null=未投
  user: CommentUser;
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
