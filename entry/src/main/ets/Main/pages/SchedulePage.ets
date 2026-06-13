import { webview } from '@kit.ArkWeb';
import { preferences } from '@kit.ArkData';
import { common } from '@kit.AbilityKit';

const SCHEDULE_URL_KEY = 'schedule_url';

@Component
export struct SchedulePage {
  @State scheduleUrl: string = '';
  @State showDialog: boolean = false;
  @State inputUrl: string = '';
  @State isLoading: boolean = false;
  @State refreshKey: number = 0;

  private context = getContext(this) as common.UIAbilityContext;
  private prefs: preferences.Preferences | null = null;
  private webController: webview.WebviewController = new webview.WebviewController();

  async aboutToAppear() {
    // 初始化偏好设置并读取保存的链接
    try {
      this.prefs = await preferences.getPreferences(this.context, 'SchedulePrefs');
      const savedUrl = await this.prefs.getSync(SCHEDULE_URL_KEY, '') as string;

      if (savedUrl && savedUrl.length > 0) {
        // 有保存的链接，直接加载
        this.scheduleUrl = savedUrl;
      }
      // 没有保存的链接时不弹出窗口，等待用户点击"导入课表"按钮
    } catch (err) {
      console.error('初始化失败:', err);
    }
  }

  // 保存并加载课表
  async saveAndLoad(url: string) {
    if (!url || url.trim().length === 0) {
      return;
    }

    // 确保 URL 格式正确
    let finalUrl = url.trim();
    if (!finalUrl.startsWith('http://') && !finalUrl.startsWith('https://')) {
      finalUrl = 'https://' + finalUrl;
    }

    // 保存链接到本地
    if (this.prefs) {
      await this.prefs.put(SCHEDULE_URL_KEY, finalUrl);
      await this.prefs.flush();
    }

    // 关闭对话框，直接更新
    this.showDialog = false;
    this.scheduleUrl = finalUrl;
    this.refreshKey++;
  }

  build() {
    Column() {
      // 中间 WebView 区域
      if (this.scheduleUrl.length > 0) {
        Stack() {
          Web({ src: this.scheduleUrl, controller: this.webController })
            .key(this.refreshKey.toString())
            .width('100%')
            .height('100%')
            .javaScriptAccess(true)
            .domStorageAccess(true)
            .mixedMode(MixedMode.All)
            .cacheMode(CacheMode.Default)
            .databaseAccess(true)
            .geolocationAccess(false)
            .onPageBegin(() => {
              this.isLoading = true;
            })
            .onPageEnd(() => {
              this.isLoading = false;
            })
            .onErrorReceive(() => {
              this.isLoading = false;
            })

          // 加载中提示
          if (this.isLoading) {
            Column() {
              LoadingProgress()
                .width(50)
                .height(50)
                .color('#4A90E2')
              Text('正在加载课表...')
                .fontSize(14)
                .fontColor('#666666')
                .margin({ top: 10 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .backgroundColor('rgba(255, 255, 255, 0.9)')
          }
        }
        .width('100%')
        .layoutWeight(1)
      } else {
        // 无链接时显示提示
        Column() {
          Text('暂无课表')
            .fontSize(16)
            .fontColor('#999999')
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }

      // 底部按钮 - 根据是否有链接显示不同按钮
      if (this.scheduleUrl.length > 0) {
        // 有链接时显示返回和更换课表按钮
        Row() {
          Button('返回')
            .layoutWeight(1)
            .height(45)
            .onClick(() => {
              // 返回上一个网页
              this.webController.backward();
            })

          Blank().width(10)

          Button('更换课表')
            .layoutWeight(1)
            .height(45)
            .onClick(() => {
              this.inputUrl = '';
              this.showDialog = true;
            })
        }
        .width('90%')
        .margin({ bottom: 20, top: 10 })
      } else {
        // 无链接时显示导入课表按钮
        Button('导入课表')
          .width('90%')
          .height(45)
          .margin({ bottom: 20, top: 10 })
          .onClick(() => {
            this.inputUrl = '';
            this.showDialog = true;
          })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .bindSheet($$this.showDialog, this.inputDialog(), {
      height: 280,
      backgroundColor: Color.White,
      dragBar: false
    })
  }

  // 输入链接弹窗
  @Builder
  inputDialog() {
    Column() {
      Text('输入课表链接')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      TextInput({ placeholder: '请粘贴课表网址链接', text: $$this.inputUrl })
        .width('85%')
        .height(45)
        .fontSize(14)
        .margin({ bottom: 20 })

      Row() {
        Button('取消')
          .width('35%')
          .height(40)
          .backgroundColor('#E0E0E0')
          .fontColor('#666666')
          .onClick(() => {
            this.showDialog = false;
          })

        Blank().width('10%')

        Button('确定')
          .width('35%')
          .height(40)
          .onClick(() => {
            this.saveAndLoad(this.inputUrl);
          })
      }
      .width('85%')
    }
    .width('100%')
    .padding(20)
  }
}
