# 智享泥安 (CampusPlatformAHU)

## 项目简介

智享泥安是一款基于 HarmonyOS 开发的校园综合服务平台。应用集成了食堂查询、新闻资讯、课程表、用户反馈等功能模块，致力于提升校园生活体验。

项目包含 **前端（HarmonyOS Next）** 和 **后端（Node.js + Express）** 两部分，后端位于 `server/` 目录下，提供 RESTful API 支持。

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
  - 窗口评论与点赞/踩（后端支持）

- **资讯中心**
  - 校园新闻动态
  - 通知公告查看

- **学习助手**
  - 课程表管理
  - 课程信息展示

- **互动反馈**
  - 意见反馈提交
  - 反馈历史查看

### 后端 API

- **用户认证** — 登录、邮箱注册、验证码发送、JWT Token 鉴权
- **食堂评论** — 评论增删、图片上传、点赞/踩投票
- **头像管理** — 头像上传与获取
- **用户反馈** — 意见提交与历史查询
- **管理后台** — 用户管理、登录日志、数据统计（`/admin`）
- **隐私文档** — 隐私政策与用户协议确认流程

## 技术栈

### 前端（HarmonyOS）
- **开发框架**: HarmonyOS Next
- **开发语言**: ArkTS
- **UI框架**: ArkUI
- **目标SDK版本**: 6.0.2(22)
- **支持设备**: Phone、Tablet、2in1

### 后端（Node.js）
- **运行环境**: Node.js
- **Web框架**: Express 4.x
- **数据库**: SQLite（better-sqlite3）
- **认证方式**: JWT（jsonwebtoken）+ bcryptjs 密码加密
- **邮件服务**: nodemailer
- **安全中间件**: helmet、cors

## 项目结构

```
CampusPlatformAHU/
├── AppScope/                 # 应用全局配置
│   └── app.json5            # 应用配置文件
├── entry/                   # HarmonyOS 主模块
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
├── server/                  # Node.js 后端
│   ├── server.js            # 服务入口
│   ├── db.js                # 数据库初始化（SQLite）
│   ├── mailer.js            # 邮件发送配置
│   ├── middleware/          # 中间件
│   │   └── auth.js          # JWT 认证中间件
│   ├── routes/              # 路由模块
│   │   ├── auth.js          # 用户认证接口
│   │   ├── canteen.js       # 食堂评论接口
│   │   └── admin.js         # 管理后台接口
│   ├── public/              # 静态资源
│   │   ├── admin.html       # 管理员控制面板
│   │   ├── login.html       # 管理员登录
│   │   ├── api-docs.html    # API 文档页面
│   │   └── avatars/         # 用户头像存储
│   ├── doucuments/          # 文档
│   │   ├── privacy_policy   # 隐私政策
│   │   └── user_agreement   # 用户协议
│   └── package.json         # 依赖配置
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

- **前端**: DevEco Studio（建议最新版）、HarmonyOS SDK API 6.0.2(22) 及以上
- **后端**: Node.js v18+、npm

### 安装步骤

#### 前端（HarmonyOS）
1. 克隆项目到本地
```bash
git clone https://gitee.com/your-username/CampusPlatformAHU.git
```

2. 使用 DevEco Studio 打开项目

3. 等待项目同步和依赖安装完成

4. 连接设备或启动模拟器

5. 点击运行按钮启动应用

#### 后端（Node.js）
1. 进入后端目录并安装依赖
```bash
cd server
npm install
```

2. 配置环境变量（可选），在 `server/` 下创建 `.env` 文件：
```env
PORT=3000
JWT_SECRET=your_jwt_secret
SMTP_HOST=smtp.example.com
SMTP_PORT=587
SMTP_USER=your_email@example.com
SMTP_PASS=your_password
```

3. 启动服务
```bash
# 开发模式（文件变动自动重启）
npm run dev

# 生产模式
npm start
```

4. 服务默认运行在 `http://localhost:3000`

> 说明：后端使用 SQLite 数据库，首次启动会自动创建 `server/data/harmony.db` 并初始化表结构，无需额外配置数据库服务。

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
