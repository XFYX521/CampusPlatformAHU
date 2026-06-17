import { 
  GUIYUAN_DATA, 
  JUYUAN_DATA, 
  MEIYUAN_DATA, 
  WUTONGYUAN_DATA,
  HUIYUAN_DATA,
  LIUYUAN_DATA,
  WAIZHAO_DATA,
  YISHITANG_DATA,
  ERSHITANG_DATA,
  SANSHITANG_DATA,
  FloorItem, 
  WindowItem, 
  FoodItem 
} from '../data/CafeteriaData';
import router from '@ohos.router';

@Entry
@Component
struct CafeteriaDetailPage {
  @State cafeteriaName: string = '';
  @State floorName: string = ''; // 楼层名称（可选）
  @State cafeteriaData: FloorItem[] = [];

  aboutToAppear() {
    // 获取路由参数
    const params = router.getParams() as Record<string, Object>;
    if (params) {
      this.cafeteriaName = params['cafeteriaName'] as string;
      this.floorName = params['floorName'] as string || ''; // 获取楼层名称
      // 根据食堂名称加载对应数据
      this.loadCafeteriaData();
    }
  }

  loadCafeteriaData() {
    // 根据食堂名称匹配数据
    let allData: FloorItem[] = [];
    switch (this.cafeteriaName) {
      case '桂园食堂':
        allData = GUIYUAN_DATA;
        break;
      case '桔园食堂':
        allData = JUYUAN_DATA;
        break;
      case '梅园食堂':
        allData = MEIYUAN_DATA;
        break;
      case '梧桐园食堂':
        allData = WUTONGYUAN_DATA;
        break;
      case '蕙园食堂':
        allData = HUIYUAN_DATA;
        break;
      case '榴园食堂':
        allData = LIUYUAN_DATA;
        break;
      case '外招食堂':
        allData = WAIZHAO_DATA;
        break;
      case '一食堂':
        allData = YISHITANG_DATA;
        break;
      case '二食堂':
        allData = ERSHITANG_DATA;
        break;
      case '三食堂':
        allData = SANSHITANG_DATA;
        break;
      default:
        allData = [];
        break;
    }
    
    // 如果指定了楼层，只显示该楼层数据
    if (this.floorName) {
      this.cafeteriaData = allData.filter(floor => floor.floorName === this.floorName);
    } else {
      this.cafeteriaData = allData;
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

      // 食堂名称（如果有楼层，显示"食堂名 - 楼层名"）
      Text(this.floorName ? `${this.cafeteriaName} - ${this.floorName}` : this.cafeteriaName)
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
        Image($r('app.media.IMG_0219'))
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
