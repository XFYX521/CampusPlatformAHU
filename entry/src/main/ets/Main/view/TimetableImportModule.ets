import { Data, DataSource } from '../viewmodel/TimetableImportModuleData';
import { LoadingStatus } from '../common/CommonEnums';
import LazyDataSource from '../util/LazyDataSource';
import { CommonConstants } from '../common/CommonConstants';
import { BreakpointConstants } from '../common/BreakpointConstants';

@Component
export struct TimetableImportModule {
  @State itemModel: Data = Data.getInstance();
  @State loadingStatus: LoadingStatus = LoadingStatus.OFF;
  @State lazyDataSource: LazyDataSource<DataSource> = this.itemModel.getLazyDataSource();
  @State moduleTitle: string = "练习进度";
  @State moduleRedirectContent: string = '';
  @Consume('appPathStack') appPathStack: NavPathStack;

  aboutToAppear() {
    this.loadResources();
  }

  loadResources(): void {
    this.loadingStatus = LoadingStatus.LOADING;
    this.itemModel.getResources().then(() => {
      this.loadingStatus = LoadingStatus.SUCCESS;
    }).catch(() => {
      this.loadingStatus = LoadingStatus.FAILED;
    });
  }

  jump(pageName: string = 'EmptyPagePathStack'): void {
    this.appPathStack.pushPathByName(pageName, null);
  }

  build() {
    Column() {
      if (this.loadingStatus === LoadingStatus.SUCCESS) {
        TimetableImportModuleTitleInfo({
          title: this.moduleTitle,
          moduleRedirectContent: this.moduleRedirectContent,
          onJump: () => {
            this.jump()
          }
        }).width('92%')
        Column() {
          LazyForEach(this.lazyDataSource, (subject: DataSource, index: number) => {
            ListItem() {
              VerticalStudyTaskProcessItem({
                subject: subject,
                onItemClick: () => this.jump("TimetableImportModuleDetail" + index.toString())
              })
            }
          }, (subject: DataSource, index: number) => subject.getId())
        }
        .width('100%')
        .backgroundColor($r('app.color.background_card_List_VerticalStudyTaskProcessItem'))
        .borderRadius(8)
        .padding({ top: 8, bottom: 8 })
      }
    }
    .width('100%')
  }
}

@Component
struct VerticalStudyTaskProcessItem {
  @Prop subject: DataSource = new DataSource('', '', 0, 0, $r('app.media.noImageBak'));
  onItemClick?: () => void;

  build() {
    Row() {
      Row() {
        Image(this.subject.getIcon())
          .width(26)
          .height(26)
          .margin({ right: 12 })
        Column() {
          Text(this.subject.getName())
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
            .maxLines(1)
          Row() {
            Row() {
              ForEach([1, 2, 3, 4, 5], (item: number) => {
                Image($r('app.media.noImageBak'))
                  .width(14)
                  .height(14)
                  .margin({ right: 2 })
                  .opacity(0.3)
              })
            }

            Text(`${this.subject.getCompleted()}/${this.subject.getTotal()}`)
              .fontSize(12)
              .fontColor($r('app.color.font_tertiary_List_VerticalStudyTaskProcessItem'))
              .margin({ left: 8 })
          }
        }
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 16 })

      Image($r('app.media.ic_right_arrow_filled'))
        .width(14)
        .height(14)
        .margin({ right: 16 })
    }
    .width('100%')
    .padding(8)
    .backgroundColor($r('app.color.background_card_List_VerticalStudyTaskProcessItem'))
    .onClick(() => {
      if (this.onItemClick) {
        this.onItemClick();
      }
    })
  }
}

@Component
export struct TimetableImportModuleTitleInfo {
  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  public title: string = '';
  public moduleRedirectContent: string = '';
  @Consume('appPathStack') appPathStack: NavPathStack;
  public onJump?: () => void;

  jump(): void {
    this.appPathStack.pushPathByName('EmptyPagePathStack', null);
  }

  build() {
    if (this.title.length) {
      Row() {
        Text(this.title)
          .fontSize($r('app.integer.subtitle_text_L'))
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.font_primary'))
        Text(this.moduleRedirectContent)
          .fontColor($r('app.color.font_secondary'))
          .fontSize($r('app.integer.body_text_S'))
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            if (this.onJump) {
              this.onJump()
            } else {
              this.jump()
            }
          })
      }
      .width(CommonConstants.FULL_PERCENT)
      .height("44vp")
      .justifyContent(FlexAlign.SpaceBetween)
      .borderRadius($r('sys.float.corner_radius_level8'))
    }
  }
}