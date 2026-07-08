import { ApiClient, ApiRequestOptions } from '../util/ApiClient';
import { promptAction } from '@kit.ArkUI';

interface FeedbackItem {
  id: number | string;
  title: string;
  content: string;
  submitTime: string;
}

interface FeedbackHistoryResponse {
  code: number;
  msg: string;
  data?: FeedbackItem[];
}

interface BusinessError {
  code: number | string;
  message?: string;
}

@Entry
export struct FeedbackHistoryPage {
  @Consume('appPathStack') appPathStack: NavPathStack;
  @State feedbackList: FeedbackItem[] = [];
  @State isLoading: boolean = true;
  @State hasError: boolean = false;
  @StorageLink('token') token: string = '';

  aboutToAppear() {
    // 页面加载时获取历史反馈
    this.fetchFeedbackHistory();
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.TopStart }) {
        Column() {
          // 头部：返回按钮和标题
          Row() {
            Image($r('app.media.IMG_0218'))
              .width(30)
              .height(30)
              .onClick(() => {
                this.appPathStack.pop();
              })

            Text('我的反馈')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.page_title_font_color'))
              .margin({ left: 15 })
              .layoutWeight(1)
          }
          .width('100%')
          .padding(20)

          // 内容区域
          if (this.isLoading) {
            // 加载中
            Column() {
              LoadingProgress()
                .width(50)
                .height(50)
                .color($r('app.color.app_icon_pressed_color'))
              
              Text('加载中...')
                .fontSize(14)
                .fontColor($r('app.color.font_tertiary'))
                .margin({ top: 15 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
          } else if (this.hasError) {
            // 加载失败
            Column() {
              Image($r('app.media.lib_icon_4'))
                .width(60)
                .height(60)
                .fillColor($r('app.color.font_tertiary'))
              
              Text('加载失败')
                .fontSize(16)
                .fontColor($r('app.color.font_tertiary'))
                .margin({ top: 15 })
              
              Button('重新加载')
                .fontSize(14)
                .fontColor(Color.White)
                .backgroundColor($r('app.color.app_icon_pressed_color'))
                .borderRadius(20)
                .height(36)
                .margin({ top: 20 })
                .onClick(() => this.fetchFeedbackHistory())
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
          } else if (this.feedbackList.length === 0) {
            // 无反馈记录
            Column() {
              Image($r('app.media.lib_icon_Feedback'))
                .width(60)
                .height(60)
                .fillColor($r('app.color.font_tertiary'))
              
              Text('暂无反馈记录')
                .fontSize(16)
                .fontColor($r('app.color.font_tertiary'))
                .margin({ top: 15 })
              
              Text('您的反馈将在这里显示')
                .fontSize(14)
                .fontColor($r('app.color.font_tertiary'))
                .margin({ top: 8 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
          } else {
            // 反馈列表
            List({ space: 15 }) {
              ForEach(this.feedbackList, (item: FeedbackItem) => {
                ListItem() {
                  this.FeedbackCard(item)
                }
              }, (item: FeedbackItem) => item.id.toString())
            }
            .width('100%')
            .layoutWeight(1)
            .padding({ left: 20, right: 20, top: 10, bottom: 20 })
            .scrollBar(BarState.Off)
          }
        }
        .width('100%')
        .height('100%')
        .backgroundColor($r('app.color.page_bg_color'))
      }
    }
    .hideTitleBar(true)
  }

  // 反馈卡片
  @Builder
  FeedbackCard(item: FeedbackItem) {
    Column() {
      // 标题和时间
      Row() {
        Text(item.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.content_main_title_font_color'))
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)

        Text(this.formatTime(item.submitTime))
          .fontSize(12)
          .fontColor($r('app.color.font_tertiary'))
          .margin({ left: 10 })
      }
      .width('100%')
      .margin({ bottom: 10 })

      // 内容
      Text(item.content)
        .fontSize(14)
        .fontColor($r('app.color.font_secondary'))
        .maxLines(3)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .textAlign(TextAlign.Start)

      // 底部：反馈ID
      Row() {
        Text(`ID: ${item.id}`)
          .fontSize(12)
          .fontColor($r('app.color.font_tertiary'))
      }
      .width('100%')
      .margin({ top: 10 })
    }
    .width('100%')
    .padding(15)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  // 格式化时间
  formatTime(timeStr: string): string {
    try {
      if (!timeStr) return '';
      
      // 处理ISO格式时间字符串
      const date = new Date(timeStr);
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const day = String(date.getDate()).padStart(2, '0');
      const hour = String(date.getHours()).padStart(2, '0');
      const minute = String(date.getMinutes()).padStart(2, '0');
      
      return `${year}-${month}-${day} ${hour}:${minute}`;
    } catch (error) {
      return timeStr;
    }
  }

  // 获取历史反馈
  async fetchFeedbackHistory() {
    // 检查是否登录
    if (!this.token) {
      promptAction.showToast({ message: '请先登录' });
      this.hasError = true;
      this.isLoading = false;
      return;
    }

    this.isLoading = true;
    this.hasError = false;

    try {
      let requestOptions: ApiRequestOptions = { token: this.token };
      let res = await ApiClient.get('api/feedback', undefined, requestOptions);

      console.info("=== 历史反馈响应详情 ===");
      console.info("HTTP状态码:", res.responseCode);
      console.info("响应结果:", res.result);

      // 检查HTTP状态码
      if (res.responseCode !== 200) {
        console.error("HTTP状态码异常:", res.responseCode);
        
        // 处理401鉴权失败
        if (res.responseCode === 401) {
          promptAction.showToast({ message: '登录已过期，请重新登录' });
          // 清除token
          AppStorage.setOrCreate('token', '');
          AppStorage.setOrCreate('isLoggedIn', false);
          // 返回登录页
          setTimeout(() => {
            this.appPathStack.pushPathByName('LoginPage', null);
          }, 1500);
        } else {
          this.hasError = true;
          promptAction.showToast({ message: '加载失败，请稍后重试' });
        }
        return;
      }

      // 解析响应
      let result: FeedbackHistoryResponse;
      if (typeof res.result === 'string') {
        try {
          result = JSON.parse(res.result);
        } catch (parseErr) {
          console.error("JSON解析失败:", parseErr);
          this.hasError = true;
          promptAction.showToast({ message: '数据格式错误' });
          return;
        }
      } else if (typeof res.result === 'object') {
        result = res.result as FeedbackHistoryResponse;
      } else {
        console.error("无法识别的响应格式:", typeof res.result);
        this.hasError = true;
        promptAction.showToast({ message: '响应格式异常' });
        return;
      }

      console.info("解析后的结果:", JSON.stringify(result));

      if (result.code === 200) {
        // 获取成功
        this.feedbackList = result.data || [];
        console.info("反馈列表数量:", this.feedbackList.length);
      } else {
        // 业务错误
        console.error("业务错误码:", result.code, "错误信息:", result.msg);
        this.hasError = true;
        promptAction.showToast({
          message: result.msg || '获取反馈列表失败'
        });
      }
    } catch (err) {
      // 网络错误
      console.error("=== 请求异常详情 ===");
      console.error("错误:", err);

      let errorMsg = '网络连接失败，请检查网络';
      const businessErr = err as BusinessError;
      if (businessErr.code !== undefined) {
        const errCode = businessErr.code;
        if (errCode === -1 || errCode === '-1') {
          errorMsg = '网络连接超时，请检查网络';
        } else if (errCode === -2 || errCode === '-2') {
          errorMsg = '服务器连接失败';
        } else if (errCode === 401 || errCode === '401') {
          errorMsg = '登录已过期，请重新登录';
          // 清除token
          AppStorage.setOrCreate('token', '');
          AppStorage.setOrCreate('isLoggedIn', false);
        }
      }

      this.hasError = true;
      promptAction.showToast({ message: errorMsg });
    } finally {
      this.isLoading = false;
    }
  }
}
