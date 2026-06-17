/*
* Copyright (c) 2023 Huawei Device Co., Ltd.
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
import { EmptyPagePathStack } from '../detail/EmptyPagePathStack';
import { SecondPageSearch } from '../detail/SecondPageSearch';
import { WebContentPage } from '../detail/WebContentPage';
import { LoginPage } from '../pages/LoginPage';
import { RegisterPage } from '../pages/RegisterPage';
import { NewsPage } from '../pages/NewsPage';
import { PrivacyPage } from '../pages/PrivacyPage';
import { AgreementPage } from '../pages/AgreementPage';
import { FeedbackPage } from '../pages/FeedbackPage';
import { FeedbackHistoryPage } from '../pages/FeedbackHistoryPage';
import { ProfileEditPage } from '../pages/ProfileEditPage';

// import reference line
@Builder
export function PageMap(name: string) {
  if (name === 'SearchPage') {
    SecondPageSearch()
  } else if (name === 'LoginPage') {
    LoginPage()
  } else if (name === 'RegisterPage') {
    RegisterPage()
  } else if (name === 'WebContentPage') {
    WebContentPage()
  } else if (name === 'NewsPage') {
    NewsPage()
  } else if (name === 'PrivacyPage') {
    PrivacyPage()
  } else if (name === 'AgreementPage') {
    AgreementPage()
  } else if (name === 'FeedbackPage') {
    FeedbackPage()
  } else if (name === 'FeedbackHistoryPage') {
    FeedbackHistoryPage()
  } else if (name === 'ProfileEditPage') {
    ProfileEditPage()
  } else {
    EmptyPagePathStack()
  }
}
