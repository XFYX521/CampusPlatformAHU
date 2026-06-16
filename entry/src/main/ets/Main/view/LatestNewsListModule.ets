import { BreakpointConstants } from '../common/BreakpointConstants';
import { CommonConstants } from '../common/CommonConstants';

@Component
export struct LatestNewsListModule {
  @State image: Resource = $r('app.media.noImage');
  @State mainText: string = '学校举办春季运动会';
  @State subText: string = '各院系积极参与比赛';
  @State commentCount: number = 42;
  @State mediaSource: string = '校园新闻网';
  @State publishTime: string = '2024-03-15';
  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_SM;

  build() {
    Row() {
      Column() {
        Text(this.mainText)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .padding({ bottom: 4 })
          .width(CommonConstants.FULL_PERCENT)
        Row() {
          Row({ space: 4 }) {
            Image($r('app.media.ic_public_comments'))
              .width(16)
              .height(16)
            Text(this.commentCount.toString())
              .fontSize(12)
              .fontColor($r('app.color.text_secondary_News_HorizontalGraphicTextItem'))
          }
          .margin({ right: 8 })

          Text(this.mediaSource)
            .fontSize(12)
            .fontColor($r('app.color.text_secondary_News_HorizontalGraphicTextItem'))
            .margin({ right: 8 })
          Text(this.publishTime)
            .fontSize(12)
            .fontColor($r('app.color.text_secondary_News_HorizontalGraphicTextItem'))
        }
        .width(CommonConstants.FULL_PERCENT)
        .alignItems(VerticalAlign.Center)
      }
      .padding({ right: 6 })
      .width('65%')
      .height('90%')
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceBetween)

      Image(this.image)
        .borderRadius($r('sys.float.corner_radius_level6'))
        .height('90%')
        .width('35%')
    }
    .height(90)
    .width(CommonConstants.FULL_PERCENT)
    .backgroundColor($r('app.color.background_primary_News_HorizontalGraphicTextItem'))
    .padding({ left: 8, right: 8 })
  }
}