/*
* Copyright (c) 2024 Huawei Device Co., Ltd.
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
import {
  DataSource, Data
} from '../viewmodel/PlaceholderModuleData';
import { LoadingStatus } from '../common/CommonEnums';
import { LoadingFailedView } from '../view/LoadingFailedView';
import { BreakpointConstants } from '../common/BreakpointConstants';
import { BreakpointType } from '../util/BreakpointType';
import LazyDataSource from '../util/LazyDataSource';
import { CommonConstants } from '../common/CommonConstants';

@Component
export struct PlaceholderModule {
  @State itemModel: Data =
    Data.getInstance();
  @Prop listDirection: Axis = Axis.Vertical
  @State moduleTitle: string = "校园信息聚合";
  @State moduleRedirectContent: string = "查看更多";
  @State loadingStatus: LoadingStatus = LoadingStatus.OFF;
  @State lazyDataSource: LazyDataSource<DataSource> =
    this.itemModel.lazyDataSource;
  private spaceArray: string[] = ['8vp', '6vp', '10vp'];
  private lanesArray: number[] = [1, 2, 3];
  @Consume('appPathStack') appPathStack: NavPathStack;
  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_SM;

  aboutToAppear() {
    this.loadResources();
  }

  jump(pageName: string = 'EmptyPagePathStack'): void {
    this.appPathStack.pushPathByName(pageName, null);
  }

  loadResources(): void {
    this.loadingStatus = LoadingStatus.LOADING;
    this.itemModel.getResources().then(() => {
      this.loadingStatus = LoadingStatus.SUCCESS;
    }).catch(() => {
      this.loadingStatus = LoadingStatus.FAILED;
    });
  }

  build() {
    Column() {
      Column() {
        PlaceholderModuleTitleInfo({
          title: this.moduleTitle,
          moduleRedirectContent: this.moduleRedirectContent,
          onJump: () => {
            this.jump()
          }
        })
        if (this.loadingStatus === LoadingStatus.FAILED) {
          LoadingFailedView(() => this.loadResources())
        }
        if (this.loadingStatus === LoadingStatus.SUCCESS) {
          List({
            space: new BreakpointType(this.spaceArray[0], this.spaceArray[1],
              this.spaceArray[2]).getValue(this.currentWidthBreakpoint)
          }) {
            LazyForEach(this.lazyDataSource, (item: DataSource, index: number) => {
              ListItem() {
                HorizontalGraphicTextDisplayItem1({
                  image: item.getImage(),
                  mainText: item.getMainText(),
                  subText: item.getSubText(),
                  descriptionText: item.getDescriptionText()
                })
              }
              .height("150vp")
              .borderRadius($r('sys.float.corner_radius_level8'))
              .backgroundColor($r('app.color.comp_background_primary'))
              .onClick(() => {
                this.jump("PlaceholderModuleDetail" + index.toString())
              })
            }, (item: DataSource, index: number) => index + JSON.stringify(item))
          }
          .width('auto')
          .height('auto')
          .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
          .listDirection(this.listDirection)
          .lanes(new BreakpointType(this.lanesArray[0], this.lanesArray[1],
            this.lanesArray[2]).getValue(this.currentWidthBreakpoint), "12vp")
        }
      }
      .width('92%')
      .borderRadius($r('sys.float.corner_radius_level8'))
      .margin({ bottom: "10vp" })
    }
    .width('100%')
  }
}

@Component
export struct HorizontalGraphicTextDisplayItem1 {
  @State image: Resource = $r('app.media.noImage');
  @State mainText: string = '主标题文本';
  @State subText: string = '子标题文本';
  @State descriptionText: string = '这是一个描述文本，用于展示一些详细信息。';
  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_SM;

  build() {
    Row() {
      Image(this.image)
        .borderRadius($r('sys.float.corner_radius_level6'))
        .height('80%')
        .width('33%')
        .margin({ left: 15, right: 15 })
      Column() {
        Text(this.mainText)
          .fontSize($r('app.integer.subtitle_text_M'))
          .fontColor($r('app.color.content_font_color'))
          .fontWeight(FontWeight.Bold)
          .padding({ bottom: 2 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .height('20%')
          .width(CommonConstants.FULL_PERCENT)
        Text(this.subText)
          .fontSize($r('app.integer.body_text_S'))
          .fontColor($r('app.color.content_sub_title_font_color'))
          .fontWeight(FontWeight.Regular)
          .padding({ bottom: 4 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .height('20%')
          .width(CommonConstants.FULL_PERCENT)
        Text(this.descriptionText)
          .fontSize($r('app.integer.caption_text_L'))
          .fontColor($r('app.color.description_font_color_List_HorizontalGraphicTextDisplayItem1'))
          .padding({ bottom: 4 })
          .maxLines(3)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .height('50%')
          .width(CommonConstants.FULL_PERCENT)
      }
      .padding({ right: 15 })
      .width('60%')
      .height('80%')
      .alignItems(HorizontalAlign.Start)
    }
    .height(CommonConstants.FULL_PERCENT)
    .width(CommonConstants.FULL_PERCENT)
  }
}

@Component
export struct PlaceholderModuleTitleInfo {
  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  public title: string = '';
  public moduleRedirectContent: string = "查看更多";
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