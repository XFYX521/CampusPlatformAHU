import { CommonConstants } from '../common/CommonConstants';
import { webview } from '@kit.ArkWeb';

interface TitleEvent {
  title: string;
}

@Component
export struct WebContentPage {
  @Consume('appPathStack') appPathStack: NavPathStack;
  @State pageUrl: string = '';
  @State pageTitle: string = '加载中...';
  @State isLoading: boolean = true;
  @State errorMsg: string = '';
  controller: webview.WebviewController = new webview.WebviewController();
  private retryCount: number = 0;

  aboutToAppear(): void {
    // 从路由参数中获取URL
    const params: Object = this.appPathStack.getParamByName('WebContentPage')[0] as Object;
    if (params !== undefined && params !== null) {
      const paramMap: Record<string, string> = params as Record<string, string>;
      const urlValue = paramMap['url'];
      if (urlValue) {
        this.pageUrl = urlValue;
      }
    }
  }

  build() {
    NavDestination() {
      Column() {
        // 顶部导航栏
        Row() {
          Text('< 返回')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ right: 8 })
            .onClick(() => {
              this.appPathStack.pop();
            })

          Text(this.pageTitle)
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .layoutWeight(1)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Start)
        .width(CommonConstants.FULL_PERCENT)
        .height(54)
        .padding({ left: 14, right: 14 })
        .backgroundColor($r('app.color.comp_background_primary_trans'))

        // Web内容区域
        if (this.pageUrl) {
          Stack() {
            Web({ src: this.pageUrl, controller: this.controller })
              .width(CommonConstants.FULL_PERCENT)
              .layoutWeight(1)
              .userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
              .javaScriptAccess(true)
              .domStorageAccess(true)
              .fileAccess(true)
              .databaseAccess(true)
              .geolocationAccess(true)
              .mixedMode(MixedMode.All)
              .cacheMode(CacheMode.Default)
              .onSslErrorEvent((event) => {
                // 忽略SSL证书错误，继续加载页面（大学网站证书可能不在系统信任链中）
                if (event && event.handler) {
                  event.handler.handleConfirm();
                }
              })
              .onPageBegin(() => {
                this.isLoading = true;
                this.errorMsg = '';
              })
              .onPageEnd(() => {
                this.isLoading = false;
              })
              .onTitleReceive((event?: TitleEvent) => {
                if (event && event.title) {
                  this.pageTitle = event.title;
                }
              })
              .onErrorReceive(() => {
                this.isLoading = false;
                this.errorMsg = '加载失败，请检查网络后重试';
              })
              .onHttpErrorReceive((event) => {
                this.isLoading = false;
                if (event?.response) {
                  this.errorMsg = `HTTP ${event.response.getResponseCode()} - ${event.response.getReasonMessage()}`;
                }
              })

            if (this.isLoading) {
              LoadingProgress()
                .width(48)
                .height(48)
                .color($r('app.color.font_secondary'))
            }

            if (this.errorMsg) {
              Column() {
                Text(this.errorMsg)
                  .fontSize(14)
                  .fontColor($r('app.color.font_secondary'))
                Button('重新加载')
                  .fontSize(14)
                  .margin({ top: 16 })
                  .onClick(() => {
                    this.errorMsg = '';
                    this.isLoading = true;
                    this.controller.refresh();
                  })
              }
              .width(CommonConstants.FULL_PERCENT)
              .layoutWeight(1)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            }
          }
          .width(CommonConstants.FULL_PERCENT)
          .layoutWeight(1)
        } else {
          Column() {
            Text('未提供链接地址')
              .fontSize(16)
              .fontColor($r('app.color.font_secondary'))
          }
          .width(CommonConstants.FULL_PERCENT)
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
      }
      .width(CommonConstants.FULL_PERCENT)
      .height(CommonConstants.FULL_PERCENT)
      .backgroundColor($r('app.color.page_bg_color'))
    }
    .hideTitleBar(true)
  }
}
