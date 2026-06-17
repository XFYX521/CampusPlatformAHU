import http from '@ohos.net.http';
import { promptAction } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

interface ApiResponse {
  code: number;
  message: string;
  data?: Record<string, Object>;
}

interface ErrorResponse {
  message?: string;
}

@Entry
export struct ProfileEditPage {
  @Consume('appPathStack') appPathStack: NavPathStack;
  
  // 用户信息状态
  @StorageLink('username') username: string = '';
  @StorageLink('nickname') nickname: string = '';
  @StorageLink('token') token: string = '';
  
  // 编辑状态
  @State private editNickname: string = '';
  @State private oldPassword: string = '';
  @State private newPassword: string = '';
  @State private confirmPassword: string = '';
  
  // UI状态
  @State private isUpdatingNickname: boolean = false;
  @State private isUpdatingPassword: boolean = false;
  @State private isDeletingAccount: boolean = false;
  @State private showDeleteDialog: boolean = false;
  
  // API基础URL
  private baseUrl: string = 'https://backend.hoshikaze.top/api';
  
  aboutToAppear(): void {
    // 初始化昵称编辑框
    this.editNickname = this.nickname;
  }
  
  build() {
    NavDestination() {
      Column() {
        // 内容区域
        Scroll() {
          Column({ space: 20 }) {
            // 账号信息区域（只读）
            this.AccountSection()
            
            // 昵称修改区域
            this.NicknameSection()
            
            // 密码修改区域
            this.PasswordSection()
            
            // 注销账号区域
            this.DeleteAccountSection()
          }
          .width('100%')
          .padding({ left: 20, right: 20, bottom: 30 })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .backgroundColor($r('app.color.page_bg_color'))
      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.page_bg_color'))
    }
    .title('账号与安全')
    .mode(NavDestinationMode.STANDARD)
  }
  
  // 账号信息区域（只读）
  @Builder
  AccountSection() {
    Column() {
      Text('账号信息')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.page_title_font_color'))
        .margin({ bottom: 15 })
        .alignSelf(ItemAlign.Start)
      
      Row({ space: 12 }) {
        Text('账号')
          .fontSize(15)
          .fontColor($r('app.color.content_main_title_font_color'))
          .width(60)
        
        Text(this.username)
          .fontSize(15)
          .fontColor($r('app.color.font_tertiary'))
          .layoutWeight(1)
        
        Text('不可修改')
          .fontSize(12)
          .fontColor($r('app.color.font_tertiary'))
          .backgroundColor('#f5f5f5')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(4)
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)
      .borderRadius(12)
    }
    .width('100%')
    .margin({ top: 20 })
  }
  
  // 昵称修改区域
  @Builder
  NicknameSection() {
    Column() {
      Text('修改昵称')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.page_title_font_color'))
        .margin({ bottom: 15 })
        .alignSelf(ItemAlign.Start)
      
      Column() {
        Row({ space: 12 }) {
          Text('昵称')
            .fontSize(15)
            .fontColor($r('app.color.content_main_title_font_color'))
            .width(60)
          
          TextInput({ placeholder: '请输入昵称', text: this.editNickname })
            .fontSize(15)
            .layoutWeight(1)
            .backgroundColor(Color.Transparent)
            .onChange((value: string) => {
              this.editNickname = value;
            })
        }
        .width('100%')
        .height(50)
        .padding({ left: 16, right: 16 })
        
        Divider()
          .strokeWidth(1)
          .color($r('app.color.comp_divider'))
          .margin({ left: 16, right: 16 })
        
        Button(this.isUpdatingNickname ? '保存中...' : '保存昵称')
          .width('90%')
          .height(40)
          .margin({ top: 15, bottom: 15 })
          .backgroundColor($r('app.color.app_icon_pressed_color'))
          .enabled(!this.isUpdatingNickname && this.editNickname.trim() !== '')
          .onClick(() => {
            this.updateNickname();
          })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(12)
    }
    .width('100%')
  }
  
  // 密码修改区域
  @Builder
  PasswordSection() {
    Column() {
      Text('修改密码')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.page_title_font_color'))
        .margin({ bottom: 15 })
        .alignSelf(ItemAlign.Start)
      
      Column() {
        // 旧密码
        Row({ space: 12 }) {
          Text('旧密码')
            .fontSize(15)
            .fontColor($r('app.color.content_main_title_font_color'))
            .width(70)
          
          TextInput({ placeholder: '请输入旧密码', text: this.oldPassword })
            .fontSize(15)
            .layoutWeight(1)
            .type(InputType.Password)
            .backgroundColor(Color.Transparent)
            .onChange((value: string) => {
              this.oldPassword = value;
            })
        }
        .width('100%')
        .height(50)
        .padding({ left: 16, right: 16 })
        
        Divider()
          .strokeWidth(1)
          .color($r('app.color.comp_divider'))
          .margin({ left: 16, right: 16 })
        
        // 新密码
        Row({ space: 12 }) {
          Text('新密码')
            .fontSize(15)
            .fontColor($r('app.color.content_main_title_font_color'))
            .width(70)
          
          TextInput({ placeholder: '请输入新密码', text: this.newPassword })
            .fontSize(15)
            .layoutWeight(1)
            .type(InputType.Password)
            .backgroundColor(Color.Transparent)
            .onChange((value: string) => {
              this.newPassword = value;
            })
        }
        .width('100%')
        .height(50)
        .padding({ left: 16, right: 16 })
        
        Divider()
          .strokeWidth(1)
          .color($r('app.color.comp_divider'))
          .margin({ left: 16, right: 16 })
        
        // 确认密码
        Row({ space: 12 }) {
          Text('确认密码')
            .fontSize(15)
            .fontColor($r('app.color.content_main_title_font_color'))
            .width(70)
          
          TextInput({ placeholder: '请确认新密码', text: this.confirmPassword })
            .fontSize(15)
            .layoutWeight(1)
            .type(InputType.Password)
            .backgroundColor(Color.Transparent)
            .onChange((value: string) => {
              this.confirmPassword = value;
            })
        }
        .width('100%')
        .height(50)
        .padding({ left: 16, right: 16 })
        
        Button(this.isUpdatingPassword ? '修改中...' : '修改密码')
          .width('90%')
          .height(40)
          .margin({ top: 15, bottom: 15 })
          .backgroundColor($r('app.color.app_icon_pressed_color'))
          .enabled(!this.isUpdatingPassword && this.validatePasswordInput())
          .onClick(() => {
            this.updatePassword();
          })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(12)
    }
    .width('100%')
  }
  
  // 注销账号区域
  @Builder
  DeleteAccountSection() {
    Column() {
      Text('账号注销')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.page_title_font_color'))
        .margin({ bottom: 15 })
        .alignSelf(ItemAlign.Start)
      
      Column() {
        Text('注销账号后，您的所有数据将被永久删除且无法恢复，请谨慎操作。')
          .fontSize(14)
          .fontColor($r('app.color.font_tertiary'))
          .margin({ top: 15, bottom: 15, left: 16, right: 16 })
        
        Button(this.isDeletingAccount ? '注销中...' : '注销账号')
          .width('90%')
          .height(40)
          .margin({ bottom: 15 })
          .backgroundColor($r('app.color.warning'))
          .enabled(!this.isDeletingAccount)
          .onClick(() => {
            this.showDeleteDialog = true;
          })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(12)
    }
    .width('100%')
    .bindSheet($$this.showDeleteDialog, this.DeleteConfirmSheet(), {
      height: 280,
      backgroundColor: Color.White,
      dragBar: false
    })
  }
  
  // 注销确认弹窗
  @Builder
  DeleteConfirmSheet() {
    Column() {
      Text('确认注销账号？')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 15 })
      
      Text('注销后您的所有数据将被永久删除，此操作不可撤销。')
        .fontSize(14)
        .fontColor($r('app.color.font_tertiary'))
        .margin({ bottom: 25 })
      
      Row({ space: 15 }) {
        Button('取消')
          .width('40%')
          .height(40)
          .backgroundColor('#f5f5f5')
          .fontColor($r('app.color.content_main_title_font_color'))
          .onClick(() => {
            this.showDeleteDialog = false;
          })
        
        Button('确认注销')
          .width('40%')
          .height(40)
          .backgroundColor($r('app.color.warning'))
          .onClick(() => {
            this.showDeleteDialog = false;
            this.deleteAccount();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(20)
  }
  
  // 验证密码输入
  private validatePasswordInput(): boolean {
    return this.oldPassword.trim() !== '' &&
           this.newPassword.trim() !== '' &&
           this.confirmPassword.trim() !== '' &&
           this.newPassword === this.confirmPassword;
  }
  
  // 更新昵称
  private async updateNickname(): Promise<void> {
    if (this.editNickname.trim() === '') {
      promptAction.showToast({ message: '昵称不能为空' });
      return;
    }
    
    this.isUpdatingNickname = true;
    
    try {
      const httpModule = http.createHttp();
      const url = `${this.baseUrl}/user/nickname`;
      
      console.info('updateNickname request:', JSON.stringify({
        url: url,
        token: this.token ? 'exists' : 'empty',
        nickname: this.editNickname.trim()
      }));
      
      const response = await httpModule.request(url, {
        method: http.RequestMethod.PUT,
        header: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${this.token}`
        },
        extraData: {
          nickname: this.editNickname.trim()
        }
      });
      
      console.info('updateNickname response:', JSON.stringify({
        responseCode: response.responseCode,
        result: response.result
      }));
      
      if (response.responseCode === 200) {
        const result: ApiResponse = JSON.parse(response.result as string);
        
        if (result.code === 200) {
          // 更新本地存储
          AppStorage.setOrCreate('nickname', this.editNickname.trim());
          promptAction.showToast({ message: '昵称修改成功' });
        } else {
          promptAction.showToast({ message: result.message || '修改失败' });
        }
      } else {
        // 尝试解析错误响应
        let errorMsg = '网络请求失败';
        try {
          const errorResult: ErrorResponse = JSON.parse(response.result as string);
          errorMsg = errorResult.message || `请求失败(${response.responseCode})`;
        } catch (_) {
          errorMsg = `请求失败，状态码: ${response.responseCode}`;
        }
        promptAction.showToast({ message: errorMsg });
        console.error('updateNickname failed:', response.responseCode, response.result);
      }
      
      httpModule.destroy();
    } catch (error) {
      console.error('updateNickname error:', error);
      promptAction.showToast({ message: '修改失败，请重试' });
    } finally {
      this.isUpdatingNickname = false;
    }
  }
  
  // 更新密码
  private async updatePassword(): Promise<void> {
    if (this.newPassword !== this.confirmPassword) {
      promptAction.showToast({ message: '两次密码输入不一致' });
      return;
    }
    
    if (this.newPassword.length < 6) {
      promptAction.showToast({ message: '密码长度至少6位' });
      return;
    }
    
    this.isUpdatingPassword = true;
    
    try {
      const httpModule = http.createHttp();
      const url = `${this.baseUrl}/user/password`;
      
      console.info('updatePassword request:', JSON.stringify({
        url: url,
        token: this.token ? 'exists' : 'empty',
        oldPassword: this.oldPassword,
        newPassword: this.newPassword
      }));
      
      const response = await httpModule.request(url, {
        method: http.RequestMethod.PUT,
        header: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${this.token}`
        },
        extraData: {
          oldPassword: this.oldPassword,
          newPassword: this.newPassword
        }
      });
      
      console.info('updatePassword response:', JSON.stringify({
        responseCode: response.responseCode,
        result: response.result
      }));
      
      if (response.responseCode === 200) {
        const result: ApiResponse = JSON.parse(response.result as string);
        
        if (result.code === 200) {
          promptAction.showToast({ message: '密码修改成功，请重新登录' });
          
          // 清空密码输入
          this.oldPassword = '';
          this.newPassword = '';
          this.confirmPassword = '';
          
          // 退出登录
          setTimeout(() => {
            this.logout();
          }, 1500);
        } else {
          promptAction.showToast({ message: result.message || '修改失败' });
        }
      } else {
        // 尝试解析错误响应
        let errorMsg = '网络请求失败';
        try {
          const errorResult: ErrorResponse = JSON.parse(response.result as string);
          errorMsg = errorResult.message || `请求失败(${response.responseCode})`;
        } catch (_) {
          errorMsg = `请求失败，状态码: ${response.responseCode}`;
        }
        promptAction.showToast({ message: errorMsg });
        console.error('updatePassword failed:', response.responseCode, response.result);
      }
      
      httpModule.destroy();
    } catch (error) {
      console.error('updatePassword error:', error);
      promptAction.showToast({ message: '修改失败，请重试' });
    } finally {
      this.isUpdatingPassword = false;
    }
  }
  
  // 注销账号
  private async deleteAccount(): Promise<void> {
    this.isDeletingAccount = true;
    
    try {
      const httpModule = http.createHttp();
      const url = `${this.baseUrl}/user/account`;
      
      console.info('deleteAccount request:', JSON.stringify({
        url: url,
        token: this.token ? 'exists' : 'empty'
      }));
      
      const response = await httpModule.request(url, {
        method: http.RequestMethod.DELETE,
        header: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${this.token}`
        }
      });
      
      console.info('deleteAccount response:', JSON.stringify({
        responseCode: response.responseCode,
        result: response.result
      }));
      
      if (response.responseCode === 200) {
        const result: ApiResponse = JSON.parse(response.result as string);
        
        if (result.code === 200) {
          promptAction.showToast({ message: '账号已注销' });
          
          // 退出登录
          setTimeout(() => {
            this.logout();
          }, 1500);
        } else {
          promptAction.showToast({ message: result.message || '注销失败' });
        }
      } else {
        // 尝试解析错误响应
        let errorMsg = '网络请求失败';
        try {
          const errorResult: ErrorResponse = JSON.parse(response.result as string);
          errorMsg = errorResult.message || `请求失败(${response.responseCode})`;
        } catch (_) {
          errorMsg = `请求失败，状态码: ${response.responseCode}`;
        }
        promptAction.showToast({ message: errorMsg });
        console.error('deleteAccount failed:', response.responseCode, response.result);
      }
      
      httpModule.destroy();
    } catch (error) {
      console.error('deleteAccount error:', error);
      promptAction.showToast({ message: '注销失败，请重试' });
    } finally {
      this.isDeletingAccount = false;
    }
  }
  
  // 退出登录
  private logout(): void {
    // 重置所有状态
    AppStorage.setOrCreate('isLoggedIn', false);
    AppStorage.setOrCreate('username', '');
    AppStorage.setOrCreate('nickname', '未登录');
    AppStorage.setOrCreate('avatarPath', '');
    AppStorage.setOrCreate('avatarUrl', '');
    AppStorage.setOrCreate('token', '');
    
    // 返回到主页
    this.appPathStack.clear();
  }
}
