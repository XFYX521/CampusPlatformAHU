import { DataSource, Data } from '../viewmodel/ScheduleDisplayModuleData';
import LazyDataSource from '../util/LazyDataSource';

@Component
export struct ScheduleDisplayModule {
  @State itemModel: Data = Data.getInstance();
  @State lazyDataSource: LazyDataSource<DataSource> = this.itemModel.getLazyDataSource();
  @State coursesList: DataSource[] = [];
  @State class_title: string = "校园课表";
  @Consume('appPathStack') appPathStack: NavPathStack;

  aboutToAppear() {
    this.itemModel.getResources().then(() => {
      const totalCount = this.lazyDataSource.totalCount();
      if (totalCount > 0) {
        const courses: DataSource[] = [];
        for (let i = 0; i < totalCount; i++) {
          courses.push(this.lazyDataSource.getData(i));
        }
        this.coursesList = courses;
      }
    });
  }

  jump(pageName: string = 'EmptyPagePathStack'): void {
    this.appPathStack.pushPathByName(pageName, null);
  }

  build() {
    Column() {
      Row() {
        Text(this.class_title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.font_primary_Swiper_AILessonInfoCard'))
          .layoutWeight(1)
        Image($r('app.media.ic_right_arrow_filled'))
          .width(14)
          .height(14)
          .fillColor($r('app.color.brand_accent_Swiper_AILessonInfoCard'))
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding(12)

      Column() {
        if (this.coursesList.length > 0) {
          Swiper() {
            ForEach(this.coursesList, (item: DataSource) => {
              CourseCard({ courseData: item })
            })
          }
          .width('100%')
          .height(190)
          .indicator(true)
        }
      }
      .width('96%')
    }
    .width('92%')
    .borderRadius(16)
    .alignItems(HorizontalAlign.Center)
    .margin({ bottom: 8 })
    .linearGradient({
      angle: 180,
      colors: [[$r('app.color.gradient_start_Swiper_AILessonInfoCard'), 0.0],
        [$r('app.color.gradient_end_Swiper_AILessonInfoCard'), 1.0]]
    })
    .padding({ top: 4, bottom: 4 })
  }
}

@Component
struct CourseCard {
  @Prop courseData: DataSource;
  @Consume('appPathStack') appPathStack: NavPathStack;

  jump(pageName: string = 'EmptyPagePathStack'): void {
    this.appPathStack.pushPathByName(pageName, null);
  }

  build() {
    Column() {
      Text(this.courseData.getTitle())
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.font_primary_Swiper_AILessonInfoCard'))
        .width('100%')
        .margin({ bottom: 8 })
      Text(this.courseData.getDescription())
        .fontSize(12)
        .fontColor($r('app.color.font_secondary_Swiper_AILessonInfoCard'))
        .width('100%')
        .margin({ bottom: 12 })
      Row({ space: 12 }) {
        ForEach(this.courseData.getTags(), (tag: string) => {
          CourseTag({ tagText: tag })
        })
      }
      .width('100%')
      .margin({ bottom: 12 })

      Row() {
        Row() {
          ForEach(this.courseData.getTeacherAvatars(), (avatar: Resource) => {
            Image(avatar)
              .width(30)
              .height(30)
              .borderRadius(15)
              .margin({ right: 8 })
          })
        }

        Column() {
          if (this.courseData.isOnSale()) {
            Row() {
              Text('¥')
                .fontSize(14)
                .fontColor($r('app.color.brand_accent_Swiper_AILessonInfoCard'))
                .fontWeight(FontWeight.Bold)
              Text(this.courseData.getPriceRange())
                .fontSize(18)
                .fontColor($r('app.color.brand_accent_Swiper_AILessonInfoCard'))
                .fontWeight(FontWeight.Bold)
            }
            .margin({ bottom: 4 })

            Text(this.courseData.getSaleStatus())
              .fontSize(12)
              .fontColor($r('app.color.brand_accent_Swiper_AILessonInfoCard'))
          } else {
            Text('已停售')
              .fontSize(18)
              .fontColor($r('app.color.font_disabled_Swiper_AILessonInfoCard'))
              .fontWeight(FontWeight.Bold)
              .margin({ top: 6 })
          }
        }
        .alignItems(HorizontalAlign.End)
        .justifyContent(FlexAlign.Center)
        .height(46)
        .width('auto')
      }
      .width('100%')
      .height(40)
      .margin({ bottom: 8 })
      .justifyContent(FlexAlign.SpaceBetween)

      Divider()
        .color($r('sys.color.comp_divider'))
        .width('100%')
        .margin({ bottom: 8 })
      Row() {
        if (this.courseData.isOnSale()) {
          Text(this.courseData.getPurchaseCount() + '人购买 距离停售' + this.courseData.getTimeRemaining())
            .fontSize(12)
            .fontColor($r('app.color.font_tertiary_Swiper_AILessonInfoCard'))
        } else {
          Text(this.courseData.getPurchaseCount() + '人购买')
            .fontSize(12)
            .fontColor($r('app.color.font_tertiary_Swiper_AILessonInfoCard'))
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('92%')
    .height(180)
    .padding(12)
    .backgroundColor($r('app.color.background_card_Swiper_AILessonInfoCard'))
    .borderRadius(12)
  }
}

@Component
struct CourseTag {
  @Prop tagText: string = '';

  build() {
    Text(this.tagText)
      .fontSize(10)
      .fontColor($r('app.color.tag_text_Swiper_AILessonInfoCard'))
      .backgroundColor($r('app.color.tag_background_Swiper_AILessonInfoCard'))
      .borderRadius(4)
      .padding(4)
  }
}