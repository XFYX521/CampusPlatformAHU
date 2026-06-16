import http from '@ohos.net.http';
import { promptAction } from '@kit.ArkUI';

/**
 * 后端响应接口
 */
interface FeedbackResponse {
  code: number;
  msg: string;
  data?: Record<string, Object>;
}

/**
 * 业务错误接口
 */
interface BusinessError {
  code: number | string;
  message?: string;
}

/**
 * 用户反馈页面
 * 实现完整的反馈流程：
 * 1. 用户点击反馈入口 → 跳转至反馈编辑页面
 * 2. 输入标题与内容
 * 3. 点击提交 → 前端校验
 * 4. 显示加载状态 → 调用后端接口
 * 5. 提交成功/失败提示 → 返回原页面或清空表单
 * 
 * 接口规范：
 * - 接口路径：POST /api/feedback
 * - 请求头：Authorization: Bearer token
 * - 请求体：{ title: string, content: string }
 */
@Entry
export struct FeedbackPage {
  // 路由栈，用于页面导航
  @Consume('appPathStack') appPathStack: NavPathStack;
  
  // 表单数据
  @State feedbackTitle: string = '';
  @State feedbackContent: string = '';
  
  // UI状态
  @State isSubmitting: boolean = false;
  @State titleError: string = '';
  @State contentError: string = '';
  
  // 用户认证信息
  @StorageLink('token') token: string = '';
  @StorageLink('isLoggedIn') isLoggedIn: boolean = false;
  
  // 反馈接口地址
  private readonly feedbackUrl: string = "https://backend.hoshikaze.top/api/feedback";

  build() {
    NavDestination() {
      Column() {
        // 顶部导航栏
        this.NavigationBar()
        
        // 主内容区域
        Scroll() {
          Column() {
            // 反馈说明
            this.FeedbackHeader()
            
            // 反馈表单
            this.FeedbackForm()
            
            // 底部提示
            this.FeedbackFooter()
          }
          .width('100%')
          .padding({ left: 20, right: 20, bottom: 20 })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.page_bg_color'))
    }
    .hideTitleBar(true)
  }

  /**
   * 顶部导航栏
   */
  @Builder
  NavigationBar() {
    Row() {
      // 返回按钮
      Row({ space: 4 }) {
        Text('〈')
          .fontSize(24)
          .fontColor($r('app.color.page_title_font_color'))
          .fontWeight(FontWeight.Bold)
        
        Text('返回')
          .fontSize(16)
          .fontColor($r('app.color.page_title_font_color'))
      }
      .padding({ left: 12, right: 16, top: 8, bottom: 8 })
      .borderRadius(20)
      .backgroundColor($r('app.color.page_bg_color'))
      .onClick(() => {
        this.appPathStack.pop();
      })

      // 页面标题
      Text('用户反馈')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.page_title_font_color'))
        .margin({ left: 15 })
        .layoutWeight(1)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 20 })
    .backgroundColor(Color.White)
  }

  /**
   * 反馈说明头部
   */
  @Builder
  FeedbackHeader() {
    Column() {
      Text('感谢您的反馈')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.page_title_font_color'))
        .margin({ bottom: 8 })

      Text('您的意见和建议是我们改进的动力')
        .fontSize(14)
        .fontColor($r('app.color.font_tertiary'))
    }
    .width('100%')
    .padding({ top: 25, bottom: 25 })
    .alignItems(HorizontalAlign.Start)
  }

  /**
   * 反馈表单
   */
  @Builder
  FeedbackForm() {
    Column({ space: 20 }) {
      // 标题输入
      this.TitleInput()
      
      // 内容输入
      this.ContentInput()
      
      // 提交按钮
      this.SubmitButton()
    }
    .width('100%')
  }

  /**
   * 标题输入框
   */
  @Builder
  TitleInput() {
    Column({ space: 8 }) {
      Row() {
        Text('反馈标题')
          .fontSize(16)
          .fontColor($r('app.color.content_main_title_font_color'))
          .layoutWeight(1)

        Text(`${this.feedbackTitle.length}/50`)
          .fontSize(12)
          .fontColor($r('app.color.font_tertiary'))
      }
      .width('100%')

      TextInput({ placeholder: '请输入反馈标题（必填）', text: this.feedbackTitle })
        .width('100%')
        .height(50)
        .backgroundColor(Color.White)
        .borderRadius(8)
        .border({
          width: 1,
          color: this.titleError ? $r('app.color.warning') : $r('app.color.comp_divider')
        })
        .padding({ left: 15, right: 15 })
        .onChange((value: string) => {
          if (value.length <= 50) {
            this.feedbackTitle = value;
            this.titleError = '';
          }
        })
        .onBlur(() => {
          this.validateTitle();
        })

      // 错误提示
      if (this.titleError) {
        Text(this.titleError)
          .fontSize(12)
          .fontColor($r('app.color.warning'))
          .alignSelf(ItemAlign.Start)
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  /**
   * 内容输入框
   */
  @Builder
  ContentInput() {
    Column({ space: 8 }) {
      Row() {
        Text('反馈内容')
          .fontSize(16)
          .fontColor($r('app.color.content_main_title_font_color'))
          .layoutWeight(1)

        Text(`${this.feedbackContent.length}/500`)
          .fontSize(12)
          .fontColor($r('app.color.font_tertiary'))
      }
      .width('100%')

      TextArea({ placeholder: '请详细描述您的问题或建议（必填）', text: this.feedbackContent })
        .width('100%')
        .height(200)
        .backgroundColor(Color.White)
        .borderRadius(8)
        .border({
          width: 1,
          color: this.contentError ? $r('app.color.warning') : $r('app.color.comp_divider')
        })
        .padding(15)
        .onChange((value: string) => {
          if (value.length <= 500) {
            this.feedbackContent = value;
            this.contentError = '';
          }
        })
        .onBlur(() => {
          this.validateContent();
        })

      // 错误提示
      if (this.contentError) {
        Text(this.contentError)
          .fontSize(12)
          .fontColor($r('app.color.warning'))
          .alignSelf(ItemAlign.Start)
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  /**
   * 提交按钮
   */
  @Builder
  SubmitButton() {
    Column() {
      Button(this.isSubmitting ? '提交中...' : '提交反馈')
        .width('100%')
        .height(50)
        .fontSize(16)
        .fontColor(Color.White)
        .backgroundColor($r('app.color.app_icon_pressed_color'))
        .borderRadius(8)
        .enabled(this.canSubmit())
        .opacity(this.canSubmit() ? 1 : 0.5)
        .onClick(() => this.handleSubmitFeedback())

      // 提交提示
      if (this.isSubmitting) {
        Row({ space: 8 }) {
          LoadingProgress()
            .width(16)
            .height(16)
            .color($r('app.color.app_icon_pressed_color'))

          Text('正在提交，请稍候...')
            .fontSize(14)
            .fontColor($r('app.color.font_tertiary'))
        }
        .margin({ top: 12 })
      }
    }
    .width('100%')
    .margin({ top: 10 })
  }

  /**
   * 底部提示
   */
  @Builder
  FeedbackFooter() {
    Column() {
      Divider()
        .strokeWidth(1)
        .color($r('app.color.comp_divider'))
        .margin({ bottom: 15 })

      Text('我们会在1-3个工作日内处理您的反馈')
        .fontSize(12)
        .fontColor($r('app.color.font_tertiary'))
        .margin({ bottom: 5 })

      Text('如有紧急问题，请联系客服')
        .fontSize(12)
        .fontColor($r('app.color.font_tertiary'))
    }
    .width('100%')
    .padding({ top: 20 })
    .alignItems(HorizontalAlign.Center)
  }

  /**
   * 验证标题
   */
  private validateTitle(): boolean {
    const title = this.feedbackTitle.trim();
    
    if (title === '') {
      this.titleError = '请输入反馈标题';
      return false;
    }
    
    if (title.length > 50) {
      this.titleError = '标题不能超过50个字符';
      return false;
    }
    
    this.titleError = '';
    return true;
  }

  /**
   * 验证内容
   */
  private validateContent(): boolean {
    const content = this.feedbackContent.trim();
    
    if (content === '') {
      this.contentError = '请输入反馈内容';
      return false;
    }
    
    if (content.length > 500) {
      this.contentError = '内容不能超过500个字符';
      return false;
    }
    
    this.contentError = '';
    return true;
  }

  /**
   * 判断是否可以提交
   */
  private canSubmit(): boolean {
    return !this.isSubmitting && 
           this.feedbackTitle.trim() !== '' && 
           this.feedbackContent.trim() !== '' &&
           this.feedbackTitle.length <= 50 &&
           this.feedbackContent.length <= 500;
  }

  /**
   * 处理提交反馈
   * 实现完整的提交流程：
   * 1. 前端校验
   * 2. 显示加载状态
   * 3. 调用后端接口
   * 4. 处理响应结果
   * 5. 成功/失败提示
   * 6. 清空表单或返回
   */
  private async handleSubmitFeedback(): Promise<void> {
    // 步骤1: 前端校验
    const isTitleValid = this.validateTitle();
    const isContentValid = this.validateContent();
    
    if (!isTitleValid || !isContentValid) {
      return;
    }

    // 检查登录状态
    if (!this.isLoggedIn || !this.token) {
      promptAction.showToast({ message: '请先登录' });
      setTimeout(() => {
        this.appPathStack.pushPathByName('LoginPage', null);
      }, 1000);
      return;
    }

    // 步骤2: 显示加载状态
    this.isSubmitting = true;

    // 步骤3: 调用后端接口
    // 接口规范：POST /api/feedback
    // 请求头：Authorization: Bearer token
    // 请求体：{ title: string, content: string }
    const httpRequest = http.createHttp();
    const requestData = JSON.stringify({
      title: this.feedbackTitle.trim(),
      content: this.feedbackContent.trim()
    });

    console.info("=== 反馈提交请求 ===");
    console.info("URL:", this.feedbackUrl);
    console.info("Method: POST");
    console.info("Header: Authorization: Bearer [token]");
    console.info("Body:", requestData);

    try {
      const response = await httpRequest.request(this.feedbackUrl, {
        method: http.RequestMethod.POST,
        header: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${this.token}`
        },
        extraData: requestData,
        connectTimeout: 30000,
        readTimeout: 30000
      });

      console.info("=== 反馈提交响应 ===");
      console.info("HTTP状态码:", response.responseCode);
      console.info("响应结果:", response.result);

      // 步骤4: 处理响应结果
      await this.handleResponse(response);

    } catch (error) {
      // 步骤5: 失败提示 - 网络错误
      this.handleNetworkError(error);
    } finally {
      this.isSubmitting = false;
      httpRequest.destroy();
    }
  }

  /**
   * 处理响应结果
   */
  private async handleResponse(response: http.HttpResponse): Promise<void> {
    // 处理HTTP状态码异常
    if (response.responseCode !== 200) {
      if (response.responseCode === 401) {
        promptAction.showToast({ message: '登录已过期，请重新登录' });
        AppStorage.setOrCreate('token', '');
        AppStorage.setOrCreate('isLoggedIn', false);
        setTimeout(() => {
          this.appPathStack.pushPathByName('LoginPage', null);
        }, 1500);
      } else {
        promptAction.showToast({ message: `提交失败（${response.responseCode}），请稍后重试` });
      }
      return;
    }

    // 解析响应数据
    let result: FeedbackResponse;
    try {
      if (typeof response.result === 'string') {
        result = JSON.parse(response.result);
      } else if (typeof response.result === 'object') {
        result = response.result as FeedbackResponse;
      } else {
        throw new Error('无法识别的响应格式');
      }
    } catch (parseError) {
      console.error("响应解析失败:", parseError);
      promptAction.showToast({ message: '响应数据格式错误' });
      return;
    }

    // 步骤5: 成功/失败提示
    if (result.code === 200) {
      // 提交成功
      promptAction.showToast({ message: '反馈提交成功，感谢您的反馈！' });
      
      // 步骤6: 清空表单并返回
      this.resetForm();
      
      setTimeout(() => {
        this.appPathStack.pop();
      }, 1500);
    } else {
      // 业务错误
      console.error("业务错误:", result.code, result.msg);
      promptAction.showToast({ message: result.msg || '反馈提交失败，请重试' });
    }
  }

  /**
   * 处理网络错误
   */
  private handleNetworkError(error: Error | BusinessError): void {
    console.error("=== 网络错误详情 ===");
    console.error("Error:", error);

    let errorMsg = '网络连接失败，请检查网络设置';
    
    const businessErr = error as BusinessError;
    if (businessErr.code !== undefined) {
      switch (businessErr.code) {
        case -1:
        case '-1':
          errorMsg = '网络连接超时，请检查网络';
          break;
        case -2:
        case '-2':
          errorMsg = '服务器连接失败，请稍后重试';
          break;
        case 401:
        case '401':
          errorMsg = '登录已过期，请重新登录';
          AppStorage.setOrCreate('token', '');
          AppStorage.setOrCreate('isLoggedIn', false);
          setTimeout(() => {
            this.appPathStack.pushPathByName('LoginPage', null);
          }, 1500);
          break;
        default:
          errorMsg = `请求失败（${businessErr.code}），请重试`;
      }
    }

    promptAction.showToast({ message: errorMsg });
  }

  /**
   * 重置表单
   */
  private resetForm(): void {
    this.feedbackTitle = '';
    this.feedbackContent = '';
    this.titleError = '';
    this.contentError = '';
  }
}
