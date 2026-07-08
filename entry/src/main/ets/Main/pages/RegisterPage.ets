import { ApiClient } from '../util/ApiClient';
import promptAction from '@ohos.promptAction';

// 全局定义后端返回类型
interface RegisterResponse {
  code: number;
  msg: string;
}

@Entry
export struct RegisterPage {
  @Consume('appPathStack') appPathStack: NavPathStack;
  // 基础账号密码
  @State username: string = '';
  @State password: string = '';
  @State confirmPassword: string = '';
  // 昵称
  @State nickname: string = '';
  // 邮箱+验证码相关状态
  @State email: string = '';
  @State verifyCode: string = '';
  @State countdown: number = 60;
  @State isGetCodeDisable: boolean = false;
  // 人机验证相关状态
  @State showCaptchaDialog: boolean = false;
  @State sliderValue: number = 0;
  @State isCaptchaVerified: boolean = false;

  // 邮箱格式正则校验
  private checkEmailFormat(emailStr: string): boolean {
    const reg = /^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+[.][a-zA-Z]{2,6}$/;
    return reg.test(emailStr);
  }

  // 学号格式校验（支持字母和数字）
  private checkUsernameFormat(usernameStr: string): boolean {
    const reg = /^[a-zA-Z0-9]+$/;
    return reg.test(usernameStr);
  }

  // 昵称格式校验（仅中文，2-5个字）
  private checkNicknameFormat(nicknameStr: string): boolean {
    const reg = /^[\u4e00-\u9fa5]{2,5}$/;
    return reg.test(nicknameStr);
  }

  // 点击获取验证码按钮 - 先进行人机验证
  async sendEmailCode() {
    // 校验邮箱格式
    if (!this.checkEmailFormat(this.email)) {
      promptAction.showToast({ message: '请输入正确的邮箱格式' });
      return;
    }
    // 弹出人机验证弹窗
    this.showCaptchaDialog = true;
    this.sliderValue = 0;
    this.isCaptchaVerified = false;
  }

  // 人机验证通过后，实际发送验证码
  async doSendEmailCode() {
    // 关闭验证弹窗
    this.showCaptchaDialog = false;
    // 发起请求调用后端发送验证码接口
    try {
      let res = await ApiClient.post('api/auth/send-code', JSON.stringify({ email: this.email }))

      // 打印响应详情用于调试
      console.info("=== 发送验证码响应详情 ===");
      console.info("响应状态码:", res.responseCode);
      console.info("响应结果类型:", typeof res.result);
      console.info("响应结果内容:", res.result);

      // 检查HTTP状态码
      if (res.responseCode !== 200) {
        promptAction.showToast({ message: `服务器错误: ${res.responseCode}` });
        return;
      }

      // 解析响应数据
      let result: RegisterResponse;
      if (typeof res.result === 'string') {
        result = JSON.parse(res.result);
      } else if (typeof res.result === 'object') {
        result = res.result as RegisterResponse;
      } else {
        throw new Error("无法识别的响应格式");
      }

      if (result.code === 200) {
        promptAction.showToast({ message: '验证码已发送至邮箱，60秒内有效' });
        // 开启倒计时
        this.isGetCodeDisable = true;
        let timer = setInterval(() => {
          this.countdown--;
          if (this.countdown <= 0) {
            clearInterval(timer);
            this.isGetCodeDisable = false;
            this.countdown = 60;
          }
        }, 1000);
      } else {
        promptAction.showToast({ message: result.msg });
      }
    } catch (err) {
      promptAction.showToast({ message: '网络异常，验证码发送失败' });
      if (err) {
        console.error("发送验证码报错：", err);
        if (typeof err === 'object') {
          console.error("错误对象属性：", JSON.stringify(err, Object.getOwnPropertyNames(err)));
        }
      } else {
        console.error("发送验证码报错：未知错误");
      }
    }
  }

  async finishRegister() {
    //====新增表单校验 start====
    let name: string = this.username.trim();
    let pwd: string = this.password.trim();
    let nick: string = this.nickname.trim();
    let email: string = this.email.trim();
    let code: string = this.verifyCode.trim();
    if(name === ""){
      promptAction.showToast({message:"请填写学号"});
      return;
    }
    if(!this.checkUsernameFormat(name)){
      promptAction.showToast({message:"学号只能包含字母和数字"});
      return;
    }
    if(nick === ""){
      promptAction.showToast({message:"请填写昵称"});
      return;
    }
    if(!this.checkNicknameFormat(nick)){
      promptAction.showToast({message:"昵称需2-5个中文字"});
      return;
    }
    if(pwd === "" || pwd.length <6){
      promptAction.showToast({message:"密码不能少于6位"});
      return;
    }
    if(this.password !== this.confirmPassword){
      promptAction.showToast({message:"两次密码不一致"});
      return;
    }
    if(!this.checkEmailFormat(email)){
      promptAction.showToast({message:"邮箱格式错误"});
      return;
    }
    if(code === ""){
      promptAction.showToast({message:"请填写验证码"});
      return;
    }
    //====新增表单校验 end====
    try {
      let reqData = JSON.stringify({
        username: this.username,
        password: this.password,
        email: this.email,
        code: this.verifyCode,
        nickname: this.nickname
      })
      let res = await ApiClient.post('api/auth/register-email', reqData)

      // 打印响应详情用于调试
      console.info("=== 注册接口响应详情 ===");
      console.info("响应状态码:", res.responseCode);
      console.info("响应结果类型:", typeof res.result);
      console.info("响应结果内容:", res.result);

      // 检查HTTP状态码
      if (res.responseCode !== 200) {
        promptAction.showToast({ message: `服务器错误: ${res.responseCode}` });
        return;
      }

      // 解析响应数据
      let result: RegisterResponse;
      if (typeof res.result === 'string') {
        result = JSON.parse(res.result);
      } else if (typeof res.result === 'object') {
        result = res.result as RegisterResponse;
      } else {
        throw new Error("无法识别的响应格式");
      }

      if (result.code === 200) {
        promptAction.showToast({ message: '注册成功，请前往登录' });
        this.appPathStack.pop();
      } else {
        promptAction.showToast({ message: result.msg });
      }
    } catch (err) {
      // 增强错误日志输出
      if (err) {
        console.error("【注册接口报错详情】", err);
        if (typeof err === 'object') {
          console.error("错误对象属性：", JSON.stringify(err, Object.getOwnPropertyNames(err)));
        }
      } else {
        console.error("【注册接口报错详情】未知错误");
      }
      promptAction.showToast({ message: '服务器连接失败' });
    }
  }

  build() {
    NavDestination() {
      Column({ space: 20 }) {
        Text('新用户注册')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 50 })


        // 学号输入框
        TextInput({ placeholder: '请输入学号', text: this.username })
          .width('85%')
          .onChange((v) => this.username = v)

        // 昵称输入框
        TextInput({ placeholder: '昵称(2-5个中文字)', text: this.nickname })
          .width('85%')
          .onChange((v) => this.nickname = v)

        // 密码输入框
        TextInput({ placeholder: '设置密码(不少于6位)', text: this.password })
          .type(InputType.Password)
          .width('85%')
          .onChange((v) => this.password = v)

        // 确认密码输入框
        TextInput({ placeholder: '再次确认密码', text: this.confirmPassword })
          .type(InputType.Password)
          .width('85%')
          .onChange((v) => this.confirmPassword = v)

        // 邮箱输入框
        TextInput({ placeholder: '请输入邮箱地址', text: this.email })
          .width('85%')
          .onChange((v) => this.email = v)

        // 验证码输入框 + 获取验证码按钮
        Row({ space: 10 }) {
          TextInput({ placeholder: '6位验证码', text: this.verifyCode })
            .layoutWeight(1)
            .type(InputType.Number)
            .onChange((v) => this.verifyCode = v)

          Button(this.isGetCodeDisable ? `${this.countdown}s` : '获取验证码')
            .width(120)
            .enabled(!this.isGetCodeDisable)
            .onClick(() => this.sendEmailCode())
        }
        .width('85%')

        // 完成注册按钮
        Button('完成注册')
          .width('85%')
          .margin({ top: 20 })
          .onClick(() => this.finishRegister())
      }
      .width('100%')
      .height('100%')
      .padding(20)
    }
    .hideTitleBar(true)
    .bindSheet($$this.showCaptchaDialog, this.captchaSheet(), {
      height: 280,
      backgroundColor: Color.White,
      dragBar: false
    })
  }

  // 人机验证弹窗内容
  @Builder
  captchaSheet() {
    Column({ space: 20 }) {
      Text('安全验证')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Text('请拖动滑块完成验证')
        .fontSize(14)
        .fontColor('#666666')

      // 滑块验证区域
      Stack() {
        // 背景轨道
        Row()
          .width('100%')
          .height(40)
          .backgroundColor('#E0E0E0')
          .borderRadius(4)

        // 已滑动区域
        Row()
          .width(`${this.sliderValue}%`)
          .height(40)
          .backgroundColor('#4CAF50')
          .borderRadius(4)

        // 滑块
        Row() {
          Text(this.isCaptchaVerified ? '✓' : '→')
            .fontSize(20)
            .fontColor(Color.White)
        }
        .width(40)
        .height(40)
        .backgroundColor(this.isCaptchaVerified ? '#4CAF50' : '#2196F3')
        .borderRadius(4)
        .margin({ left: `${this.sliderValue}%` })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              if (!this.isCaptchaVerified) {
                let newValue = this.sliderValue + event.offsetX / 3;
                this.sliderValue = Math.max(0, Math.min(100, newValue));
              }
            })
            .onActionEnd(() => {
              if (this.sliderValue >= 95) {
                this.isCaptchaVerified = true;
                this.sliderValue = 100;
                // 验证通过，延迟关闭弹窗并发送验证码
                setTimeout(() => {
                  this.doSendEmailCode();
                }, 500);
              } else {
                // 未滑到底，回弹
                this.sliderValue = 0;
                promptAction.showToast({ message: '请完成滑块验证' });
              }
            })
        )
      }
      .width('85%')
      .height(40)

      // 提示文字
      if (this.isCaptchaVerified) {
        Text('验证成功，正在发送验证码...')
          .fontSize(14)
          .fontColor('#4CAF50')
      }
    }
    .width('100%')
    .padding(20)
  }
}