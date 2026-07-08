import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { cameraPicker } from '@kit.CameraKit';
import { camera } from '@kit.CameraKit';
import { image } from '@kit.ImageKit';
import { fileIo } from '@kit.CoreFileKit';
import http from '@ohos.net.http';
import { ApiClient } from './ApiClient';
import type { ApiRequestOptions } from './ApiClient';
import { promptAction } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { abilityAccessCtrl, Permissions } from '@kit.AbilityKit';
import { util } from '@kit.ArkTS';

/**
 * 上传头像响应数据
 */
interface UploadAvatarData {
  avatar?: string;
}

/**
 * 上传头像响应接口
 */
interface UploadAvatarResponse {
  code: number;
  message?: string;
  data?: UploadAvatarData;
}

/**
 * 获取头像响应数据
 */
interface FetchAvatarData {
  avatar?: string;
}

/**
 * 获取头像响应接口
 */
interface FetchAvatarResponse {
  code: number;
  message?: string;
  data?: FetchAvatarData;
}

/**
 * 头像选择来源类型
 */
export enum AvatarSourceType {
  GALLERY = 'gallery',  // 从相册选择
  CAMERA = 'camera'     // 拍照
}

/**
 * 头像选择结果
 */
export interface AvatarSelectResult {
  uri: string;           // 图片URI
  pixelMap?: image.PixelMap;  // PixelMap对象
  width: number;         // 图片宽度
  height: number;        // 图片高度
}

/**
 * 头像上传结果
 */
export interface AvatarUploadResult {
  success: boolean;
  url?: string;          // 上传后的URL
  message?: string;      // 提示信息
}

/**
 * 头像辅助类
 * 提供头像选择、裁剪和上传功能
 */
export class AvatarHelper {
  private static instance: AvatarHelper;
  private context: common.UIAbilityContext | null = null;

  private constructor() {}

  /**
   * 获取单例实例
   */
  static getInstance(): AvatarHelper {
    if (!AvatarHelper.instance) {
      AvatarHelper.instance = new AvatarHelper();
    }
    return AvatarHelper.instance;
  }

  /**
   * 设置上下文
   */
  setContext(context: common.UIAbilityContext): void {
    this.context = context;
  }

  /**
   * 检查并申请相机权限
   */
  private async requestCameraPermission(): Promise<boolean> {
    try {
      if (!this.context) {
        console.error('AvatarHelper requestCameraPermission: context is null');
        return false;
      }

      const atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
      const permission: Permissions = 'ohos.permission.CAMERA';
      
      // 检查权限状态
      const grantStatus: abilityAccessCtrl.GrantStatus = await atManager.checkAccessToken(
        this.context.applicationInfo.accessTokenId,
        permission
      );

      if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
        console.info('AvatarHelper: camera permission already granted');
        return true;
      }

      // 申请权限
      const result = await atManager.requestPermissionsFromUser(
        this.context,
        [permission]
      );

      if (result.authResults[0] === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
        console.info('AvatarHelper: camera permission granted');
        return true;
      } else {
        console.error('AvatarHelper: camera permission denied');
        promptAction.showToast({ message: '需要相机权限才能拍照' });
        return false;
      }
    } catch (error) {
      const err = error as BusinessError;
      console.error('AvatarHelper requestCameraPermission error:', err.code, err.message);
      return false;
    }
  }

  /**
   * 从相册选择图片
   */
  async selectFromGallery(): Promise<AvatarSelectResult | null> {
    try {
      // 创建PhotoViewPicker实例
      const photoPicker = new photoAccessHelper.PhotoViewPicker();
      
      // 配置选择选项
      const photoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
      photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
      photoSelectOptions.maxSelectNumber = 1; // 只选择一张图片

      // 调用选择器
      const result = await photoPicker.select(photoSelectOptions);
      
      if (result.photoUris && result.photoUris.length > 0) {
        const uri = result.photoUris[0];
        return await this.processSelectedImage(uri);
      }
      
      return null;
    } catch (error) {
      const err = error as BusinessError;
      console.error('AvatarHelper selectFromGallery error:', err.code, err.message);
      promptAction.showToast({ message: '选择图片失败' });
      return null;
    }
  }

  /**
   * 拍照获取图片
   */
  async takePhoto(): Promise<AvatarSelectResult | null> {
    try {
      if (!this.context) {
        promptAction.showToast({ message: '上下文未初始化' });
        return null;
      }

      // 检查并申请相机权限
      const hasPermission: boolean = await this.requestCameraPermission();
      if (!hasPermission) {
        return null;
      }

      console.info('AvatarHelper: starting camera picker...');

      // 配置拍照参数
      const pickerProfile: cameraPicker.PickerProfile = {
        cameraPosition: camera.CameraPosition.CAMERA_POSITION_BACK // 使用后置摄像头
      };

      // 调用相机拍照
      const pickerResult = await cameraPicker.pick(
        this.context,
        [cameraPicker.PickerMediaType.PHOTO],
        pickerProfile
      );

      console.info('AvatarHelper: camera picker result:', JSON.stringify({
        resultCode: pickerResult.resultCode,
        resultUri: pickerResult.resultUri
      }));

      if (pickerResult.resultCode === 0 && pickerResult.resultUri) {
        console.info('AvatarHelper: processing captured photo...');
        return await this.processSelectedImage(pickerResult.resultUri);
      } else {
        console.error('AvatarHelper: camera picker failed, resultCode:', pickerResult.resultCode);
        promptAction.showToast({ message: '拍照取消或失败' });
        return null;
      }
    } catch (error) {
      const err = error as BusinessError;
      console.error('AvatarHelper takePhoto error:', err.code, err.message);
      promptAction.showToast({ message: `拍照失败: ${err.message}` });
      return null;
    }
  }

  /**
   * 处理选中的图片
   */
  private async processSelectedImage(uri: string): Promise<AvatarSelectResult | null> {
    try {
      // 打开文件
      const file = fileIo.openSync(uri, fileIo.OpenMode.READ_ONLY);
      
      // 创建ImageSource
      const imageSource = image.createImageSource(file.fd);
      
      // 获取图片信息
      const imageInfo = await imageSource.getImageInfo();
      
      // 创建PixelMap
      const pixelMap = await imageSource.createPixelMap();
      
      // 关闭文件
      fileIo.closeSync(file);

      return {
        uri: uri,
        pixelMap: pixelMap,
        width: imageInfo.size.width,
        height: imageInfo.size.height
      };
    } catch (error) {
      const err = error as BusinessError;
      console.error('AvatarHelper processSelectedImage error:', err.code, err.message);
      return null;
    }
  }

  /**
   * 裁剪图片为圆形头像
   * @param pixelMap 原始PixelMap
   * @param size 目标尺寸(正方形)
   */
  async cropToCircle(pixelMap: image.PixelMap, size: number = 200): Promise<image.PixelMap | null> {
    try {
      // 获取原图信息
      const imageInfo = await pixelMap.getImageInfo();
      const width = imageInfo.size.width;
      const height = imageInfo.size.height;

      // 计算裁剪区域(取中心正方形)
      const minSize = Math.min(width, height);
      const startX = (width - minSize) / 2;
      const startY = (height - minSize) / 2;

      // 裁剪为正方形
      await pixelMap.crop({
        x: startX,
        y: startY,
        size: { width: minSize, height: minSize }
      });

      // 缩放到目标尺寸
      const scale = size / minSize;
      await pixelMap.scale(scale, scale);

      return pixelMap;
    } catch (error) {
      const err = error as BusinessError;
      console.error('AvatarHelper cropToCircle error:', err.code, err.message);
      return null;
    }
  }

  /**
   * 将PixelMap转换为ArrayBuffer
   */
  async pixelMapToArrayBuffer(pixelMap: image.PixelMap): Promise<ArrayBuffer | null> {
    try {
      const imagePackerApi = image.createImagePacker();
      const packOpts: image.PackingOption = {
        format: 'image/jpeg',
        quality: 90
      };
      
      const buffer = await imagePackerApi.packToData(pixelMap, packOpts);
      return buffer;
    } catch (error) {
      const err = error as BusinessError;
      console.error('AvatarHelper pixelMapToArrayBuffer error:', err.code, err.message);
      return null;
    }
  }

  /**
   * 将字符串转换为ArrayBuffer
   */
  private stringToArrayBuffer(str: string): ArrayBuffer {
    const buffer = new ArrayBuffer(str.length);
    const view = new Uint8Array(buffer);
    for (let i = 0; i < str.length; i++) {
      view[i] = str.charCodeAt(i);
    }
    return buffer;
  }

  /**
   * 上传头像到服务器
   * @param imageBuffer 图片数据
   * @param uploadUrl 上传接口URL
   */
  async uploadAvatar(imageBuffer: ArrayBuffer, uploadUrl: string): Promise<AvatarUploadResult> {
    try {
      // 创建HTTP请求
      const httpRequest: http.HttpRequest = http.createHttp();
      
      // 构建multipart/form-data请求
      const boundary: string = '----WebKitFormBoundary' + Date.now().toString();
      const contentType: string = `multipart/form-data; boundary=${boundary}`;
      
      // 构建请求体
      const header: string = `--${boundary}\r\n`;
      const contentDisposition: string = `Content-Disposition: form-data; name="avatar"; filename="avatar.jpg"\r\n`;
      const contentTypeHeader: string = `Content-Type: image/jpeg\r\n\r\n`;
      const footer: string = `\r\n--${boundary}--\r\n`;
      
      // 合并所有部分
      const headerBuffer: ArrayBuffer = this.stringToArrayBuffer(header + contentDisposition + contentTypeHeader);
      const footerBuffer: ArrayBuffer = this.stringToArrayBuffer(footer);
      
      const totalLength: number = headerBuffer.byteLength + imageBuffer.byteLength + footerBuffer.byteLength;
      const requestBody: ArrayBuffer = new ArrayBuffer(totalLength);
      
      // 拷贝数据
      const requestView: Uint8Array = new Uint8Array(requestBody);
      requestView.set(new Uint8Array(headerBuffer), 0);
      requestView.set(new Uint8Array(imageBuffer), headerBuffer.byteLength);
      requestView.set(new Uint8Array(footerBuffer), headerBuffer.byteLength + imageBuffer.byteLength);

      // 发送请求
      const response: http.HttpResponse = await httpRequest.request(uploadUrl, {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': contentType
        },
        extraData: requestBody
      });

      // 处理响应
      if (response.responseCode === 200) {
        const result: Record<string, Object> = JSON.parse(response.result as string) as Record<string, Object>;
        return {
          success: true,
          url: (result['url'] as string) || ((result['data'] as Record<string, Object>)['url'] as string),
          message: '上传成功'
        };
      } else {
        return {
          success: false,
          message: `上传失败: ${response.responseCode}`
        };
      }
    } catch (error) {
      const err = error as BusinessError;
      console.error('AvatarHelper uploadAvatar error:', err.code, err.message);
      return {
        success: false,
        message: '上传失败,请重试'
      };
    }
  }

  /**
   * 保存图片到本地持久化目录
   */
  async saveToPersistent(pixelMap: image.PixelMap, fileName: string): Promise<string | null> {
    try {
      if (!this.context) {
        return null;
      }

      const imagePackerApi = image.createImagePacker();
      const packOpts: image.PackingOption = {
        format: 'image/jpeg',
        quality: 90
      };
      
      const buffer = await imagePackerApi.packToData(pixelMap, packOpts);
      
      // 保存到持久化目录（filesDir）
      const persistentPath = `${this.context.filesDir}/${fileName}`;
      const file = fileIo.openSync(persistentPath, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
      fileIo.writeSync(file.fd, buffer);
      fileIo.closeSync(file);
      
      console.info('AvatarHelper saveToPersistent success:', persistentPath);
      return persistentPath;
    } catch (error) {
      const err = error as BusinessError;
      console.error('AvatarHelper saveToPersistent error:', err.code, err.message);
      return null;
    }
  }

  /**
   * 直接保存ArrayBuffer到本地持久化目录
   */
  async saveArrayBufferToPersistent(buffer: ArrayBuffer, fileName: string): Promise<string | null> {
    try {
      if (!this.context) {
        console.error('[AvatarHelper] saveArrayBufferToPersistent: context is null');
        return null;
      }

      // 保存到持久化目录（filesDir）
      const persistentPath = `${this.context.filesDir}/${fileName}`;
      const file = fileIo.openSync(persistentPath, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
      fileIo.writeSync(file.fd, buffer);
      fileIo.closeSync(file);
      
      console.info('[AvatarHelper] saveArrayBufferToPersistent: 保存成功, path =', persistentPath);
      return persistentPath;
    } catch (error) {
      const err = error as BusinessError;
      console.error('[AvatarHelper] saveArrayBufferToPersistent: 保存失败 =', err.code, err.message);
      return null;
    }
  }

  /**
   * 从本地加载头像
   */
  async loadAvatar(avatarPath: string): Promise<image.PixelMap | null> {
    try {
      if (!avatarPath || avatarPath.trim() === '') {
        return null;
      }

      // 检查文件是否存在
      const stat = fileIo.statSync(avatarPath);
      if (!stat) {
        console.error('AvatarHelper loadAvatar: file not exists');
        return null;
      }

      // 打开文件
      const file = fileIo.openSync(avatarPath, fileIo.OpenMode.READ_ONLY);
      
      // 创建ImageSource
      const imageSource = image.createImageSource(file.fd);
      
      // 创建PixelMap
      const pixelMap = await imageSource.createPixelMap();
      
      // 关闭文件
      fileIo.closeSync(file);
      
      console.info('AvatarHelper loadAvatar success');
      return pixelMap;
    } catch (error) {
      const err = error as BusinessError;
      console.error('AvatarHelper loadAvatar error:', err.code, err.message);
      return null;
    }
  }

  /**
   * 上传头像到服务器
   * @param pixelMap 头像PixelMap对象
   * @param token 用户token
   * @returns 上传结果
   */
  async uploadAvatarToServer(pixelMap: image.PixelMap, token: string): Promise<AvatarUploadResult> {
    try {
      // 1. 将PixelMap转换为base64（使用JPEG格式，更小的体积）
      const imagePackerApi = image.createImagePacker();
      const packOpts: image.PackingOption = {
        format: 'image/jpeg',
        quality: 60  // 降低质量以减小体积
      };
      
      const buffer = await imagePackerApi.packToData(pixelMap, packOpts);
      
      // 2. 转换为base64字符串
      const base64String = this.arrayBufferToBase64(buffer);
      const avatarData = `data:image/jpeg;base64,${base64String}`;
      
      console.info('AvatarHelper: base64 length =', base64String.length);
      console.info('AvatarHelper: buffer size =', buffer.byteLength, 'bytes');
      
      // 3. 发送HTTP请求
      const requestBody = JSON.stringify({ avatar: avatarData });
      const postOptions: ApiRequestOptions = { token: token };
      const response = await ApiClient.post('user/avatar', requestBody, postOptions);
      
      console.info('AvatarHelper upload response:', JSON.stringify(response));
      
      // 4. 处理响应
      if (response.responseCode === 200) {
        const result: UploadAvatarResponse = JSON.parse(response.result as string);
        if (result.code === 200 && result.data?.avatar) {
          console.info('AvatarHelper: upload success, avatar =', result.data.avatar);
          return {
            success: true,
            url: result.data.avatar,
            message: result.message || '头像上传成功'
          };
        } else {
          console.error('AvatarHelper: upload failed, result =', JSON.stringify(result));
          return {
            success: false,
            message: result.message || '上传失败'
          };
        }
      } else {
        console.error('AvatarHelper: upload failed, responseCode =', response.responseCode);
        return {
          success: false,
          message: `上传失败: ${response.responseCode}`
        };
      }
    } catch (error) {
      const err = error as BusinessError;
      console.error('AvatarHelper uploadAvatarToServer error:', err.code, err.message);
      return {
        success: false,
        message: `上传异常: ${err.message}`
      };
    }
  }

  /**
   * 从服务器获取头像
   * @param account 用户账号
   * @returns 头像URL或null
   */
  async fetchAvatarFromServer(account: string): Promise<string | null> {
    try {
      console.info('[AvatarHelper] fetchAvatarFromServer: 开始获取头像');
      console.info('[AvatarHelper] fetchAvatarFromServer: account =', account);
      
      const response = await ApiClient.get(`user/avatar?account=${encodeURIComponent(account)}`);
      
      console.info('[AvatarHelper] fetchAvatarFromServer: responseCode =', response.responseCode);
      console.info('[AvatarHelper] fetchAvatarFromServer: result type =', typeof response.result);
      
      if (response.responseCode === 200 && response.result) {
        // 检查返回的是图片还是JSON
        if (response.result instanceof ArrayBuffer) {
          const arrayBuffer = response.result as ArrayBuffer;
          const uint8Array = new Uint8Array(arrayBuffer);
          
          // 检查是否是PNG图片 (PNG文件头: 89 50 4E 47)
          const isPNG = uint8Array[0] === 0x89 && uint8Array[1] === 0x50 && 
                        uint8Array[2] === 0x4E && uint8Array[3] === 0x47;
          
          // 检查是否是JPEG图片 (JPEG文件头: FF D8 FF)
          const isJPEG = uint8Array[0] === 0xFF && uint8Array[1] === 0xD8 && uint8Array[2] === 0xFF;
          
          if (isPNG || isJPEG) {
            console.info('[AvatarHelper] fetchAvatarFromServer: 接口直接返回图片, type =', isPNG ? 'PNG' : 'JPEG');
            // 直接保存图片
            const fileName = `avatar_${account}.jpg`;
            const localPath = await this.saveArrayBufferToPersistent(arrayBuffer, fileName);
            console.info('[AvatarHelper] fetchAvatarFromServer: 图片已保存到 =', localPath);
            return localPath; // 返回本地路径
          }
          
          // 尝试解析为JSON
          const decoder = new util.TextDecoder('utf-8');
          const resultStr = decoder.decodeToString(uint8Array);
          console.info('[AvatarHelper] fetchAvatarFromServer: result string =', resultStr);
          
          const result: FetchAvatarResponse = JSON.parse(resultStr);
          console.info('[AvatarHelper] fetchAvatarFromServer: parsed code =', result.code);
          console.info('[AvatarHelper] fetchAvatarFromServer: parsed data =', JSON.stringify(result.data));
          
          if (result.code === 200 && result.data?.avatar) {
            const avatarUrl = result.data.avatar;
            console.info('[AvatarHelper] fetchAvatarFromServer: 成功获取头像URL =', avatarUrl);
            return avatarUrl;
          } else {
            console.warn('[AvatarHelper] fetchAvatarFromServer: avatar字段为空或不存在');
          }
        } else {
          // 字符串类型
          const resultStr = response.result as string;
          console.info('[AvatarHelper] fetchAvatarFromServer: result string =', resultStr);
          
          const result: FetchAvatarResponse = JSON.parse(resultStr);
          if (result.code === 200 && result.data?.avatar) {
            return result.data.avatar;
          }
        }
      } else {
        console.error('[AvatarHelper] fetchAvatarFromServer: HTTP错误, code =', response.responseCode);
      }
      
      return null;
    } catch (error) {
      const err = error as BusinessError;
      console.error('[AvatarHelper] fetchAvatarFromServer: 异常 =', err.code, err.message);
      return null;
    }
  }

  /**
   * ArrayBuffer转Base64字符串
   */
  private arrayBufferToBase64(buffer: ArrayBuffer): string {
    const base64Helper = new util.Base64Helper();
    const bytes = new Uint8Array(buffer);
    const result = base64Helper.encodeToStringSync(bytes);
    return result;
  }

  /**
   * 压缩图片到指定大小（默认128KB）
   * @param pixelMap 原始图片
   * @param maxSizeKB 最大大小（KB）
   * @returns 压缩后的PixelMap
   */
  async compressImage(pixelMap: image.PixelMap, maxSizeKB: number = 128): Promise<image.PixelMap> {
    try {
      // 获取原始尺寸
      const imageInfo = await pixelMap.getImageInfo();
      let width = imageInfo.size.width;
      let height = imageInfo.size.height;
      
      // 初始质量
      let quality = 90;
      let compressedPixelMap = pixelMap;
      
      // 循环压缩直到满足大小要求
      while (quality >= 10) {
        // 创建新的PixelMap用于压缩
        const packingOptions: image.PackingOption = {
          format: 'image/jpeg',
          quality: quality
        };
        
        const imagePackerApi = image.createImagePacker();
        const packData = await imagePackerApi.packing(pixelMap, packingOptions);
        const packSize = packData.byteLength;
        imagePackerApi.release();
        
        // 检查大小
        const sizeKB = packSize / 1024;
        console.info(`AvatarHelper: quality=${quality}, size=${sizeKB.toFixed(2)}KB`);
        
        if (sizeKB <= maxSizeKB) {
          // 大小满足要求，解码回PixelMap
          const imageSource = image.createImageSource(packData);
          compressedPixelMap = await imageSource.createPixelMap();
          imageSource.release();
          break;
        }
        
        // 降低质量继续尝试
        quality -= 10;
      }
      
      // 如果质量降到最低仍然太大，缩小尺寸
      const finalInfo = await compressedPixelMap.getImageInfo();
      const finalPackingOptions: image.PackingOption = {
        format: 'image/jpeg',
        quality: 70
      };
      const finalPacker = image.createImagePacker();
      const finalPackData = await finalPacker.packing(compressedPixelMap, finalPackingOptions);
      const finalSizeKB = finalPackData.byteLength / 1024;
      finalPacker.release();
      
      if (finalSizeKB > maxSizeKB) {
        // 缩小尺寸
        const scale = Math.sqrt(maxSizeKB / finalSizeKB);
        const newWidth = Math.floor(finalInfo.size.width * scale);
        const newHeight = Math.floor(finalInfo.size.height * scale);
        
        console.info(`AvatarHelper: scaling image to ${newWidth}x${newHeight}`);
        
        // 创建缩放后的PixelMap
        const imageSource = image.createImageSource(finalPackData);
        const decodingOptions: image.DecodingOptions = {
          desiredSize: { width: newWidth, height: newHeight }
        };
        compressedPixelMap = await imageSource.createPixelMap(decodingOptions);
        imageSource.release();
      }
      
      console.info('AvatarHelper: image compressed successfully');
      return compressedPixelMap;
    } catch (error) {
      console.error('AvatarHelper compressImage error:', error);
      return pixelMap; // 返回原图
    }
  }

  /**
   * 下载头像并保存到本地
   * @param avatarUrl 头像URL（如 "/avatars/u1_123.png"）
   * @param account 用户账号
   * @returns 本地保存路径
   */
  async downloadAndSaveAvatar(avatarUrl: string, account: string): Promise<string | null> {
    try {
      console.info('[AvatarHelper] downloadAndSaveAvatar: 开始下载头像');
      console.info('[AvatarHelper] downloadAndSaveAvatar: avatarUrl =', avatarUrl);
      console.info('[AvatarHelper] downloadAndSaveAvatar: account =', account);
      
      if (!this.context) {
        console.error('[AvatarHelper] downloadAndSaveAvatar: context is null');
        return null;
      }
      
      // 下载图片
      const downloadHeaders: Record<string, string> = { 'Accept': 'image/*' };
      const downloadOptions: ApiRequestOptions = { header: downloadHeaders };
      const response = await ApiClient.get(avatarUrl, undefined, downloadOptions);
      
      console.info('[AvatarHelper] downloadAndSaveAvatar: responseCode =', response.responseCode);
      console.info('[AvatarHelper] downloadAndSaveAvatar: result type =', typeof response.result);
      
      if (response.responseCode === 200 && response.result) {
        const imageData = response.result as ArrayBuffer;
        console.info('[AvatarHelper] downloadAndSaveAvatar: imageData size =', imageData.byteLength);
        
        // 将ArrayBuffer转换为PixelMap
        const imageSource = image.createImageSource(imageData);
        const pixelMap = await imageSource.createPixelMap();
        imageSource.release();
        
        console.info('[AvatarHelper] downloadAndSaveAvatar: PixelMap创建成功');
        
        // 保存到本地
        const fileName = `avatar_${account}.jpg`;
        console.info('[AvatarHelper] downloadAndSaveAvatar: 保存到本地, fileName =', fileName);
        
        const localPath = await this.saveToPersistent(pixelMap, fileName);
        
        console.info('[AvatarHelper] downloadAndSaveAvatar: 保存成功, localPath =', localPath);
        return localPath;
      }
      
      console.error('[AvatarHelper] downloadAndSaveAvatar: 下载失败, code =', response.responseCode);
      return null;
    } catch (error) {
      const err = error as BusinessError;
      console.error('[AvatarHelper] downloadAndSaveAvatar: 异常 =', err.code, err.message);
      return null;
    }
  }

  /**
   * 保存图片到本地缓存（已废弃，请使用saveToPersistent）
   * @deprecated 使用 saveToPersistent 代替
   */
  async saveToCache(pixelMap: image.PixelMap, fileName: string): Promise<string | null> {
    return await this.saveToPersistent(pixelMap, fileName);
  }
}
