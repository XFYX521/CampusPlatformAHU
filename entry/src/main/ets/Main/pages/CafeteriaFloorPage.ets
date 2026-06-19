import { 
  GUIYUAN_DATA, 
  JUYUAN_DATA, 
  FloorItem, 
  WindowItem 
} from '../data/CafeteriaData';
import router from '@ohos.router';

@Entry
@Component
struct CafeteriaFloorPage {
  @State cafeteriaName: string = '';
  @State selectedFloorIndex: number = 0; // 当前选中的楼层索引
  @State allFloorData: FloorItem[] = []; // 所有楼层数据
  @State floorNames: string[] = []; // 楼层名称列表

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params) {
      this.cafeteriaName = params['cafeteriaName'] as string;
      this.loadCafeteriaData();
    }
  }

  loadCafeteriaData() {
    // 根据食堂名称加载数据
    switch (this.cafeteriaName) {
      case '桂园食堂':
        this.allFloorData = GUIYUAN_DATA;
        break;
      case '桔园食堂':
        this.allFloorData = JUYUAN_DATA;
        break;
      default:
        this.allFloorData = [];
        break;
    }
    
    // 提取楼层名称
    this.floorNames = this.allFloorData.map(floor => floor.floorName);
  }

  build() {
    Column() {
      // 顶部标题栏
      this.navigationBar()

      // 楼层选择标签
      if (this.floorNames.length > 0) {
        this.floorTabs()
      }

      // 窗口列表内容
      if (this.allFloorData.length > 0 && this.floorNames.length > 0) {
        this.windowListContent()
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
      Image($r('app.media.IMG_0221'))
        .width(24)
        .height(24)
        .onClick(() => {
          router.back();
        })
      
      Text(this.cafeteriaName)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.content_main_title_font_color'))
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
      
      Blank()
        .width(24)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(Color.White)
  }

  @Builder
  floorTabs() {
    Row() {
      ForEach(this.floorNames, (floorName: string, index: number) => {
        Text(floorName)
          .fontSize(this.selectedFloorIndex === index ? 16 : 14)
          .fontWeight(this.selectedFloorIndex === index ? FontWeight.Bold : FontWeight.Normal)
          .fontColor(this.selectedFloorIndex === index ?
            $r('app.color.button_bg_color') : $r('app.color.font_secondary'))
          .padding({ top: 8, bottom: 8, left: 20, right: 20 })
          .backgroundColor(this.selectedFloorIndex === index ?
            $r('app.color.module_bg_color') : Color.Transparent)
          .borderRadius(20)
          .onClick(() => {
            this.selectedFloorIndex = index;
          })
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 12, bottom: 12 })
    .backgroundColor(Color.White)
  }

  @Builder
  windowListContent() {
    Scroll() {
      Column() {
        // 获取当前选中楼层的数据
        if (this.selectedFloorIndex < this.allFloorData.length) {
          ForEach(this.allFloorData[this.selectedFloorIndex].windowList, (window: WindowItem) => {
            this.windowCard(window)
          })
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 16 })
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .layoutWeight(1)
  }

  @Builder
  windowCard(window: WindowItem) {
    Column() {
      // 窗口图片（如果有）
      if (window.image && window.image !== '') {
        Image($r(`app.media.${window.image}`))
          .width('100%')
          .height(180)
          .objectFit(ImageFit.Cover)
          .borderRadius({ topLeft: 12, topRight: 12 })
      }

      // 窗口名称
      Row() {
        Text(window.windowName)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.content_main_title_font_color'))
          .layoutWeight(1)

        // 右箭头
        Image($r('app.media.IMG_0222'))
          .width(20)
          .height(20)
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 12, bottom: 12 })
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .margin({ bottom: 12 })
    .shadow({ radius: 4, offsetX: 0, offsetY: 2, color: 'rgba(0, 0, 0, 0.05)' })
    .onClick(() => {
      // 跳转到窗口详情页
      router.pushUrl({
        url: 'Main/pages/WindowDetailPage',
        params: {
          windowName: window.windowName,
          windowImage: window.image || '',
          foodList: JSON.stringify(window.foodList)
        }
      });
    })
  }
}
