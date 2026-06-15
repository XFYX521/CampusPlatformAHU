import { promptAction } from '@kit.ArkUI';
import { image } from '@kit.ImageKit';
import { AvatarHelper, AvatarSourceType, AvatarSelectResult } from '../util/AvatarHelper';

/**
 * 头像选择对话框组件
 */
@CustomDialog
export struct AvatarSelectDialog {
  controller: CustomDialogController;
  
  // 回调函数 - 选择完成后调用
  onAvatarSelected?: (pixelMap: image.PixelMap, uri: string) => void;
  
  // 头像辅助类实例
  private avatarHelper: AvatarHelper = AvatarHelper.getInstance();
  
  // 是否正在处理
  @State private isProcessing: boolean = false;

  build() {
    Column() {
      // 标题
      Text('选择头像')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .margin({ top: 24, bottom: 20 })

      // 选项列表
      Column({ space: 12 }) {
        // 从相册选择
        this.OptionItem(
          '从相册选择',
          '选择相册中的图片作为头像',
          () => {
            this.handleSelectFromGallery();
          }
        )

        // 拍照
        this.OptionItem(
          '拍照',
          '使用相机拍摄新照片作为头像',
          () => {
            this.handleTakePhoto();
          }
        )

        // 取消
        Button('取消')
          .width('100%')
          .height(48)
          .fontSize(16)
          .fontColor('#666666')
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
          .margin({ top: 8 })
          .enabled(!this.isProcessing)
          .onClick(() => {
            this.controller.close();
          })
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 24 })
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius({ topLeft: 24, topRight: 24, bottomLeft: 24, bottomRight: 24 })
  }

  /**
   * 选项项组件
   */
  @Builder
  OptionItem(title: string, description: string, onClick: () => void) {
    Row() {
      Column({ space: 4 }) {
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .width('100%')

        Text(description)
          .fontSize(12)
          .fontColor('#999999')
          .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // 箭头图标
      Text('>')
        .fontSize(16)
        .fontColor('#CCCCCC')
    }
    .width('100%')
    .height(64)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#F8F8F8')
    .borderRadius(12)
    .onClick(() => {
      if (!this.isProcessing) {
        onClick();
      }
    })
  }

  /**
   * 从相册选择
   */
  private async handleSelectFromGallery(): Promise<void> {
    if (this.isProcessing) {
      return;
    }

    this.isProcessing = true;
    promptAction.showToast({ message: '正在打开相册...' });

    try {
      const result = await this.avatarHelper.selectFromGallery();
      await this.handleSelectResult(result);
    } catch (error) {
      console.error('AvatarSelectDialog handleSelectFromGallery error:', error);
      promptAction.showToast({ message: '选择图片失败' });
    } finally {
      this.isProcessing = false;
    }
  }

  /**
   * 拍照
   */
  private async handleTakePhoto(): Promise<void> {
    if (this.isProcessing) {
      return;
    }

    this.isProcessing = true;
    promptAction.showToast({ message: '正在打开相机...' });

    try {
      const result = await this.avatarHelper.takePhoto();
      await this.handleSelectResult(result);
    } catch (error) {
      console.error('AvatarSelectDialog handleTakePhoto error:', error);
      promptAction.showToast({ message: '拍照失败' });
    } finally {
      this.isProcessing = false;
    }
  }

  /**
   * 处理选择结果
   */
  private async handleSelectResult(result: AvatarSelectResult | null): Promise<void> {
    if (!result || !result.pixelMap) {
      promptAction.showToast({ message: '未选择图片' });
      return;
    }

    try {
      // 裁剪为圆形头像
      const croppedPixelMap = await this.avatarHelper.cropToCircle(result.pixelMap, 200);
      
      if (!croppedPixelMap) {
        promptAction.showToast({ message: '图片处理失败' });
        return;
      }

      // 调用回调函数
      if (this.onAvatarSelected) {
        this.onAvatarSelected(croppedPixelMap, result.uri);
      }

      // 关闭对话框
      this.controller.close();
      
      promptAction.showToast({ message: '头像选择成功' });
    } catch (error) {
      console.error('AvatarSelectDialog handleSelectResult error:', error);
      promptAction.showToast({ message: '图片处理失败' });
    }
  }
}
