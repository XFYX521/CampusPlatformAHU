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
import { CommonConstants } from "../common/CommonConstants";

@Component
export struct UserProfileModule {
  @State userName: string = "张三";
  @State userId: string = "2021001001";
  @State userIcon: Resource = $r('app.media.user_photo');
  @Consume('appPathStack') appPathStack: NavPathStack;

  jump(pageName: string = 'EmptyPagePathStack'): void {
    this.appPathStack.pushPathByName(pageName, null);
  }

  build() {
    Row() {
      /**
       * TODO:
       * please modify it according to the actual situation.
       * modify {@link AccountInformationDisplayModule#userIcon}
       */
      Image(this.userIcon)
        .height("40vp")
        .width("40vp")
        .margin({ left: "22vp" })
      Column() {
        /**
         * TODO:
         * please modify it according to the actual situation.
         * modify {@link AccountInformationDisplayModule#userName}
         */
        Text(this.userName)
          .font({ size: $r('app.integer.title_text_M'), weight: FontWeight.Bold })
          .fontColor($r('app.color.font_primary'))
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
        /**
         * TODO:
         * please modify it according to the actual situation.
         * modify {@link AccountInformationDisplayModule#userId}
         */
        Text(this.userId)
          .font({ size: $r('app.integer.body_text_S'), weight: FontWeight.Regular })
          .fontColor($r('app.color.font_secondary'))
          .opacity(0.5)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .margin({ left: "22vp" })
      .height(CommonConstants.FULL_PERCENT)
      .width("60%")
    }
    .onClick(() => {
      this.jump()
    })
    .height("84vp")
    .width('92%')
    .justifyContent(FlexAlign.Start)
    .borderRadius($r('sys.float.corner_radius_level8'))
    .backgroundColor($r('app.color.comp_background_primary_trans'))
    .margin({ bottom: "10vp" })
  }
}