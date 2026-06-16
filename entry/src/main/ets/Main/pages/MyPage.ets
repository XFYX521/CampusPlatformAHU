import { promptAction } from '@kit.ArkUI';

@Component
export struct MyPage {
  // 1. 必须声明路由栈，用于页面跳转
  @Consume('appPathStack') appPathStack: NavPathStack;
  private scroller: Scroller = new Scroller();

  // 2. 使用StorageLink与AppStorage同步全局状态（最简实现）
  @StorageLink('isLoggedIn') isLoggedIn: boolean = false;
  @StorageLink('username') username: string = '未登录';
  @StorageLink('nickname') nickname: string = '未登录';
  @StorageLink('avatarPath') userAvatar: string = '';
  // 黑夜模式状态（预留接口）
  @StorageLink('isDarkMode') isDarkMode: boolean = false;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 主内容区域
      Scroll(this.scroller) {
        Column() {
          // ==================== 用户信息区域 ====================
          this.UserInfoSection()

          // ==================== 设置区域 ====================
          this.SettingsSection()

          // ==================== 关于和帮助区域 ====================
          this.AboutSection()
        }
        .width('100%')
        .padding({ bottom: 20 })
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .height("100%")
      .width('100%')
      .backgroundColor($r('app.color.page_bg_color'))
    }
    .height("100%")
    .width('100%')
  }

  // ==================== 用户信息区域构建器 ====================
  @Builder
  UserInfoSection() {
    Column() {
      // 用户头像和基本信息
      Row({ space: 15 }) {
        // 头像区域
        Stack({ alignContent: Alignment.Center }) {
          Image(this.getAvatarResource())
            .width(80)
            .height(80)
            .borderRadius(40)
            .border({ width: 2, color: $r('app.color.app_icon_pressed_color') })

          // 登录状态指示器
          if (!this.isLoggedIn) {
            Circle({ width: 20, height: 20 })
              .fill($r('app.color.warning'))
              .strokeWidth(2)
              .stroke(Color.White)
              .offset({ x: 25, y: 25 })
          } else {
            // 登录状态下的编辑指示器
            Circle({ width: 20, height: 20 })
              .fill($r('app.color.app_icon_pressed_color'))
              .strokeWidth(2)
              .stroke(Color.White)
              .offset({ x: 25, y: 25 })

            Image($r('app.media.lib_icon_4'))
              .width(12)
              .height(12)
              .fillColor(Color.White)
              .offset({ x: 25, y: 25 })
          }
        }
        .onClick(() => {
          if (this.isLoggedIn) {
            try {
              promptAction.showToast({ message: '头像编辑功能开发中' });
            } catch (error) {
              // TODO: Implement error handling.
            }
          } else {
            this.appPathStack.pushPathByName('LoginPage', null);
          }
        })

        // 用户信息文本区域
        Column({ space: 5 }) {
          Text(this.isLoggedIn ? this.nickname : '未登录')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.page_title_font_color'))
            .textAlign(TextAlign.Start)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          if (this.isLoggedIn) {
            // 显示用户名（学号）
            Text(`账号：${this.username}`)
              .fontSize(12)
              .fontColor($r('app.color.font_tertiary'))
              .textAlign(TextAlign.Start)
          } else {
            Text('点击头像登录账号')
              .fontSize(14)
              .fontColor($r('app.color.app_icon_color'))
              .textAlign(TextAlign.Start)
          }
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        // 右侧箭头图标 - 点击可进入个人资料编辑
        if (this.isLoggedIn) {
          Image($r('app.media.ic_right_arrow_filled'))
            .width(20)
            .height(20)
            .fillColor($r('app.color.font_tertiary'))
            .onClick(() => {
              try {
                promptAction.showToast({ message: '进入个人资料编辑' });
              } catch (error) {
                // TODO: Implement error handling.
              }
            })
        }
      }
      .width('100%')
      .padding({ top: 30, bottom: 20, left: 20, right: 20 })

      // 登录状态下的操作按钮
      if (this.isLoggedIn) {
        Row({ space: 10 }) {
          Button('编辑资料')
            .fontSize(14)
            .fontColor($r('app.color.app_icon_pressed_color'))
            .backgroundColor(Color.Transparent)
            .borderColor($r('app.color.app_icon_pressed_color'))
            .borderWidth(1)
            .borderRadius(20)
            .width('40%')
            .height(36)
            .onClick(() => {
              try {
                promptAction.showToast({ message: '编辑资料功能开发中' });
              } catch (error) {
                // TODO: Implement error handling.
              }
            })

          Button('退出登录')
            .fontSize(14)
            .fontColor(Color.White)
            .backgroundColor($r('app.color.warning'))
            .borderRadius(20)
            .width('40%')
            .height(36)
            .onClick(() => {
              this.handleLogout();
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ bottom: 15 })
      }

      // 分隔线
      Divider()
        .strokeWidth(1)
        .color($r('app.color.comp_divider'))
        .margin({ left: 20, right: 20 })
    }
  }

  // ==================== 设置区域构建器 ====================
  @Builder
  SettingsSection() {
    Column() {
      // 设置标题
      Text('设置')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.page_title_font_color'))
        .margin({ top: 15, bottom: 10, left: 20 })
        .alignSelf(ItemAlign.Start)

      // 设置项列表
      Column() {
        this.SettingItemToggle('黑夜模式', $r('app.media.lib_icon_MoonMode'), this.isDarkMode)
        this.SettingItem('账号与安全', $r('app.media.lib_icon_Setifications'), true)
        this.SettingItem('通知设置', $r('app.media.lib_icon_Notifications'), false)
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(12)
      .margin({ left: 20, right: 20 })

      // 分隔线
      Divider()
        .strokeWidth(1)
        .color($r('app.color.comp_divider'))
        .margin({ top: 20, left: 20, right: 20 })
    }
  }

  // ==================== 设置项 ====================
  @Builder
  SettingItem(title: string, icon: Resource, showArrow: boolean, value?: string) {
    Row({ space: 12 }) {
      // 图标
      Image(icon)
        .width(20)
        .height(20)
        .fillColor($r('app.color.module_icon_color'))

      // 标题
      Text(title)
        .fontSize(16)
        .fontColor($r('app.color.content_main_title_font_color'))
        .layoutWeight(1)

      // 值显示（如果有）
      if (value) {
        Text(value)
          .fontSize(14)
          .fontColor($r('app.color.font_tertiary'))
      }

      // 箭头图标
      if (showArrow) {
        Image($r('app.media.ic_right_arrow_filled'))
          .width(16)
          .height(16)
          .fillColor($r('app.color.font_tertiary'))
      }
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .onClick(() => {
      this.handleSettingClick(title);
    })

    // 分隔线（除最后一项外）
    if (title !== '通知设置') {
      Divider()
        .strokeWidth(1)
        .color($r('app.color.comp_divider'))
        .margin({ left: 16 })
    }
  }

  // ==================== 带开关的设置项 ====================
  @Builder
  SettingItemToggle(title: string, icon: Resource, isOn: boolean) {
    Row({ space: 12 }) {
      // 图标
      Image(icon)
        .width(20)
        .height(20)
        .fillColor($r('app.color.module_icon_color'))

      // 标题
      Text(title)
        .fontSize(16)
        .fontColor($r('app.color.content_main_title_font_color'))
        .layoutWeight(1)

      // Toggle开关
      Toggle({ type: ToggleType.Switch, isOn: isOn })
        .selectedColor($r('app.color.app_icon_pressed_color'))
        .onChange((isOn: boolean) => {
          this.handleDarkModeToggle(isOn);
        })
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })

    // 分隔线
    Divider()
      .strokeWidth(1)
      .color($r('app.color.comp_divider'))
      .margin({ left: 16 })
  }

  // ==================== 关于和帮助区域====================
  @Builder
  AboutSection() {
    Column() {
      // 关于标题
      Text('关于与帮助')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.page_title_font_color'))
        .margin({ top: 15, bottom: 10, left: 20 })
        .alignSelf(ItemAlign.Start)

      // 关于项列表
      Column() {
        this.AboutItem('用户反馈', $r('app.media.lib_icon_Feedback'))
        this.AboutItem('帮助中心', $r('app.media.lib_icon_Headphone'))
        this.AboutItem('版本信息', $r('app.media.lib_icon_VersionInformation'), false, 'v0.9.2')
        this.AboutItem('隐私政策', $r('app.media.lib_icon_Check'))
        this.AboutItem('用户协议', $r('app.media.lib_icon_Document'))
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(12)
      .margin({ left: 20, right: 20 })
    }
  }

  // ==================== 关于项 ====================
  @Builder
  AboutItem(title: string, icon: Resource, showArrow: boolean = true, value?: string) {
    Row({ space: 12 }) {
      // 图标
      Image(icon)
        .width(20)
        .height(20)
        .fillColor($r('app.color.module_icon_color'))

      // 标题
      Text(title)
        .fontSize(16)
        .fontColor($r('app.color.content_main_title_font_color'))
        .layoutWeight(1)

      // 值显示（如果有）
      if (value) {
        Text(value)
          .fontSize(14)
          .fontColor($r('app.color.font_tertiary'))
      }

      // 箭头图标
      if (showArrow) {
        Image($r('app.media.ic_right_arrow_filled'))
          .width(16)
          .height(16)
          .fillColor($r('app.color.font_tertiary'))
      }
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .onClick(() => {
      this.handleAboutClick(title);
    })

    // 分隔线（除最后一项外）
    if (title !== '用户协议') {
      Divider()
        .strokeWidth(1)
        .color($r('app.color.comp_divider'))
        .margin({ left: 16 })
    }
  }

  // ==================== 事件处理函数 ====================

  // 获取头像资源（最简实现）
  getAvatarResource(): Resource {
    if (this.userAvatar && this.userAvatar.trim() !== '') {
      // 如果有自定义头像路径，使用自定义头像
      // 这里简化处理，直接返回默认头像
      return $r('app.media.avatar');
    } else {
      // 使用默认头像
      return $r('app.media.avatar');
    }
  }

  // 退出登录处理
  handleLogout() {
    try {
      // 重置 AppStorage 状态（PersistentStorage 会自动同步）
      AppStorage.setOrCreate('isLoggedIn', false);
      AppStorage.setOrCreate('username', '');
      AppStorage.setOrCreate('nickname', '未登录');
      AppStorage.setOrCreate('avatarPath', '');

      promptAction.showToast({ message: '已退出登录', duration: 1500 });
    } catch (error) {
      console.error('handleLogout error: ' + JSON.stringify(error));
      promptAction.showToast({ message: '退出登录失败，请重试' });
    }
  }

  // 设置项点击处理
  handleSettingClick(settingName: string) {
    try {
      if (!this.isLoggedIn && settingName !== '通知设置') {
        promptAction.showToast({ message: '请先登录账号' });
        this.appPathStack.pushPathByName('LoginPage', null);
        return;
      }

      promptAction.showToast({ message: `打开${settingName}` });
    } catch (error) {
      console.error('handleSettingClick error: ' + JSON.stringify(error));
    }
  }

  // 关于项点击处理
  handleAboutClick(aboutName: string) {
    try {
      promptAction.showToast({ message: `打开${aboutName}` });//
    } catch (error) {
      console.error('handleAboutClick error: ' + JSON.stringify(error));
    }
  }

  // 黑夜模式开关处理
  handleDarkModeToggle(isOn: boolean) {
    // TODO: 实现黑夜模式切换功能
    // 1. 更新全局主题状态
    // 2. 持久化用户偏好设置
    // 3. 通知所有页面更新UI
    console.info('Dark mode toggle: ' + isOn);
  }
}
