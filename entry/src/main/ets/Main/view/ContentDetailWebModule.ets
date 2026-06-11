/*
* Copyright (c) 2025 Huawei Device Co., Ltd.
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
import { CommonConstants } from '../common/CommonConstants';
import {
  Data, DataSource
} from '../viewmodel/ContentDetailWebModuleData';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { componentUtils } from '@kit.ArkUI';

@Component
export struct ContentDetailWebModule {
  @State itemModel: Data =
    Data.getInstance();
  @State currentIndex: number = 0;
  @State tabArray: string[] = ['教务通知', '新闻动态'];
  @State title: string = "校园信息";
  @State indicatorLeftMargin: number = 110;
  @State indicatorWidth: number = 0;
  @State tabsWidth: number = 0;
  private controller: TabsController = new TabsController();
  private tabLeftOffset: number = 0;
  private animationDuration: number = 300;
  @Consume('appPathStack') appPathStack: NavPathStack;

  jump(pageName: string = 'EmptyPagePathStack'): void {
    this.appPathStack.pushPathByName(pageName, null);
  }

  @Builder
  TabBuilder(tabName: string, tabIndex: number) {
    Row() {
      Text(tabName)
        .fontSize($r('app.integer.subtitle_text_S'))
        .lineHeight(22)
        .fontColor(tabIndex === this.currentIndex ? $r('app.color.brand_primary_Tab_List_H_FinanceItemSinaNews') :
          $r('app.color.font_tab_inactive_Tab_List_H_FinanceItemSinaNews'))
        .id(tabIndex.toString())
        .onAreaChange((_, newValue: Area) => {
          if (this.currentIndex === tabIndex && (this.indicatorLeftMargin === 0 || this.indicatorWidth === 0)) {
            let positionX: number;
            let width: number = Number.parseFloat(newValue.width.toString());
            if (newValue.position.x !== undefined) {
              positionX = Number.parseFloat(newValue.position.x?.toString())
              this.indicatorLeftMargin = Number.isNaN(positionX) ? 110 : positionX + 110;
            }
            this.indicatorWidth = width / 3;
          }
        })
    }
    .justifyContent(FlexAlign.Center)
    .constraintSize({ minWidth: 35 })
    .width(64)
    .height(35)
    .onClick(() => {
      this.controller.changeIndex(tabIndex);
      this.currentIndex = tabIndex;
    })
  }

  build() {
    Column() {
      Column() {
        Stack({ alignContent: Alignment.TopStart }) {
          // The text of tab.
          Row() {
            Text(this.title)
            ForEach(this.tabArray, (item: string, index: number) => {
              this.TabBuilder(item, index);
            }, (item: number, _index: number) => item.toString())
            Blank()
            Image($r('app.media.ic_right_arrow_filled'))
              .width(10)
              .height(10)
              .onClick(() => {
                this.jump();
              })
          }
          .justifyContent(FlexAlign.Start)
          .width(CommonConstants.FULL_PERCENT)
          .height('30vp')
          .padding({ top: 5 })

          // The underline of tab.
          Column()
            .width(this.indicatorWidth)
            .height(1.5)
            .backgroundColor($r('app.color.indicator_primary_Tab_List_H_FinanceItemSinaNews'))
            .borderRadius(1)
            .margin({ left: this.indicatorLeftMargin, top: 30 })
        }
        .height(38)
        .margin({ left: this.tabLeftOffset })

        Tabs({ controller: this.controller }) {
          ForEach(this.tabArray, (item: string, index: number) => {
            TabContent() {
              List_H_GraphicTextItem({ item: this.itemModel.getItemModel()[index], idx: index })
            }
          }, (item: number, _index: number) => item.toString())
        }
        .width('auto')
        .height('auto')
        .borderRadius($r('sys.float.corner_radius_level8'))
        .onAreaChange((_, newValue: Area) => {
          this.tabsWidth = Number.parseFloat(newValue.width.toString());
        })
        .barWidth(CommonConstants.FULL_PERCENT)
        .barHeight(0)
        .animationDuration(this.animationDuration)
        // swipe by touch.
        .onGestureSwipe((index: number, event: TabsAnimationEvent) => {
          let currentIndicator = this.getCurrentIndicatorInfo(index, event);
          this.currentIndex = currentIndicator.index;
          this.indicatorWidth = currentIndicator.width / 3;
          this.indicatorLeftMargin = currentIndicator.left + this.indicatorWidth;
        })
        // swipe by click tab.
        .onAnimationStart((_index: number, targetIndex: number, _event: TabsAnimationEvent) => {
          this.currentIndex = targetIndex;
          let targetIndexInfo = this.getTextInfo(targetIndex);
          this.startAnimateTo(this.animationDuration, targetIndexInfo.left, targetIndexInfo.width);
        })
      }
      .width('92%')
    }
    .width(CommonConstants.FULL_PERCENT)
    .backgroundColor($r('app.color.comp_background_primary_trans'))
  }

  private getCurrentIndicatorInfo(index: number, event: TabsAnimationEvent): Record<string, number> {
    let nextIndex = index;
    if (index > 0 && event.currentOffset > 0) {
      // swipe to left.
      nextIndex--;
    } else if (index < this.tabArray.length && event.currentOffset > 0) {
      // swipe to right.
      nextIndex++;
    } else {
      // error condition.
      hilog.info(0x0000, 'leftTab', 'the index is out of boundary: %{public}s', index);
    }
    let indexInfo = this.getTextInfo(index);
    let nextIndexInfo = this.getTextInfo(index);
    let swipeRatio = Math.abs(event.currentOffset / this.tabsWidth);
    let currentIndex = swipeRatio > 0.5 ? nextIndex : index;
    let currentIndicatorLeft: number = indexInfo.left + (nextIndexInfo.left - indexInfo.left) * swipeRatio;
    let currentIndicatorWidth: number = indexInfo.width + (nextIndexInfo.width - indexInfo.width) * swipeRatio;
    return { 'index': currentIndex, 'left': currentIndicatorLeft, 'width': currentIndicatorWidth };
  }

  private getTextInfo(index: number): Record<string, number> {
    let modePosition: componentUtils.ComponentInfo = componentUtils.getRectangleById(index.toString());
    return { 'left': px2vp(modePosition.windowOffset.x), 'width': px2vp(modePosition.size.width) };
  }

  private startAnimateTo(duration: number, leftMargin: number, width: number) {
    animateTo({
      duration: duration,
      curve: Curve.Linear,
      iterations: 1,
      playMode: PlayMode.Normal,
    }, () => {
      this.indicatorWidth = width / 3;
      this.indicatorLeftMargin = leftMargin + this.indicatorWidth;
    })
  }
}

@Component
export struct List_H_GraphicTextItem {
  @State itemModel: Data =
    Data.getInstance();
  @State item: DataSource = new DataSource([], [], []);
  @State idx: number = 0;
  @Consume('appPathStack') appPathStack: NavPathStack;

  jump(pageName: string = 'EmptyPagePathStack'): void {
    this.appPathStack.pushPathByName(pageName, null);
  }

  build() {
    Column() {
      List({ space: 7 }) {
        ForEach(this.item.getIcon(), (item: Resource, index: number) => {
          ListItem() {
            GraphicTextItem({
              image: this.itemModel.getHeadPhoneIcon(),
              icon: this.item.getIcon()[index],
              description: this.item.getDescription()[index],
              title: this.item.getTitle()[index]
            })
          }
          .onClick(() => {
            this.jump("List_H_GraphicTextItemDetail" + index.toString())
          })
        }, (item: DataSource, index: number) => index + JSON.stringify(item))
      }
      .height('auto')
      .width('auto')
      .listDirection(Axis.Horizontal)
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
      .alignListItem(ListItemAlign.Center)
      .scrollBar(BarState.Off)
    }
  }
}

@Component
export struct GraphicTextItem {
  @State image: Resource = $r('app.media.ic_public_app');
  @State title: string = "校园信息";
  @State description: string = '跳转';
  @State icon: Resource = $r('app.media.ic_public_app');

  constructor(image: Resource, title: string, description: string, icon: Resource) {
    super();
    this.image = image;
    this.title = title;
    this.description = description;
    this.icon = icon;
  }

  build() {
    Column() {
      Image(this.icon)
        .width(105)
        .autoResize(true)
        .borderRadius($r('sys.float.corner_radius_level2'))
      Text(this.title)
        .fontColor($r('app.color.font_primary'))
        .fontSize($r('app.integer.subtitle_text_S'))
        .fontWeight(FontWeight.Medium)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(1)
        .opacity(0.8)
        .width(CommonConstants.FULL_PERCENT)
        .margin({ top: 5, bottom: 3 })
      Row() {
        Image(this.image)
          .width(12)
          .height(12)
        Text(this.description)
          .fontColor($r('app.color.font_secondary'))
          .fontSize($r('app.integer.body_text_S'))
          .fontWeight(FontWeight.Regular)
          .textAlign(TextAlign.Center)
      }
      .opacity(0.8)
      .justifyContent(FlexAlign.Center)
    }
    .width(105)
    .justifyContent(FlexAlign.Start)
    .padding({ bottom: 10 })
    .alignItems(HorizontalAlign.Start)
  }
}