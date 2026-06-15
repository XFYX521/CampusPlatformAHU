import http from '@ohos.net.http';
// 同目录用 ./ ，去掉多余../pages
//import {RegisterPage} from './RegisterPage'
// 导入华为账号服务所需模块（请确保在项目 oh-package.json5 中已添加相关依赖）
// import { authentication } from '@kit.AccountKit';
interface LoginResponse {
  code: number;
  msg: string;
  data?: Record<string, Object>;
}

interface BusinessError {
  code: number | string;
  message?: string;
}
@Entry
export struct LoginPage {
  @Consume('appPathStack') appPathStack: NavPathStack;
  @State username: string = '';
  @State password: string = '';
  @State isLoggingIn: boolean = false;
  private baseUrl: string = "https://backend.hoshikaze.top/api/auth/login"

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.TopStart }) {
        Column() {
          // --- 头部：返回按钮 ---
          Row() {
            Image($r('app.media.IMG_0218'))
              .width(30)
              .height(30)
              .onClick(() => {
                this.appPathStack.pop();
              })
          }
          .width('100%')
          .padding(20)

          // --- 中间：Logo ---
          Column({ space: 10 }) {
            Image($r('app.media.IMG_0219'))
              .width(120)
              .height(120)
              .margin({ top: 20 })

            Text('欢迎登录')
              .fontSize(26)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.app_icon_pressed_color'))
          }
          .margin({ bottom: 40 })

          // --- 账号密码输入区 ---
          Column({ space: 15 }) {
            TextInput({ placeholder: '请输入用户名', text: this.username })
              .width('85%')
              .height(50)
              .backgroundColor('#FFFFFF')
              .onChange((value: string) => this.username = value)

            TextInput({ placeholder: '请输入密码', text: this.password })
              .width('85%')
              .height(50)
              .type(InputType.Password)
              .backgroundColor('#FFFFFF')
              .onChange((value: string) => this.password = value)
          }

          // --- 登录按钮 ---
          Button(this.isLoggingIn ? '登录中...' : '立即登录')
            .width('85%')
            .height(50)
            .margin({ top: 40 })
            .enabled(!this.isLoggingIn)
            .onClick(() => this.handleLogin())

          // --- [新增] 华为账号快速登录 ---
          Column() {
            Text('其他登录方式')
              .fontSize(12)
              .fontColor(Color.Gray)
              .margin({ top: 30, bottom: 15 })

            // 华为账号登录按钮（此处以 Image 模拟，实际开发建议使用官方标准组件）
            //Image($r('app.media.IMG_0216')) // 请在 media 放入华为图标
            //.width(44)
            //.height(44)
            // .onClick(() => this.handleHuaweiLogin())
          }

          // --- 底部辅助文字 ---
          Row() {
            Text('忘记密码').fontSize(14).fontColor(Color.Gray)
            Text('|').margin({ left: 10, right: 10 }).fontColor(Color.Gray)
            Text('新用户注册')
              .fontSize(14)
              .fontColor($r('app.color.app_icon_pressed_color'))
              .onClick(() => {
                this.appPathStack.pushPathByName("RegisterPage", null);
              })
          }
          .margin({ top: 20 })
        }
        .width('100%')
        .height('100%')
        // 建议背景色与主页保持一致，或设为透明/白色
        .backgroundColor($r('app.color.page_bg_color'))
      }
    }
    .hideTitleBar(true)
  }

  // 1. 传统账号密码登录逻辑
  async handleLogin() {

    let name = this.username.trim()
    let pwd = this.password.trim()
    if (name === '' || pwd === '') {
      this.getUIContext().getPromptAction().showToast({ message: '请输入账号和密码' });
      return;
    }
    this.isLoggingIn = true;

    // 发起POST请求
    let httpRequest = http.createHttp();
    let reqData = JSON.stringify({
      username: name,
      password: pwd
    })

    // 打印请求信息用于调试
    console.info("=== 登录请求详情 ===");
    console.info("请求URL:", this.baseUrl);
    console.info("请求参数:", reqData);

    try {
      let res = await httpRequest.request(this.baseUrl, {
        method: http.RequestMethod.POST,
        header: {
          "Content-Type": "application/json"
        },
        extraData: JSON.stringify({
          username:this.username,
          password:this.password
        })
      })

      // 打印响应详情用于调试
      console.info("=== 登录响应详情 ===");
      console.info("HTTP状态码:", res.responseCode);
      console.info("响应结果类型:", typeof res.result);
      console.info("响应结果内容:", res.result);

      // 检查HTTP状态码
      if (res.responseCode !== 200) {
        console.error("HTTP状态码异常:", res.responseCode);
        this.getUIContext().getPromptAction().showToast({
          message: `账号或密码错误` //服务器错误: HTTP ${res.responseCode}
        });
        return;
      }

      // 解析后端返回json
      let result: LoginResponse;
      if (typeof res.result === 'string') {
        try {
          result = JSON.parse(res.result);
        } catch (parseErr) {
          console.error("JSON解析失败:", parseErr);
          console.error("原始响应内容:", res.result);
          this.getUIContext().getPromptAction().showToast({ message: '响应数据格式错误' });
          return;
        }
      } else if (typeof res.result === 'object') {
        result = res.result as LoginResponse;
      } else {
        console.error("无法识别的响应格式:", typeof res.result);
        this.getUIContext().getPromptAction().showToast({ message: '响应格式异常' });
        return;
      }

      // 打印完整的 result 结构，查看后端返回了哪些字段
      console.info("解析后的完整结果:", JSON.stringify(result));

      if (result.code === 200) {
        // 登录成功，优先使用后端返回的真实昵称，否则用 username 兜底
        const realNickname = (result.data?.['nickname'] as string) || (result.data?.['realName'] as string) || '';
        const token = (result.data?.['token'] as string) || '';
        
        AppStorage.setOrCreate('isLoggedIn', true);
        AppStorage.setOrCreate('username', name);
        AppStorage.setOrCreate('nickname', realNickname || `${name}用户`);
        AppStorage.setOrCreate('avatarPath', '');
        
        // 保存登录token
        if (token) {
          AppStorage.setOrCreate('token', token);
          console.info("Token已保存");
        }

        console.info("登录状态已保存:", AppStorage.get<boolean>('isLoggedIn'));

        this.getUIContext().getPromptAction().showToast({
          message: result.msg || '登录成功'
        });
        // 返回个人中心页面
        this.appPathStack.pop();
      } else {
        // 密码错误或其他业务错误
        console.error("业务错误码:", result.code, "错误信息:", result.msg);
        this.getUIContext().getPromptAction().showToast({
          message: result.msg || '登录失败'
        });
      }
    } catch (err) {
      // 连不上后端（IP错/后端没开/不在同一局域网）
      console.error("=== 请求异常详情 ===");
      console.error("错误类型:", typeof err);

      // 尝试获取更详细的错误信息
      if (err instanceof Error) {
        console.error("错误名称:", (err as Error).name);
        console.error("错误消息:", (err as Error).message);
      }

      // 根据错误类型给出不同提示
      let errorMsg = '连接服务器失败';
      const businessErr = err as BusinessError;
      if (businessErr.code !== undefined) {
        const errCode = businessErr.code;
        console.error("错误码:", errCode, "类型:", typeof errCode);

        // 处理字符串或数字类型的错误码
        if (errCode === -1 || errCode === '-1') {
          errorMsg = '网络连接超时，请检查网络';
        } else if (errCode === -2 || errCode === '-2') {
          errorMsg = '服务器连接失败，请检查IP地址';
        } else if (errCode === 401 || errCode === '401') {
          errorMsg = '请求参数错误或权限不足';
        } else if (errCode === 400 || errCode === '400') {
          errorMsg = '请求格式错误';
        }
      }

      this.getUIContext().getPromptAction().showToast({ message: errorMsg });
    } finally {
      // 结束加载状态、销毁请求
      this.isLoggingIn = false;
      httpRequest.destroy();
    }
  }


}

