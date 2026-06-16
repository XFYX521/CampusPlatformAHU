import { GUIYUAN_DATA, JUYUAN_DATA, FloorItem, WindowItem, FoodItem } from '../data/CafeteriaData';
import router from '@ohos.router';

@Entry
@Component
struct CafeteriaDetailPage {
  @State cafeteriaName: string = '';
  @State cafeteriaData: FloorItem[] = [];

  aboutToAppear() {
    // 获取路由参数
    const params = router.getParams() as Record<string, Object>;
    if (params) {
      this.cafeteriaName = params['cafeteriaName'] as string;
      // 根据食堂名称加载对应数据
      this.loadCafeteriaData();
    }
  }

  loadCafeteriaData() {
    // 根据食堂名称匹配数据
    switch (this.cafeteriaName) {
      case '桂园食堂':
        this.cafeteriaData = GUIYUAN_DATA;
        break;
      case '桔园食堂':
        this.cafeteriaData = JUYUAN_DATA;
        break;
      // 其他食堂待补充
      default:
        this.cafeteriaData = [];
        break;
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      this.navigationBar()

      // 内容区域
      if (this.cafeteriaData.length > 0) {
        Scroll() {
          Column() {
            ForEach(this.cafeteriaData, (floor: FloorItem) => {
              this.floorSection(floor)
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 16 })
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      } else {
        // 无数据提示
        Column() {
          Text('暂无菜单数据')
            .fontSize(16)
            .fontColor($r('app.color.font_secondary'))
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_bg_color'))
  }

  @Builder
  navigationBar() {
    Row() {
      // 返回按钮
      Image($r('app.media.IMG_0218'))
        .width(24)
        .height(24)
        .onClick(() => {
          router.back();
        })

      // 食堂名称
      Text(this.cafeteriaName)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.content_main_title_font_color'))
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      // 占位，保持标题居中
      Blank()
        .width(24)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(Color.White)
  }

  @Builder
  floorSection(floor: FloorItem) {
    Column() {
      // 楼层标题
      Text(floor.floorName)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.content_main_title_font_color'))
        .width('100%')
        .margin({ top: 16, bottom: 12 })

      // 窗口列表
      ForEach(floor.windowList, (window: WindowItem) => {
        this.windowCard(window)
      })
    }
    .width('100%')
  }

  @Builder
  windowCard(window: WindowItem) {
    Column() {
      // 窗口名称
      Text(window.windowName)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.content_main_title_font_color'))
        .width('100%')
        .padding({ left: 12, top: 12, bottom: 8 })

      // 菜品列表
      Column() {
        ForEach(window.foodList, (food: FoodItem, index: number) => {
          Row() {
            Text(food.name)
              .fontSize(14)
              .fontColor($r('app.color.font_primary'))
              .layoutWeight(1)

            Text(food.price)
              .fontSize(14)
              .fontColor($r('app.color.button_bg_color'))
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          
          // 分隔线（最后一项不显示）
          if (index < window.foodList.length - 1) {
            Divider()
              .width('100%')
              .height(0.5)
              .color('#F0F0F0')
              .margin({ left: 12, right: 12 })
          }
        })
      }
      .width('100%')
      .padding({ bottom: 12 })
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .margin({ bottom: 12 })
    .shadow({ radius: 4, offsetX: 0, offsetY: 2, color: 'rgba(0, 0, 0, 0.05)' })
  }
}
