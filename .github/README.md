# GitHub Configuration

本目录包含项目的 GitHub 相关配置和文档。

## 📁 目录结构

```
.github/
├── workflows/              # GitHub Actions 工作流
│   └── windows-release.yml # Windows 便携版自动发布流程
├── RELEASE.md              # 发布指南
├── PORTABLE_GUIDE.md       # Windows 便携版使用指南
└── README.md               # 本文件
```

## 🔄 GitHub Actions 工作流

### Windows Portable Release

**文件**：`workflows/windows-release.yml`

**功能**：自动构建和发布 Windows 便携版本

**触发条件**：
1. 推送标签（如 `v1.0.0`）
2. 手动触发（通过 GitHub Actions UI）

**构建流程**：
1. 设置 Flutter 环境（3.35.7）
2. 安装项目依赖
3. 编译 Windows Release 版本
4. 创建便携包（ZIP 格式）
5. 创建 GitHub Release
6. 上传发布文件

**支持系统**：Windows 10 1803+, Windows 11

## 📚 文档

### RELEASE.md

发布新版本的完整指南，包括：
- 自动发布流程
- 版本号规范
- 发布前检查清单
- 故障排除

### PORTABLE_GUIDE.md

Windows 便携版使用指南，包括：
- 下载和安装说明
- 便携版特性说明
- 系统要求
- 故障排除
- 常见问题解答

## 🚀 快速开始

### 发布新版本

```bash
# 1. 更新版本号和变更日志
# 编辑 pubspec.yaml 和 CHANGELOG.md

# 2. 提交更改
git add .
git commit -m "Prepare for release v1.0.0"

# 3. 创建并推送标签
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0

# 4. GitHub Actions 将自动构建和发布
```

### 手动触发构建

1. 访问仓库的 Actions 页面
2. 选择 "Windows Portable Release"
3. 点击 "Run workflow"
4. 输入版本号并运行

## 🔐 所需权限

工作流使用默认的 `GITHUB_TOKEN`，具有以下权限：
- 读取仓库内容
- 创建 Releases
- 上传 Release 资产

无需额外配置。

## 🛠️ 维护

### 更新 Flutter 版本

如需更新 Flutter 版本，编辑 `workflows/windows-release.yml`：

```yaml
- name: Setup Flutter
  uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.35.7'  # 修改此处
    channel: 'stable'
```

### 修改构建配置

构建配置位于 `workflows/windows-release.yml` 中的 `Build Windows Release` 步骤。

### 自定义 Release 说明

编辑 `workflows/windows-release.yml` 中的 `Create Release` 步骤的 `body` 部分。

## 📊 构建状态

查看最新的构建状态：
- 访问仓库的 Actions 页面
- 查看 "Windows Portable Release" 工作流
- 点击最近的运行查看详细日志

## 🐛 故障排除

### 工作流失败

1. 查看 Actions 日志找出错误
2. 常见问题：
   - Flutter 版本不兼容
   - 依赖下载失败
   - 编译错误
   - 权限不足

### Release 创建失败

1. 确认标签格式正确（如 `v1.0.0`）
2. 检查是否有同名 Release 已存在
3. 验证 GITHUB_TOKEN 权限

## 📝 贡献

改进工作流或文档：
1. Fork 项目
2. 创建功能分支
3. 提交更改
4. 创建 Pull Request

## 📄 参考资料

- [GitHub Actions 文档](https://docs.github.com/en/actions)
- [Flutter Desktop 文档](https://docs.flutter.dev/desktop)
- [语义化版本规范](https://semver.org/lang/zh-CN/)
