import { webview } from '@kit.ArkWeb';
import { CommonConstants } from '../common/CommonConstants';
import { BreakpointConstants } from '../common/BreakpointConstants';

@Component
export struct NewsPage {
  @Consume('appPathStack') appPathStack: NavPathStack;
  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_SM;

  private readonly JWKX_URL: string = 'https://jwc.ahu.edu.cn/jwkx/list.htm';
  private readonly NOTICE_URL: string = 'https://jwc.ahu.edu.cn/10314/list.htm';

  private jwkxController: webview.WebviewController = new webview.WebviewController();
  private noticeController: webview.WebviewController = new webview.WebviewController();

  @Builder
  sectionHeader(title: string): void {
    Row() {
      Text(title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.font_primary'))
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(44)
    .padding({ left: 16, right: 16 })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    NavDestination() {
      Column() {
        // ====== 顶部导航栏 ======
        Row() {
          Text('< 返回')
            .fontSize(16)
            .fontColor($r('app.color.font_primary'))
            .onClick(() => {
              this.appPathStack.pop();
            })

          Blank()

          Text('教务资讯')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.page_title_font_color'))

          Blank()
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .alignItems(VerticalAlign.Center)
        .backgroundColor(Color.White)

        // ========== 教务快讯 ==========
        Column() {
          this.sectionHeader('教务快讯')

          Web({ src: this.JWKX_URL, controller: this.jwkxController })
            .width('100%')
            .layoutWeight(1)
            .javaScriptAccess(true)
            .domStorageAccess(true)
            .onLoadIntercept((event) => {
              // 模拟器 mock Web 组件 event.data 或其方法可能为 undefined
              if (!event || !event.data) {
                return false;
              }
              // 检查方法是否存在
              if (typeof event.data.isMainFrame !== 'function' || typeof event.data.getRequestUrl !== 'function') {
                return false;
              }
              if (!event.data.isMainFrame()) {
                return false;
              }
              const url: string = event.data.getRequestUrl();
              // URL 包含 "list.htm" 的是列表页本身（含 WAF 重定向、分页），不拦截
              if (url.includes('list.htm')) {
                return false;
              }
              const param: Record<string, string> = { 'url': url };
              this.appPathStack.pushPathByName('WebContentPage', param as Object);
              return true;
            })
            .overviewModeAccess(true)
            .onPageEnd(() => {
              try {
                // 滚动跳过网页顶部导航区域，使内容直接可见
                this.jwkxController.runJavaScript('window.scrollTo(0, 300);');
              } catch (error) {
                console.error('JWKX scroll error: ' + error);
              }
            })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor($r('app.color.comp_background_primary_trans'))
        .borderRadius(12)
        .margin({ top: 12, bottom: 6, left: 12, right: 12 })
        .clip(true)

        // ========== 通知公告 ==========
        Column() {
          this.sectionHeader('通知公告')

          Web({ src: this.NOTICE_URL, controller: this.noticeController })
            .width('100%')
            .layoutWeight(1)
            .javaScriptAccess(true)
            .domStorageAccess(true)
            .onLoadIntercept((event) => {
              if (!event || !event.data) {
                return false;
              }
              // 检查方法是否存在
              if (typeof event.data.isMainFrame !== 'function' || typeof event.data.getRequestUrl !== 'function') {
                return false;
              }
              if (!event.data.isMainFrame()) {
                return false;
              }
              const url: string = event.data.getRequestUrl();
              if (url.includes('list.htm')) {
                return false;
              }
              const param: Record<string, string> = { 'url': url };
              this.appPathStack.pushPathByName('WebContentPage', param as Object);
              return true;
            })
            .overviewModeAccess(true)
            .onPageEnd(() => {
              try {
                // 滚动跳过网页顶部导航区域，使内容直接可见
                this.noticeController.runJavaScript('window.scrollTo(0, 300);');
              } catch (error) {
                console.error('NOTICE scroll error: ' + error);
              }
            })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor($r('app.color.comp_background_primary_trans'))
        .borderRadius(12)
        .margin({ top: 6, bottom: 12, left: 12, right: 12 })
        .clip(true)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor($r('app.color.page_bg_color'))
    }
    .hideTitleBar(true)
  }
}
