# 智享泥安 (CampusPlatformAHU)

## 项目简介

智享泥安是一款基于 HarmonyOS 开发的校园综合服务平台，为安徽大学师生提供便捷的校园生活服务。应用集成了食堂查询、新闻资讯、课程表、用户反馈等功能模块，致力于提升校园生活体验。

## 功能特性

### 核心功能

- **用户认证**
  - 用户登录/注册
  - 个人资料编辑
  - 隐私政策与用户协议

- **食堂服务**
  - 食堂列表展示
  - 楼层信息查询
  - 窗口详情查看
  - 实时菜品信息

- **资讯中心**
  - 校园新闻动态
  - 通知公告查看

- **学习助手**
  - 课程表管理
  - 课程信息展示

- **互动反馈**
  - 意见反馈提交
  - 反馈历史查看

## 技术栈

- **开发框架**: HarmonyOS Next
- **开发语言**: ArkTS
- **UI框架**: ArkUI
- **目标SDK版本**: 6.0.2(22)
- **支持设备**: Phone、Tablet、2in1

## 项目结构

```
CampusPlatformAHU/
├── AppScope/                 # 应用全局配置
│   └── app.json5            # 应用配置文件
├── entry/                   # 主模块
│   └── src/main/
│       ├── ets/             # ArkTS源码
│       │   ├── Main/        # 主要功能模块
│       │   │   ├── pages/   # 页面组件
│       │   │   ├── view/    # 自定义组件
│       │   │   ├── data/    # 数据处理
│       │   │   ├── util/    # 工具类
│       │   │   └── viewmodel/ # 视图模型
│       │   ├── entryability/ # 应用入口
│       │   └── entrybackupability/ # 备份能力
│       └── resources/       # 资源文件
│           ├── base/        # 基础资源
│           └── rawfile/     # 原始文件
├── build-profile.json5      # 构建配置
├── oh-package.json5         # 依赖管理
└── hvigor/                  # 构建工具
```

## 权限说明

应用需要以下权限：

- `ohos.permission.INTERNET` - 网络访问权限
- `ohos.permission.GET_NETWORK_INFO` - 获取网络信息权限
- `ohos.permission.CAMERA` - 相机权限（用于拍摄头像照片）

## 开发环境

### 环境要求

- DevEco Studio 版本：建议使用最新版本
- HarmonyOS SDK：API 6.0.2(22) 及以上
- Node.js：建议 v14.19.1 及以上

### 安装步骤

1. 克隆项目到本地
```bash
git clone https://gitee.com/your-username/CampusPlatformAHU.git
```

2. 使用 DevEco Studio 打开项目

3. 等待项目同步和依赖安装完成

4. 连接设备或启动模拟器

5. 点击运行按钮启动应用

## 构建说明

### Debug 构建
```bash
hvigorw assembleHap --mode module -p product=default
```

### Release 构建
```bash
hvigorw assembleHap --mode module -p product=default -p buildMode=release
```

## 版本信息

- **当前版本**: v1.0.0
- **版本代码**: 1000000
- **更新日期**: 2026-06-22

## 开发团队

- **开发单位**: example
- **应用标识**: com.example.campusplatformahu

## 许可证

本项目采用 MIT 许可证，详见 [LICENSE](LICENSE) 文件。

## 贡献指南

欢迎提交 Issue 和 Pull Request 参与项目开发。

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 提交 Pull Request

## 联系方式

如有问题或建议，欢迎通过以下方式联系：

- 提交 Issue
- 发送邮件至项目维护者

---

**注意**: 本项目仅供学习和研究使用，请勿用于商业用途。
