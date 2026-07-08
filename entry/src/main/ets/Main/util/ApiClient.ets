import http from '@ohos.net.http';

/**
 * API请求选项
 */
export interface ApiRequestOptions {
  token?: string;
  connectTimeout?: number;
  readTimeout?: number;
  header?: Record<string, string>;
  expectDataType?: http.HttpDataType;
}

/**
 * API请求基础URL
 */
const BASE_URL = 'https://backend.hoshikaze.top';

/**
 * 统一API客户端
 * 所有后端API请求必须通过此类调用，调用处只需传入相对路径（如 'api/auth/login'）
 */
export class ApiClient {
  /**
   * 获取基础URL
   */
  static getBaseUrl(): string {
    return BASE_URL;
  }

  /**
   * 构建完整请求URL
   * @param path 路径，如 'api/auth/login'
   */
  static buildUrl(path: string): string {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }
    const normalized = path.startsWith('/') ? path : '/' + path;
    return BASE_URL + normalized;
  }

  /**
   * 构建头像资源URL（用于Image组件显示头像图片）
   * @param filename 头像文件名或路径
   */
  static getAvatarUrl(filename: string): string {
    if (!filename || filename.trim() === '') {
      return '';
    }
    if (filename.startsWith('http://') || filename.startsWith('https://')) {
      return filename;
    }
    const normalized = filename.startsWith('/') ? filename : '/' + filename;
    return BASE_URL + normalized;
  }

  /**
   * GET请求
   * @param path API路径，如 'api/notifications'
   * @param params 查询参数，拼接在URL后
   * @param options 请求选项
   */
  static async get(path: string, params?: Record<string, string>, options?: ApiRequestOptions): Promise<http.HttpResponse> {
    let url = ApiClient.buildUrl(path);
    if (params) {
      const queryString = Object.keys(params).map((key: string) => `${key}=${encodeURIComponent(params[key])}`).join('&');
      if (queryString.length > 0) {
        url += '?' + queryString;
      }
    }
    return ApiClient.requestWithUrl(url, http.RequestMethod.GET, undefined, options);
  }

  /**
   * POST请求
   * @param path API路径
   * @param extraData 请求体数据
   * @param options 请求选项
   */
  static async post(path: string, extraData?: Object | string | ArrayBuffer, options?: ApiRequestOptions): Promise<http.HttpResponse> {
    return ApiClient.request(path, http.RequestMethod.POST, extraData, options);
  }

  /**
   * PUT请求
   * @param path API路径
   * @param extraData 请求体数据
   * @param options 请求选项
   */
  static async put(path: string, extraData?: Object | string | ArrayBuffer, options?: ApiRequestOptions): Promise<http.HttpResponse> {
    return ApiClient.request(path, http.RequestMethod.PUT, extraData, options);
  }

  /**
   * DELETE请求
   * @param path API路径
   * @param options 请求选项
   */
  static async delete(path: string, options?: ApiRequestOptions): Promise<http.HttpResponse> {
    return ApiClient.request(path, http.RequestMethod.DELETE, undefined, options);
  }

  /**
   * 通用请求方法（使用完整URL）
   */
  private static async requestWithUrl(
    url: string,
    method: http.RequestMethod,
    extraData?: Object | string | ArrayBuffer,
    options?: ApiRequestOptions
  ): Promise<http.HttpResponse> {
    const httpRequest = http.createHttp();

    const headers: Record<string, string> = {};
    if (options?.header) {
      const keys = Object.keys(options.header);
      for (let i = 0; i < keys.length; i++) {
        headers[keys[i]] = options.header[keys[i]];
      }
    }
    // 当有请求体数据且未明确设置Content-Type时，默认使用application/json
    if (extraData !== undefined && !headers['Content-Type']) {
      headers['Content-Type'] = 'application/json';
    }
    if (options?.token) {
      headers['Authorization'] = `Bearer ${options.token}`;
    }

    const requestOptions: http.HttpRequestOptions = {
      method: method,
      header: headers,
      connectTimeout: options?.connectTimeout ?? 15000,
      readTimeout: options?.readTimeout ?? 15000,
      expectDataType: options?.expectDataType ?? http.HttpDataType.STRING,
    };

    if (extraData !== undefined) {
      requestOptions.extraData = extraData;
    }

    try {
      return await httpRequest.request(url, requestOptions);
    } finally {
      httpRequest.destroy();
    }
  }

  /**
   * 通用请求方法（自动构建URL）
   */
  private static async request(
    path: string,
    method: http.RequestMethod,
    extraData?: Object | string | ArrayBuffer,
    options?: ApiRequestOptions
  ): Promise<http.HttpResponse> {
    const url = ApiClient.buildUrl(path);
    return ApiClient.requestWithUrl(url, method, extraData, options);
  }
}
