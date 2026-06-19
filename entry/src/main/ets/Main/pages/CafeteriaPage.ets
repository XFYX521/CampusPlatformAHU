import router from '@ohos.router';

const CAMPUS_NAMES: string[] = ['磬苑校区', '龙河校区'];

// 磬苑校区食堂数据（按顺序：New1~New6）
const QINGYUAN_NAMES: string[] = ['桂园食堂', '桔园食堂', '梅园食堂', '梧桐园食堂', '蕙园食堂', '榴园食堂'];
const QINGYUAN_IMAGES: Resource[] = [
  $r('app.media.New1'),
  $r('app.media.New2'),
  $r('app.media.New3'),
  $r('app.media.New4'),
  $r('app.media.New5'),
  $r('app.media.New6'),
];

// 龙河校区食堂数据（按顺序：Old1~Old4）
const LONGHE_NAMES: string[] = ['外招食堂', '一食堂', '二食堂', '三食堂'];
const LONGHE_IMAGES: Resource[] = [
  $r('app.media.Old1'),
  $r('app.media.Old2'),
  $r('app.media.Old4'),
  $r('app.media.Old3'),
];

@Entry
@Component
export struct CafeteriaPage {
  @State campusIndex: number = 0;

  build() {
    Column() {
      // ====== 校区选择标签 ======
      Row() {
        ForEach(CAMPUS_NAMES, (name: string, index: number) => {
          Text(name)
            .fontSize(index === this.campusIndex ? 16 : 14)
            .fontWeight(index === this.campusIndex ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(index === this.campusIndex ?
              $r('app.color.button_bg_color') : $r('app.color.font_secondary'))
            .padding({ top: 8, bottom: 8, left: 20, right: 20 })
            .backgroundColor(index === this.campusIndex ?
              $r('app.color.module_bg_color') : Color.Transparent)
            .borderRadius(20)
            .onClick(() => {
              this.campusIndex = index;
            })
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 12, bottom: 8 })

      // ====== 食堂图片展示 ======
      Scroll() {
        Column() {
          if (this.campusIndex === 0) {
            ForEach(QINGYUAN_NAMES, (name: string, index: number) => {
              this.cafeteriaCard(name, QINGYUAN_IMAGES[index])
            })
          } else {
            ForEach(LONGHE_NAMES, (name: string, index: number) => {
              this.cafeteriaCard(name, LONGHE_IMAGES[index])
            })
          }
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_bg_color'))
  }

  @Builder
  cafeteriaCard(name: string, imageRes: Resource) {
    Column() {
      Image(imageRes)
        .width('100%')
        .height(180)
        .objectFit(ImageFit.Cover)
        .borderRadius({ topLeft: 12, topRight: 12 })

      Row() {
        Text(name)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.content_main_title_font_color'))
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 10, bottom: 10 })
      .backgroundColor(Color.White)
      .borderRadius({ bottomLeft: 12, bottomRight: 12 })
    }
    .width('100%')
    .margin({ bottom: 16 })
    .borderRadius(12)
    .shadow({ radius: 6, offsetX: 0, offsetY: 2, color: 'rgba(0, 0, 0, 0.06)' })
    .onClick(() => {
      // 桂园、桔园、梅园和榴园跳转到楼层选择页，其他食堂直接跳转到详情页
      if (name === '桂园食堂' || name === '桔园食堂' || name === '梅园食堂' || name === '榴园食堂') {
        router.pushUrl({
          url: 'Main/pages/CafeteriaFloorPage',
          params: {
            cafeteriaName: name
          }
        });
      } else {
        router.pushUrl({
          url: 'Main/pages/CafeteriaDetailPage',
          params: {
            cafeteriaName: name
          }
        });
      }
    })
  }
}
