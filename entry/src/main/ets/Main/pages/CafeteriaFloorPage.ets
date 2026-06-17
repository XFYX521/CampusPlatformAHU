import router from '@ohos.router';

@Entry
@Component
struct CafeteriaFloorPage {
  @State cafeteriaName: string = '';

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params) {
      this.cafeteriaName = params['cafeteriaName'] as string;
    }
  }

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Image($r('app.media.IMG_0218'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back();
          })
        
        Text(this.cafeteriaName)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        
        Blank()
          .width(24)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // 楼层选择提示
      Text('请选择楼层')
        .fontSize(16)
        .fontColor('#666666')
        .margin({ top: 30, bottom: 20 })

      // 楼层列表
      Column({ space: 16 }) {
        this.FloorCard('一楼', '一楼美食区')
        this.FloorCard('二楼', '二楼美食区')
        this.FloorCard('三楼', '三楼美食区')
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  FloorCard(floorName: string, description: string) {
    Row() {
      Column() {
        Text(floorName)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
        
        Text(description)
          .fontSize(14)
          .fontColor('#999999')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('>')
        .fontSize(20)
        .fontColor('#CCCCCC')
    }
    .width('100%')
    .height(80)
    .padding({ left: 20, right: 20 })
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
    .onClick(() => {
      router.pushUrl({
        url: 'Main/pages/CafeteriaDetailPage',
        params: {
          cafeteriaName: this.cafeteriaName,
          floorName: floorName
        }
      });
    })
  }
}
