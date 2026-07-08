import { ApiClient } from '../util/ApiClient';

interface PolicyData {
  title: string;
  content: string;
  updateTime?: string;
}

interface PolicyResponse {
  code: number;
  msg: string;
  data?: PolicyData;
}

@Entry
export struct AgreementPage {
  @Consume('appPathStack') appPathStack: NavPathStack;
  @State agreementContent: string = '';
  @State agreementTitle: string = '用户协议';
  @State updateTime: string = '';
  @State isLoading: boolean = true;
  @State loadError: boolean = false;

  aboutToAppear(): void {
    this.fetchUserAgreement();
  }

  async fetchUserAgreement() {
    this.isLoading = true;
    this.loadError = false;
    
    try {
      let res = await ApiClient.get('api/agreement?token=harmong_doc_sk_2024');

      console.info("=== 用户协议响应详情 ===");
      console.info("HTTP状态码:", res.responseCode);
      console.info("响应结果类型:", typeof res.result);
      console.info("响应结果:", res.result);

      if (res.responseCode !== 200) {
        this.loadError = true;
        this.getUIContext().getPromptAction().showToast({ message: `服务器错误: ${res.responseCode}` });
        return;
      }

      let result: PolicyResponse;
      if (typeof res.result === 'string') {
        try {
          result = JSON.parse(res.result);
        } catch (parseErr) {
          console.error("JSON解析失败:", parseErr);
          this.loadError = true;
          this.getUIContext().getPromptAction().showToast({ message: '响应数据格式错误' });
          return;
        }
      } else if (typeof res.result === 'object') {
        result = res.result as PolicyResponse;
      } else {
        this.loadError = true;
        this.getUIContext().getPromptAction().showToast({ message: '响应格式异常' });
        return;
      }

      console.info("解析后的结果:", JSON.stringify(result));

      if (result.code === 200 && result.data) {
        this.agreementTitle = result.data.title || '用户协议';
        this.agreementContent = result.data.content || '';
        this.updateTime = result.data.updateTime || '';
      } else {
        this.loadError = true;
        this.getUIContext().getPromptAction().showToast({ message: result.msg || '获取用户协议失败' });
      }
    } catch (err) {
      this.loadError = true;
      console.error("获取用户协议失败:", err);
      this.getUIContext().getPromptAction().showToast({ message: '网络异常，请稍后重试' });
    } finally {
      this.isLoading = false;
    }
  }

  build() {
    NavDestination() {
      Column() {
        if (this.isLoading) {
          Column() {
            LoadingProgress()
              .width(50)
              .height(50)
              .color($r('app.color.app_icon_pressed_color'))
            Text('加载中...')
              .fontSize(14)
              .fontColor($r('app.color.font_tertiary'))
              .margin({ top: 10 })
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        } else if (this.loadError) {
          Column() {
            Image($r('app.media.IMG_0218'))
              .width(80)
              .height(80)
              .opacity(0.5)
            Text('加载失败')
              .fontSize(16)
              .fontColor($r('app.color.font_tertiary'))
              .margin({ top: 15 })
            Button('重新加载')
              .fontSize(14)
              .fontColor($r('app.color.app_icon_pressed_color'))
              .backgroundColor(Color.Transparent)
              .border({ width: 1, color: $r('app.color.app_icon_pressed_color') })
              .borderRadius(20)
              .margin({ top: 15 })
              .onClick(() => this.fetchUserAgreement())
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        } else {
          Scroll() {
            Column() {
              Text(this.agreementTitle)
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.page_title_font_color'))
                .width('100%')
                .textAlign(TextAlign.Center)
                .margin({ top: 20, bottom: 15 })

              if (this.updateTime) {
                Text(`更新时间：${this.updateTime}`)
                  .fontSize(12)
                  .fontColor($r('app.color.font_tertiary'))
                  .width('100%')
                  .textAlign(TextAlign.Center)
                  .margin({ bottom: 20 })
              }

              Text(this.agreementContent)
                .fontSize(14)
                .fontColor($r('app.color.page_title_font_color'))
                .lineHeight(24)
                .width('100%')
                .padding({ left: 20, right: 20, bottom: 30 })
            }
            .width('100%')
          }
          .scrollable(ScrollDirection.Vertical)
          .scrollBar(BarState.Auto)
          .width('100%')
          .layoutWeight(1)
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.page_bg_color'))
    }
    .title(this.agreementTitle)
  }
}
