# Windows 便携版自动发布配置完成

本文档说明为 Project Cat Calculator 添加的 Windows 便携版自动发布功能。

## ✅ 已完成的配置

### 1. GitHub Actions 工作流

**文件**: `.github/workflows/windows-release.yml`

**功能**:
- ✅ 自动构建 Windows Release 版本
- ✅ 创建便携 ZIP 包
- ✅ 自动发布到 GitHub Releases
- ✅ 支持标签触发和手动触发
- ✅ Windows 10 1803+ 兼容性

**触发方式**:
1. **自动触发**: 推送版本标签（如 `v1.0.0`）
2. **手动触发**: 在 GitHub Actions 页面手动运行

### 2. 项目文档

#### 主文档更新
- ✅ `README.md` - 添加了 Windows 便携版发布说明和徽章
- ✅ `CHANGELOG.md` - 版本变更日志模板

#### GitHub 配置文档
- ✅ `.github/README.md` - GitHub 配置总览
- ✅ `.github/RELEASE.md` - 完整的发布指南
- ✅ `.github/PORTABLE_GUIDE.md` - Windows 便携版使用指南
- ✅ `.github/WINDOWS_CUSTOMIZATION.md` - Windows 自定义配置指南
- ✅ `.github/QUICK_REFERENCE.md` - 快速参考手册

### 3. 项目结构

```
project_cat/
├── .github/
│   ├── workflows/
│   │   └── windows-release.yml          # CI/CD 工作流
│   ├── README.md                         # GitHub 配置说明
│   ├── RELEASE.md                        # 发布指南
│   ├── PORTABLE_GUIDE.md                 # 便携版使用指南
│   ├── WINDOWS_CUSTOMIZATION.md          # Windows 自定义指南
│   └── QUICK_REFERENCE.md                # 快速参考
├── windows/                              # Windows 平台代码
│   ├── CMakeLists.txt                   # Windows 构建配置
│   └── runner/
│       └── resources/
│           └── app_icon.ico             # 应用图标
├── README.md                             # 主文档（已更新）
├── CHANGELOG.md                          # 变更日志
├── pubspec.yaml                          # 项目配置
└── WINDOWS_RELEASE_SETUP.md             # 本文件
```

## 🚀 如何使用

### 首次发布

```bash
# 1. 确保所有更改已提交
git add .
git commit -m "Prepare for first release"

# 2. 创建版本标签
git tag -a v1.0.0 -m "Release version 1.0.0"

# 3. 推送代码和标签
git push origin feat-windows-portable-release-win10-1803
git push origin v1.0.0

# 4. 查看 GitHub Actions 构建进度
# 访问: https://github.com/YOUR_USERNAME/YOUR_REPO/actions
```

### 后续发布

```bash
# 1. 更新版本号 (pubspec.yaml)
version: 1.0.1+2

# 2. 更新 CHANGELOG.md

# 3. 提交并创建标签
git add .
git commit -m "Release v1.0.1"
git tag -a v1.0.1 -m "Release version 1.0.1"
git push origin feat-windows-portable-release-win10-1803
git push origin v1.0.1
```

### 手动触发构建

1. 访问 GitHub 仓库的 **Actions** 页面
2. 选择 **"Windows Portable Release"** 工作流
3. 点击 **"Run workflow"** 按钮
4. 输入版本号（例如: `v1.0.0`）
5. 点击绿色的 **"Run workflow"** 按钮

## 📦 发布产物

每次成功构建后，会生成以下文件：

### GitHub Release 资产
- `project_cat_windows_portable_v1.0.0.zip` - Windows 便携版压缩包

### ZIP 包内容
```
project_cat_portable/
├── project_cat.exe              # 主程序
├── flutter_windows.dll          # Flutter 运行时
├── data/                        # 数据文件
│   ├── icudtl.dat
│   └── flutter_assets/
├── README.txt                   # 使用说明
└── [其他依赖文件]
```

## 🎯 系统要求

Windows 便携版支持：
- **最低系统**: Windows 10 1803 (April 2018 Update)
- **推荐系统**: Windows 10 21H2 或 Windows 11
- **架构**: 64-bit (x64)
- **特点**: 无需安装，直接运行

## 🔧 工作流配置详情

### 构建步骤

1. **检出代码**: 从 Git 仓库获取最新代码
2. **设置 Flutter**: 安装 Flutter SDK 3.24.3
3. **启用 Windows 桌面**: 配置 Flutter Windows 支持
4. **安装依赖**: 运行 `flutter pub get`
5. **构建 Windows 版本**: 编译 Release 版本
6. **创建便携包**: 
   - 复制所有必要文件到便携目录
   - 生成 README.txt 说明文件
   - 使用 7-Zip 创建 ZIP 压缩包
7. **上传构建产物**: 保存到 GitHub Artifacts（保留 7 天）
8. **创建 GitHub Release**: 
   - 创建 Release 标签
   - 生成 Release 说明
   - 上传 ZIP 文件

### 自动化特性

- ✅ **自动版本检测**: 从 Git 标签自动提取版本号
- ✅ **自动 Release 创建**: 自动创建 GitHub Release
- ✅ **详细的 Release 说明**: 自动生成格式化的发布说明
- ✅ **构建缓存**: 使用 Flutter 缓存加速构建
- ✅ **产物保留**: 构建产物保留 7 天供下载

## 📊 工作流触发条件

### 1. 推送标签触发（推荐）

```yaml
on:
  push:
    tags:
      - 'v*'
```

当推送以 `v` 开头的标签时自动触发。

### 2. 手动触发

```yaml
on:
  workflow_dispatch:
    inputs:
      version:
        description: 'Release version (e.g., v1.0.0)'
        required: true
        default: 'v1.0.0'
```

允许在 GitHub UI 中手动触发，需要输入版本号。

## 🔍 监控和调试

### 查看构建状态

1. **GitHub Actions 页面**: 
   - 访问 `https://github.com/YOUR_USERNAME/YOUR_REPO/actions`
   - 查看工作流运行状态

2. **构建徽章**:
   - 已在 README.md 中添加构建状态徽章
   - 实时显示最新构建状态

### 查看构建日志

1. 访问 Actions 页面
2. 点击具体的工作流运行
3. 点击 "build-windows" 作业
4. 展开各个步骤查看详细日志

### 下载构建产物

即使 Release 创建失败，构建产物也会保存 7 天：

1. 访问 Actions 页面
2. 点击具体的工作流运行
3. 在 "Artifacts" 部分下载 `windows-portable`

## 🛠️ 自定义配置

### 修改 Flutter 版本

编辑 `.github/workflows/windows-release.yml`:

```yaml
- name: Setup Flutter
  uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.24.3'  # 修改这里
    channel: 'stable'
```

### 修改构建命令

```yaml
- name: Build Windows Release
  run: flutter build windows --release --split-debug-info=./debug-info
```

### 自定义 Release 说明

编辑工作流文件中的 `Create Release` 步骤的 `body` 部分。

## 📝 版本号规范

遵循 [语义化版本](https://semver.org/lang/zh-CN/) 规范：

```
vMAJOR.MINOR.PATCH

示例:
- v1.0.0 - 首次正式发布
- v1.1.0 - 添加新功能
- v1.1.1 - 修复 bug
- v2.0.0 - 重大更新（不兼容）
```

## ✨ 最佳实践

1. **版本控制**:
   - 每次发布前更新 `pubspec.yaml` 中的版本号
   - 更新 `CHANGELOG.md` 记录变更

2. **测试**:
   - 本地测试构建: `flutter build windows --release`
   - 验证程序正常运行

3. **文档**:
   - 保持文档与实际功能同步
   - 更新 CHANGELOG.md

4. **Git 标签**:
   - 使用带注释的标签: `git tag -a v1.0.0 -m "Release version 1.0.0"`
   - 标签信息清晰描述版本内容

5. **发布验证**:
   - 检查 GitHub Release 是否正确创建
   - 下载并测试 ZIP 文件
   - 验证 README.txt 内容正确

## 🔐 安全性考虑

### GitHub Token

工作流使用内置的 `GITHUB_TOKEN`，具有自动管理的权限：
- ✅ 读取仓库内容
- ✅ 创建 Releases
- ✅ 上传 Release 资产

无需额外配置 Secrets。

### 代码签名

目前构建的程序未签名。要添加代码签名：

1. 获取代码签名证书
2. 将证书添加到 GitHub Secrets
3. 在工作流中添加签名步骤

详见 `.github/WINDOWS_CUSTOMIZATION.md`。

## 🎉 成功！

Windows 便携版自动发布配置已完成！

### 下一步

1. **合并分支**: 
   ```bash
   git checkout main
   git merge feat-windows-portable-release-win10-1803
   ```

2. **推送到 GitHub**:
   ```bash
   git push origin main
   ```

3. **创建首个发布**:
   ```bash
   git tag -a v1.0.0 -m "First release"
   git push origin v1.0.0
   ```

4. **验证发布**:
   - 访问 Actions 页面查看构建
   - 访问 Releases 页面查看发布
   - 下载并测试 ZIP 文件

## 📚 更多信息

- 发布指南: `.github/RELEASE.md`
- 便携版使用: `.github/PORTABLE_GUIDE.md`
- Windows 自定义: `.github/WINDOWS_CUSTOMIZATION.md`
- 快速参考: `.github/QUICK_REFERENCE.md`

## 🆘 需要帮助？

如有问题：
1. 查看 `.github/` 目录中的文档
2. 查看 GitHub Actions 日志
3. 提交 Issue

---

**配置完成日期**: 2024
**配置状态**: ✅ 就绪
**支持系统**: Windows 10 1803+, Windows 11
**Flutter 版本**: 3.24.3
