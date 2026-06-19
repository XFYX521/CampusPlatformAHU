import { WindowItem, FoodItem } from '../data/CafeteriaData';
import router from '@ohos.router';

// 展开图标配置（修改此处更换图标）
const EXPAND_ICON_RESOURCE = 'app.media.IMG_0220'; // 图标资源路径
const EXPAND_ICON_SIZE = 20; // 图标大小

@Entry
@Component
struct WindowDetailPage {
  @State windowName: string = '';
  @State windowImage: string = '';
  @State foodList: FoodItem[] = [];
  @State isMenuExpanded: boolean = false; // 菜单列表展开状态（默认关闭）
  
  // 图片预览相关状态
  @State isImagePreview: boolean = false; // 是否显示图片预览
  @State imageScale: number = 1; // 图片缩放比例
  @State pinchStartScale: number = 1; // 捏合手势开始时的缩放值（用于正确计算缩放）
  @State imageOffsetX: number = 0; // 图片X偏移
  @State imageOffsetY: number = 0; // 图片Y偏移

  aboutToAppear() {
    // 获取路由参数
    const params = router.getParams() as Record<string, Object>;
    if (params) {
      this.windowName = params['windowName'] as string || '';
      this.windowImage = params['windowImage'] as string || '';
      // 解析菜品列表
      const foodListStr = params['foodList'] as string;
      if (foodListStr) {
        try {
          this.foodList = JSON.parse(foodListStr) as FoodItem[];
        } catch (e) {
          this.foodList = [];
        }
      }
    }
  }

  // 重置图片状态
  resetImageState() {
    this.imageScale = 1;
    this.imageOffsetX = 0;
    this.imageOffsetY = 0;
  }

  build() {
    Stack() {
      // 主内容区域
      Column() {
        // 顶部导航栏
        this.navigationBar()

        // 内容区域
        Scroll() {
          Column() {
            // 窗口图片（如果有）
            if (this.windowImage && this.windowImage !== '') {
              Image($r(`app.media.${this.windowImage}`))
                .width('100%')
                .height(220)
                .objectFit(ImageFit.Cover)
                .borderRadius(12)
                .margin({ bottom: 16 })
                .onClick(() => {
                  // 点击图片显示预览
                  this.isImagePreview = true;
                  this.resetImageState();
                })
            }

            // 可折叠的菜品列表卡片
            this.collapsibleMenuCard()
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start) // 内容置顶排列
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
        .align(Alignment.Top) // 滚动区域内容置顶
      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.page_bg_color'))

      // 图片预览遮罩层
      if (this.isImagePreview) {
        this.imagePreviewOverlay()
      }
    }
    .width('100%')
    .height('100%')
  }

  // 可折叠的菜品列表卡片
  @Builder
  collapsibleMenuCard() {
    Column() {
      // 标题栏（可点击折叠/展开）
      Row() {
        Text('菜单列表')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.content_main_title_font_color'))
        
        Blank()
          .layoutWeight(1)
        
        // 菜品数量提示
        Text(`${this.foodList.length}道菜品`)
          .fontSize(13)
          .fontColor($r('app.color.font_secondary'))
          .margin({ right: 12 })
        
        // 折叠/展开箭头（修改 EXPAND_ICON_RESOURCE 常量更换图标）
        Image($r(EXPAND_ICON_RESOURCE))
          .width(EXPAND_ICON_SIZE)
          .height(EXPAND_ICON_SIZE)
          .fillColor($r('app.color.font_secondary'))
          .rotate({ angle: this.isMenuExpanded ? 90 : 0 }) // 展开时旋转90度
          .animation({
            duration: 200,
            curve: Curve.EaseInOut
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 14, bottom: 14 })
      .onClick(() => {
        this.isMenuExpanded = !this.isMenuExpanded;
      })
      
      // 分隔线
      if (this.isMenuExpanded) {
        Divider()
          .width('100%')
          .height(0.5)
          .color('#F0F0F0')
          .margin({ left: 16, right: 16 })
      }
      
      // 菜品网格列表（展开时显示）
      if (this.isMenuExpanded && this.foodList.length > 0) {
        Column() {
          Grid() {
            ForEach(this.foodList, (food: FoodItem, index: number) => {
              GridItem() {
                this.foodItemCard(food)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(12)
          .columnsGap(12)
          .width('100%')
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 16 })
      } else if (this.isMenuExpanded && this.foodList.length === 0) {
        // 无数据提示
        Column() {
          Text('暂无菜品信息')
            .fontSize(14)
            .fontColor($r('app.color.font_secondary'))
        }
        .width('100%')
        .padding({ top: 20, bottom: 20 })
      }
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .shadow({ radius: 4, offsetX: 0, offsetY: 2, color: 'rgba(0, 0, 0, 0.05)' })
  }

  // 单个菜品卡片（两列布局中的一项）
  @Builder
  foodItemCard(food: FoodItem) {
    Column() {
      Row() {
        Column() {
          Text(food.name)
            .fontSize(14)
            .fontColor($r('app.color.font_primary'))
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
          
          Text(food.price)
            .fontSize(15)
            .fontColor($r('app.color.button_bg_color'))
            .fontWeight(FontWeight.Medium)
            .margin({ top: 6 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')
    }
    .width('100%')
    .padding(12)
    .backgroundColor($r('app.color.page_bg_color'))
    .borderRadius(8)
  }

  // 图片预览遮罩层
  @Builder
  imagePreviewOverlay() {
    Column() {
      // 顶部关闭按钮
      Row() {
        Blank()
          .layoutWeight(1)
        
        Image($r('app.media.IMG_0223'))
          .width(28)
          .height(28)
          .fillColor(Color.White)
          .onClick(() => {
            this.isImagePreview = false;
            this.resetImageState();
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 48 })
      
      // 图片显示区域
      Column() {
        Image($r(`app.media.${this.windowImage}`))
          .width('100%')
          .objectFit(ImageFit.Contain)
          .scale({ x: this.imageScale, y: this.imageScale })
          .translate({ x: this.imageOffsetX, y: this.imageOffsetY })
          .gesture(
            GestureGroup(GestureMode.Parallel,
              // 双指缩放手势（distance: 0.1 提高触控板灵敏度）
              PinchGesture({ fingers: 2, distance: 0.1 })
                .onActionStart(() => {
                  // 记录手势开始时的缩放值
                  this.pinchStartScale = this.imageScale;
                })
                .onActionUpdate((event: GestureEvent) => {
                  // 正确计算缩放比例：初始缩放值 * 手势缩放比例
                  let newScale = this.pinchStartScale * event.scale;
                  // 限制缩放范围 0.5 - 3
                  if (newScale < 0.5) {
                    newScale = 0.5;
                  } else if (newScale > 3) {
                    newScale = 3;
                  }
                  this.imageScale = newScale;
                })
                .onActionEnd(() => {
                  // 缩放结束后，如果小于1则恢复到1
                  if (this.imageScale < 1) {
                    this.imageScale = 1;
                  }
                  // 重置偏移量
                  this.imageOffsetX = 0;
                  this.imageOffsetY = 0;
                }),
              // 拖动手势（缩放后可拖动）
              PanGesture({ fingers: 1 })
                .onActionUpdate((event: GestureEvent) => {
                  if (this.imageScale > 1) {
                    this.imageOffsetX += event.offsetX;
                    this.imageOffsetY += event.offsetY;
                  }
                })
            )
          )
      }
      .layoutWeight(1)
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        // 点击空白区域关闭（如果缩放为1）
        if (this.imageScale === 1) {
          this.isImagePreview = false;
          this.resetImageState();
        }
      })
      
      // 底部提示
      Text('双指缩放 | 单击关闭')
        .fontSize(14)
        .fontColor('rgba(255, 255, 255, 0.7)')
        .margin({ bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('rgba(0, 0, 0, 0.95)')
  }

  @Builder
  navigationBar() {
    Row() {
      // 返回按钮
      Image($r('app.media.IMG_0221'))
        .width(24)
        .height(24)
        .onClick(() => {
          router.back();
        })

      // 窗口名称
      Text(this.windowName)
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
}
