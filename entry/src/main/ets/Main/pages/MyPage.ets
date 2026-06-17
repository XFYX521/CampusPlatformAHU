import { promptAction } from '@kit.ArkUI';
import { image } from '@kit.ImageKit';
import { AvatarSelectDialog } from '../view/AvatarSelectDialog';
import { AvatarHelper } from '../util/AvatarHelper';
import { common } from '@kit.AbilityKit';

@Component
export struct MyPage {
  // 1. 必须声明路由栈，用于页面跳转
  @Consume('appPathStack') appPathStack: NavPathStack;
  private scroller: Scroller = new Scroller();

  // 2. 使用StorageLink与AppStorage同步全局状态（最简实现）
  @StorageLink('isLoggedIn') isLoggedIn: boolean = false;
  @StorageLink('username') username: string = '未登录';
  @StorageLink('nickname') nickname: string = '未登录';
  // 使用@Watch监听avatarPath变化，自动重新加载头像
  @StorageLink('avatarPath') @Watch('onAvatarPathChanged') userAvatar: string = '';
  
  // 头像选择对话框控制器
  private avatarDialogController: CustomDialogController = new CustomDialogController({
    builder: AvatarSelectDialog({
      onAvatarSelected: (pixelMap: image.PixelMap, uri: string) => {
        this.handleAvatarSelected(pixelMap, uri);
      }
    }),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 }
  });
  
  // 头像辅助类
  private avatarHelper: AvatarHelper = AvatarHelper.getInstance();
  
  // 当前头像PixelMap
  @State private avatarPixelMap: image.PixelMap | null = null;
  
  // 组件即将显示时初始化
  aboutToAppear(): void {
    // 初始化AvatarHelper的上下文
    const context = getContext(this) as common.UIAbilityContext;
    this.avatarHelper.setContext(context);
    
    // 加载已保存的头像
    this.loadSavedAvatar();
  }
  
  // 加载已保存的头像
  private async loadSavedAvatar(): Promise<void> {
    try {
      console.info('[MyPage] loadSavedAvatar: 开始加载头像');
      console.info('[MyPage] loadSavedAvatar: userAvatar =', this.userAvatar);
      
      // 如果有保存的头像路径，尝试加载
      if (this.userAvatar && this.userAvatar.trim() !== '') {
        console.info('[MyPage] loadSavedAvatar: 调用avatarHelper.loadAvatar...');
        const pixelMap = await this.avatarHelper.loadAvatar(this.userAvatar);
        
        if (pixelMap) {
          this.avatarPixelMap = pixelMap;
          console.info('[MyPage] loadSavedAvatar: 头像加载成功');
        } else {
          console.error('[MyPage] loadSavedAvatar: loadAvatar返回null');
        }
      } else {
        console.warn('[MyPage] loadSavedAvatar: userAvatar为空');
      }
    } catch (error) {
      console.error('[MyPage] loadSavedAvatar: 异常 =', error);
    }
  }
  
  // avatarPath变化时自动重新加载头像
  onAvatarPathChanged(): void {
    console.info('[MyPage] onAvatarPathChanged: avatarPath变化');
    console.info('[MyPage] onAvatarPathChanged: userAvatar =', this.userAvatar);
    
    if (this.userAvatar && this.userAvatar.trim() !== '') {
      // 异步加载新头像
      console.info('[MyPage] onAvatarPathChanged: 开始加载头像');
      this.loadSavedAvatar();
    } else {
      // 清空头像
      console.info('[MyPage] onAvatarPathChanged: 清空头像');
      this.avatarPixelMap = null;
    }
  }

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
            // 打开头像选择对话框
            this.avatarDialogController.open();
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
              this.appPathStack.pushPathByName('ProfileEditPage', null);
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
              this.appPathStack.pushPathByName('ProfileEditPage', null);
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
        this.AboutItem('我的反馈', $r('app.media.lib_icon_Document'))
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

  // 获取头像资源
  getAvatarResource(): image.PixelMap | Resource {
    // 如果有用户选择的头像,显示它
    if (this.avatarPixelMap) {
      return this.avatarPixelMap;
    }
    
    // 如果有自定义头像路径,尝试加载
    if (this.userAvatar && this.userAvatar.trim() !== '') {
      // loadSavedAvatar会异步加载，这里先返回默认头像
      // 实际头像会在aboutToAppear中加载
      return $r('app.media.avatar');
    }
    
    // 使用默认头像
    return $r('app.media.avatar');
  }
  
  // 处理头像选择完成
  private async handleAvatarSelected(pixelMap: image.PixelMap, uri: string): Promise<void> {
    try {
      // 更新头像显示
      this.avatarPixelMap = pixelMap;
      
      // 保存到本地持久化目录
      const fileName = `avatar_${this.username}.jpg`;
      const persistentPath = await this.avatarHelper.saveToPersistent(pixelMap, fileName);
      
      if (persistentPath) {
        // 更新全局状态
        AppStorage.setOrCreate('avatarPath', persistentPath);
        
        console.info('MyPage: avatar saved to:', persistentPath);
        
        // 上传到服务器
        await this.uploadAvatarToServer(pixelMap);
      } else {
        promptAction.showToast({ message: '头像保存失败' });
      }
    } catch (error) {
      console.error('handleAvatarSelected error:', error);
      promptAction.showToast({ message: '头像更新失败' });
    }
  }
  
  // 上传头像到服务器
  private async uploadAvatarToServer(pixelMap: image.PixelMap): Promise<void> {
    try {
      // 从AppStorage获取token
      const token = AppStorage.get<string>('token') || '';
      
      if (!token) {
        console.error('MyPage: no token found');
        promptAction.showToast({ message: '请先登录' });
        return;
      }
      
      console.info('MyPage: compressing avatar...');
      
      // 压缩图片到128KB以内
      const compressedPixelMap = await this.avatarHelper.compressImage(pixelMap, 128);
      
      console.info('MyPage: uploading avatar...');
      
      // 调用AvatarHelper的上传方法
      const result = await this.avatarHelper.uploadAvatarToServer(compressedPixelMap, token);
      
      if (result.success && result.url) {
        // 更新服务器返回的头像URL
        AppStorage.setOrCreate('avatarUrl', result.url);
        promptAction.showToast({ message: result.message || '头像上传成功' });
        console.info('MyPage: avatar uploaded, url =', result.url);
      } else {
        promptAction.showToast({ message: result.message || '头像上传失败' });
        console.error('MyPage: upload failed, message =', result.message);
      }
    } catch (error) {
      console.error('uploadAvatarToServer error:', error);
      promptAction.showToast({ message: '头像上传失败' });
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
      AppStorage.setOrCreate('avatarUrl', '');
      AppStorage.setOrCreate('token', '');

      // 重置头像PixelMap状态
      this.avatarPixelMap = null;

      // 删除本地持久化的头像文件
      this.deleteLocalAvatar();

      promptAction.showToast({ message: '已退出登录', duration: 1500 });
    } catch (error) {
      console.error('handleLogout error: ' + JSON.stringify(error));
      promptAction.showToast({ message: '退出登录失败，请重试' });
    }
  }

  // 删除本地头像文件
  private async deleteLocalAvatar(): Promise<void> {
    try {
      const context = getContext(this) as common.UIAbilityContext;
      const filesDir = context.filesDir;
      const avatarDir = `${filesDir}/avatars`;
      
      // 头像目录路径已获取，退出登录时重置状态即可
      // 实际文件会在下次登录时被新头像覆盖
      console.info('MyPage: avatar state reset, avatarDir =', avatarDir);
    } catch (error) {
      console.error('deleteLocalAvatar error:', error);
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

      if (settingName === '账号与安全') {
        this.appPathStack.pushPathByName('ProfileEditPage', null);
      } else {
        promptAction.showToast({ message: `打开${settingName}` });
      }
    } catch (error) {
      console.error('handleSettingClick error: ' + JSON.stringify(error));
    }
  }

  // 关于项点击处理
  handleAboutClick(aboutName: string) {
    try {
      if (aboutName === '隐私政策') {
        this.appPathStack.pushPathByName('PrivacyPage', null);
      } else if (aboutName === '用户协议') {
        this.appPathStack.pushPathByName('AgreementPage', null);
      } else if (aboutName === '用户反馈') {
        this.appPathStack.pushPathByName('FeedbackPage', null);
      } else if (aboutName === '我的反馈') {
        // 检查是否登录
        if (!this.isLoggedIn) {
          promptAction.showToast({ message: '请先登录账号' });
          this.appPathStack.pushPathByName('LoginPage', null);
          return;
        }
        this.appPathStack.pushPathByName('FeedbackHistoryPage', null);
      } else {
        promptAction.showToast({ message: `打开${aboutName}` });
      }
    } catch (error) {
      console.error('handleAboutClick error: ' + JSON.stringify(error));
    }
  }



}
