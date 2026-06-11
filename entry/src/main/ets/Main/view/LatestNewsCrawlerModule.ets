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
import { LoadingStatus } from '../common/CommonEnums';
import { LoadingFailedView } from '../view/LoadingFailedView';
import { BreakpointConstants } from '../common/BreakpointConstants';
import { BreakpointType } from '../util/BreakpointType';
import LazyDataSource from '../util/LazyDataSource';
import { CommonConstants } from '../common/CommonConstants'
import {
  HorizontalTextButtonFunctionItemModel, Data
} from '../viewmodel/LatestNewsCrawlerModuleData';

@Component
export struct LatestNewsCrawlerModule {
  @State itemModel: Data =
    Data.getInstance();
  @State moduleTitle: string = "教务处通知公告与资讯";
  @State moduleRedirectContent: string = "查看更多";
  @State loadingStatus: LoadingStatus = LoadingStatus.OFF;
  @State lazyDataSource: LazyDataSource<HorizontalTextButtonFunctionItemModel> =
    this.itemModel.lazyDataSource;
  private spaceArray: string[] = ['12vp', '16vp', '20vp'];
  @Consume('appPathStack') appPathStack: NavPathStack;
  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_SM;

  jump(pageName: string = 'EmptyPagePathStack'): void {
    this.appPathStack.pushPathByName(pageName, null);
  }

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

  build() {
    Column() {
      LatestNewsCrawlerModuleTitleInfo({
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
          LazyForEach(this.lazyDataSource, (item: HorizontalTextButtonFunctionItemModel, index: number) => {
            ListItem() {
              HorizontalTextButtonFunctionItem({
                title: item.getTitle(),
                subTitle: item.getSubTitle(),
                buttonValue: item.getButtonValue()
              })
            }
            .height(70)
            .onClick(() => {
              this.jump("LatestNewsCrawlerModuleDetail" + index.toString())
            })
          }, (item: HorizontalTextButtonFunctionItemModel, index: number) => index + JSON.stringify(item))
        }
        .width('auto')
        .height('auto')
        .divider({ "strokeWidth": 1 })
        .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
        .lanes(this.currentWidthBreakpoint === BreakpointConstants.BREAKPOINT_SM ? 1 : 2,
          "12vp")
        .listDirection(Axis.Vertical)
      }
    }
    .width('92%')
    .borderRadius($r('sys.float.corner_radius_level8'))
    .margin({ bottom: "10vp" })
  }
}

@Component
export struct HorizontalTextButtonFunctionItem {
  @State title: string = 'xxxx'
  @State subTitle: string = 'xxxx，xxxxxxx~'
  @State buttonValue: string = '+ xxxxx'
  @Consume('appPathStack') appPathStack: NavPathStack;

  jump(pageName: string = 'EmptyPagePathStack'): void {
    this.appPathStack.pushPathByName(pageName, null);
  }

  build() {
    Column() {
      Text(this.title)
        .width('80%')
        .height('40%')
        .fontSize($r('app.integer.subtitle_text_S'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.font_primary'))
      Row() {
        Text(this.subTitle)
          .width('80%')
          .height(CommonConstants.FULL_PERCENT)
          .fontSize($r('app.integer.body_text_S'))
          .fontColor($r('app.color.font_secondary'))
          .fontWeight(FontWeight.Regular)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(this.buttonValue)
          .fontSize($r('app.integer.caption_text_M'))
          .fontColor($r('app.color.font_on_primary'))
          .backgroundColor($r('app.color.comp_background_emphasize'))
          .padding({
            left: 6,
            right: 6,
            top: 4,
            bottom: 4
          })
          .borderRadius($r('sys.float.corner_radius_level4'))
          .onClick(() => {
            this.jump()
          })
      }
      .width(CommonConstants.FULL_PERCENT)
      .height('60%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .padding({
      left: 12,
      right: 12,
      top: 8,
      bottom: 8
    })
    .borderRadius($r('sys.float.corner_radius_level4'))
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r('app.color.comp_background_primary_trans'))
  }
}

@Component
export struct LatestNewsCrawlerModuleTitleInfo {
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