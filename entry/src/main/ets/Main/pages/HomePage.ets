import { CommonConstants } from '../common/CommonConstants';
import { webview } from '@kit.ArkWeb';

@Component
export struct HomePage {
  @Consume('appPathStack') appPathStack: NavPathStack;
  private scroller: Scroller = new Scroller();
  private calendarController1: webview.WebviewController = new webview.WebviewController();
  private calendarController2: webview.WebviewController = new webview.WebviewController();
  @State calendarIndex: number = 0;
  @State calendarHeight: number = 500;

  build() {
    Scroll(this.scroller) {
      Column() {
        // 校历标题
        Text('安徽大学校历')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.page_title_font_color'))
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 16, bottom: 8 })

        // 校历 — 左右滑动切换，每半页全宽占满上半区域
        Column() {
          Swiper() {
            // 上学期 — 左半页 PDF 全宽显示
            Stack() {
              Web({ src: $rawfile('calendar_left.html'), controller: this.calendarController1 })
                .width('100%')
                .height(this.calendarHeight)
                .backgroundColor(Color.White)
                .domStorageAccess(true)
                .hitTestBehavior(HitTestMode.None)
            }
            .width('100%')
            .height(this.calendarHeight)
            .clip(true)

            // 下学期 — 右半页 PDF 全宽显示
            Stack() {
              Web({ src: $rawfile('calendar_right.html'), controller: this.calendarController2 })
                .width('100%')
                .height(this.calendarHeight)
                .backgroundColor(Color.White)
                .domStorageAccess(true)
                .hitTestBehavior(HitTestMode.None)
            }
            .width('100%')
            .height(this.calendarHeight)
            .clip(true)
          }
          .width('100%')
          .height(this.calendarHeight)
          .backgroundColor(Color.White)
          .indicator(false)
          .loop(false)
          .curve(Curve.FastOutLinearIn)
          .onChange((index: number) => {
            this.calendarIndex = index;
          })

          // 底部指示点
          Row() {
            Row() {
              Text('第一学期')
                .fontSize(11)
                .fontColor(this.calendarIndex === 0 ? '#4F81BD' : '#CCCCCC')
              Text('   |   ')
                .fontSize(11)
                .fontColor('#DDDDDD')
              Text('第二学期')
                .fontSize(11)
                .fontColor(this.calendarIndex === 1 ? '#4F81BD' : '#CCCCCC')
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ top: 6, bottom: 4 })
        }
        .width('100%')
        .backgroundColor(Color.White)
        .padding({ bottom: 8 })

        // 功能按钮区
        Row() {
          // 地图按钮
          Column() {
            Image($r('app.media.lib_icon_Map'))
              .width(48)
              .height(48)
              .objectFit(ImageFit.Contain)
              .fillColor($r('app.color.module_icon_color'))
            Text('校园地图')
              .fontSize(14)
              .fontColor($r('app.color.module_title_font_color'))
              .margin({ top: 6 })
          }
          .width('45%')
          .aspectRatio(2.0)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .borderWidth(1)
          .borderColor('#E8E8E8')
          .borderStyle(BorderStyle.Solid)
          .onClick(() => {
            this.openMapPage();
          })

          Blank().width('10%')

          // 资讯按钮
          Column() {
            Image($r('app.media.lib_icon_News'))
              .width(48)
              .height(48)
              .objectFit(ImageFit.Contain)
              .fillColor($r('app.color.module_icon_color'))
            Text('教务资讯')
              .fontSize(14)
              .fontColor($r('app.color.module_title_font_color'))
              .margin({ top: 6 })
          }
          .width('45%')
          .aspectRatio(2.0)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .borderWidth(1)
          .borderColor('#E8E8E8')
          .borderStyle(BorderStyle.Solid)
          .onClick(() => {
            this.appPathStack.pushPathByName('NewsPage', {} as Record<string, Object>);
          })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 16 })
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.page_bg_color'))
  }

  openMapPage(): void {
    const urlParam: Record<string, string> = { 'url': 'https://map.ahu.edu.cn/#/home' };
    this.appPathStack.pushPathByName('WebContentPage', urlParam as Object);
  }
}
