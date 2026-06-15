import http from '@ohos.net.http';
import { promptAction } from '@kit.ArkUI';

interface FeedbackResponse {
  code: number;
  msg: string;
  data?: Record<string, Object>;
}

interface BusinessError {
  code: number | string;
  message?: string;
}

@Entry
export struct FeedbackPage {
  @Consume('appPathStack') appPathStack: NavPathStack;
  @State feedbackTitle: string = '';
  @State feedbackContent: string = '';
  @State isSubmitting: boolean = false;
  @StorageLink('token') token: string = '';
  
  // 反馈接口地址
  private feedbackUrl: string = "https://backend.hoshikaze.top/api/feedback";

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

            Text('用户反馈')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.page_title_font_color'))
              .margin({ left: 15 })
              .layoutWeight(1)
          }
          .width('100%')
          .padding(20)

          // 反馈说明
          Column() {
            Text('感谢您的反馈')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor($r('app.color.page_title_font_color'))
              .margin({ bottom: 8 })

            Text('您的意见和建议是我们改进的动力')
              .fontSize(14)
              .fontColor($r('app.color.font_tertiary'))
          }
          .width('100%')
          .padding({ top: 20, bottom: 30, left: 20, right: 20 })
          .alignItems(HorizontalAlign.Start)

          // 反馈表单
          Column({ space: 20 }) {
            // 标题输入
            Column({ space: 8 }) {
              Text('反馈标题')
                .fontSize(16)
                .fontColor($r('app.color.content_main_title_font_color'))
                .alignSelf(ItemAlign.Start)

              TextInput({ placeholder: '请输入反馈标题（必填）', text: this.feedbackTitle })
                .width('100%')
                .height(50)
                .backgroundColor(Color.White)
                .borderRadius(8)
                .padding({ left: 15, right: 15 })
                .onChange((value: string) => {
                  this.feedbackTitle = value;
                })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // 内容输入
            Column({ space: 8 }) {
              Row() {
                Text('反馈内容')
                  .fontSize(16)
                  .fontColor($r('app.color.content_main_title_font_color'))
                  .layoutWeight(1)

                Text(`${this.feedbackContent.length}/500`)
                  .fontSize(12)
                  .fontColor($r('app.color.font_tertiary'))
              }
              .width('100%')

              TextArea({ placeholder: '请详细描述您的问题或建议（必填）', text: this.feedbackContent })
                .width('100%')
                .height(200)
                .backgroundColor(Color.White)
                .borderRadius(8)
                .padding(15)
                .onChange((value: string) => {
                  if (value.length <= 500) {
                    this.feedbackContent = value;
                  }
                })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // 提交按钮
            Button(this.isSubmitting ? '提交中...' : '提交反馈')
              .width('100%')
              .height(50)
              .fontSize(16)
              .fontColor(Color.White)
              .backgroundColor($r('app.color.app_icon_pressed_color'))
              .borderRadius(8)
              .enabled(!this.isSubmitting && this.feedbackTitle.trim() !== '' && this.feedbackContent.trim() !== '')
              .opacity((!this.isSubmitting && this.feedbackTitle.trim() !== '' && this.feedbackContent.trim() !== '') ? 1 : 0.5)
              .onClick(() => this.handleSubmitFeedback())
          }
          .width('100%')
          .padding({ left: 20, right: 20 })
          .layoutWeight(1)

          // 底部提示
          Column() {
            Text('我们会在1-3个工作日内处理您的反馈')
              .fontSize(12)
              .fontColor($r('app.color.font_tertiary'))
              .margin({ bottom: 5 })

            Text('如有紧急问题，请联系客服')
              .fontSize(12)
              .fontColor($r('app.color.font_tertiary'))
          }
          .width('100%')
          .padding({ bottom: 20 })
        }
        .width('100%')
        .height('100%')
        .backgroundColor($r('app.color.page_bg_color'))
      }
    }
    .hideTitleBar(true)
  }

  // 提交反馈
  async handleSubmitFeedback() {
    const title = this.feedbackTitle.trim();
    const content = this.feedbackContent.trim();

    // 验证输入
    if (title === '') {
      promptAction.showToast({ message: '请输入反馈标题' });
      return;
    }

    if (content === '') {
      promptAction.showToast({ message: '请输入反馈内容' });
      return;
    }

    if (title.length > 50) {
      promptAction.showToast({ message: '标题不能超过50个字符' });
      return;
    }

    if (content.length > 500) {
      promptAction.showToast({ message: '内容不能超过500个字符' });
      return;
    }

    // 检查是否登录
    if (!this.token) {
      promptAction.showToast({ message: '请先登录' });
      return;
    }

    this.isSubmitting = true;

    // 创建HTTP请求
    let httpRequest = http.createHttp();
    const reqData = JSON.stringify({
      title: title,
      content: content
    });

    console.info("=== 反馈请求详情 ===");
    console.info("请求URL:", this.feedbackUrl);
    console.info("请求头: Authorization: Bearer " + this.token);
    console.info("请求参数:", reqData);

    try {
      let res = await httpRequest.request(this.feedbackUrl, {
        method: http.RequestMethod.POST,
        header: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + this.token
        },
        extraData: reqData
      });

      console.info("=== 反馈响应详情 ===");
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
          promptAction.showToast({ message: `提交失败，请稍后重试` });
        }
        return;
      }

      // 解析响应
      let result: FeedbackResponse;
      if (typeof res.result === 'string') {
        try {
          result = JSON.parse(res.result);
        } catch (parseErr) {
          console.error("JSON解析失败:", parseErr);
          promptAction.showToast({ message: '响应数据格式错误' });
          return;
        }
      } else if (typeof res.result === 'object') {
        result = res.result as FeedbackResponse;
      } else {
        console.error("无法识别的响应格式:", typeof res.result);
        promptAction.showToast({ message: '响应格式异常' });
        return;
      }

      console.info("解析后的结果:", JSON.stringify(result));

      if (result.code === 200) {
        // 提交成功
        promptAction.showToast({ message: '反馈已提交' });

        // 清空输入框
        this.feedbackTitle = '';
        this.feedbackContent = '';

        // 延迟返回上一页
        setTimeout(() => {
          this.appPathStack.pop();
        }, 1500);
      } else {
        // 业务错误
        console.error("业务错误码:", result.code, "错误信息:", result.msg);
        promptAction.showToast({
          message: result.msg || '反馈提交失败'
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

      promptAction.showToast({ message: errorMsg });
    } finally {
      this.isSubmitting = false;
      httpRequest.destroy();
    }
  }
}
