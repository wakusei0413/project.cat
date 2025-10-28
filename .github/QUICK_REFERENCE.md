# 快速参考手册

项目常用命令和配置的快速参考。

## 🚀 发布流程

### 快速发布新版本

```bash
# 1. 更新版本号
# 编辑 pubspec.yaml: version: 1.0.1+2

# 2. 更新变更日志
# 编辑 CHANGELOG.md

# 3. 提交更改
git add .
git commit -m "Release v1.0.1"

# 4. 创建并推送标签
git tag -a v1.0.1 -m "Release version 1.0.1"
git push origin v1.0.1

# 5. 等待 GitHub Actions 自动构建
# 访问：https://github.com/YOUR_REPO/actions
```

### 手动触发构建

1. GitHub → Actions → "Windows Portable Release"
2. 点击 "Run workflow"
3. 输入版本号（如 v1.0.1）
4. 点击绿色 "Run workflow" 按钮

## 🛠️ 开发命令

### Flutter 基础命令

```bash
# 获取依赖
flutter pub get

# 运行应用（调试模式）
flutter run -d windows

# 热重载（应用运行时）
# 按 'r' 键

# 热重启（应用运行时）
# 按 'R' 键

# 退出运行
# 按 'q' 键
```

### 代码质量

```bash
# 代码分析
flutter analyze

# 修复可自动修复的问题
dart fix --apply

# 代码格式化
dart format .

# 格式化并覆盖文件
dart format . --set-exit-if-changed

# 运行测试
flutter test

# 运行特定测试文件
flutter test test/widget_test.dart

# 测试覆盖率
flutter test --coverage
```

### 依赖管理

```bash
# 更新依赖
flutter pub upgrade

# 更新到最新的主版本
flutter pub upgrade --major-versions

# 清理并重新获取
flutter clean
flutter pub get

# 查看过时的依赖
flutter pub outdated

# 添加新依赖
flutter pub add package_name

# 移除依赖
flutter pub remove package_name
```

## 🪟 Windows 构建

### 开发构建

```bash
# 启用 Windows 桌面支持（首次）
flutter config --enable-windows-desktop

# 调试构建并运行
flutter run -d windows

# 构建调试版本
flutter build windows --debug

# 构建分析版本（性能分析）
flutter build windows --profile
```

### 发布构建

```bash
# 构建 Release 版本
flutter build windows --release

# 构建位置
# build/windows/x64/runner/Release/

# 带优化的构建
flutter build windows --release --split-debug-info=./debug-info --obfuscate

# 查看构建大小
flutter build windows --release --analyze-size
```

### 清理构建

```bash
# 清理构建产物
flutter clean

# 深度清理（包括 pub cache）
flutter clean
flutter pub cache repair
```

## 📦 打包命令

### 手动创建便携包

```bash
# Windows (PowerShell)
cd build/windows/x64/runner/Release
Compress-Archive -Path * -DestinationPath project_cat_portable.zip

# Linux/Mac (需要在 WSL 或构建机器上)
cd build/windows/x64/runner/Release
zip -r project_cat_portable.zip *

# 使用 7-Zip (Windows)
cd build/windows/x64/runner/Release
7z a -tzip project_cat_portable.zip *
```

## 🔧 项目配置

### 版本号管理

**文件位置**：`pubspec.yaml`

```yaml
version: 1.0.0+1
# 格式：MAJOR.MINOR.PATCH+BUILD_NUMBER
# 1.0.0 = 版本号（语义化版本）
# +1 = 构建号（递增）
```

**版本号规则**：
- **MAJOR**：不兼容的 API 修改
- **MINOR**：向下兼容的功能性新增
- **PATCH**：向下兼容的问题修正
- **BUILD_NUMBER**：每次构建递增

### 应用信息配置

**文件位置**：`windows/CMakeLists.txt`

```cmake
# 可执行文件名称
set(BINARY_NAME "project_cat")
```

## 🎨 资源管理

### 添加图片资源

1. 将图片放入 `assets/images/` 目录
2. 在 `pubspec.yaml` 中声明：

```yaml
flutter:
  assets:
    - assets/images/
    - assets/images/icon.png
```

3. 在代码中使用：

```dart
Image.asset('assets/images/icon.png')
```

### 更新 Windows 图标

```bash
# 替换图标文件
cp new_icon.ico windows/runner/resources/app_icon.ico

# 重新构建
flutter clean
flutter build windows --release
```

## 🔍 调试技巧

### 查看日志

```bash
# 运行时显示详细日志
flutter run -d windows -v

# 查看 Flutter 版本和配置
flutter doctor -v

# 查看设备信息
flutter devices -v
```

### 性能分析

```bash
# 构建性能分析版本
flutter build windows --profile

# 运行性能分析版本
flutter run -d windows --profile

# 在 DevTools 中分析
# 应用运行后，在终端中点击 DevTools 链接
```

### 常见问题排查

```bash
# 清理并重新构建
flutter clean
flutter pub get
flutter build windows --release

# 检查 Flutter 环境
flutter doctor

# 修复 Flutter 配置
flutter doctor --android-licenses
flutter config --enable-windows-desktop

# 重新下载 Flutter SDK 缓存
flutter precache --windows
```

## 📊 Git 命令

### 标签管理

```bash
# 列出所有标签
git tag

# 列出特定模式的标签
git tag -l "v1.0.*"

# 创建标签
git tag -a v1.0.0 -m "Release version 1.0.0"

# 推送标签
git push origin v1.0.0

# 推送所有标签
git push origin --tags

# 删除本地标签
git tag -d v1.0.0

# 删除远程标签
git push origin :refs/tags/v1.0.0
# 或
git push origin --delete v1.0.0

# 查看标签信息
git show v1.0.0

# 检出特定标签
git checkout v1.0.0
```

### 分支管理

```bash
# 查看所有分支
git branch -a

# 创建新分支
git checkout -b feature/new-feature

# 切换分支
git checkout main

# 合并分支
git merge feature/new-feature

# 删除本地分支
git branch -d feature/new-feature

# 强制删除
git branch -D feature/new-feature

# 删除远程分支
git push origin --delete feature/new-feature
```

## 🌐 GitHub Actions

### 查看工作流状态

```bash
# 使用 GitHub CLI
gh run list --workflow=windows-release.yml

# 查看最新运行
gh run view

# 查看日志
gh run view --log
```

### 手动触发工作流（CLI）

```bash
# 使用 GitHub CLI
gh workflow run windows-release.yml -f version=v1.0.0
```

## 📝 文件位置速查

```
project_cat/
├── .github/
│   ├── workflows/
│   │   └── windows-release.yml      # CI/CD 配置
│   ├── RELEASE.md                    # 发布指南
│   ├── PORTABLE_GUIDE.md             # 便携版指南
│   ├── WINDOWS_CUSTOMIZATION.md      # Windows 自定义
│   └── QUICK_REFERENCE.md            # 本文件
├── lib/                              # Dart 源代码
├── windows/                          # Windows 平台代码
│   ├── CMakeLists.txt               # 构建配置
│   └── runner/
│       ├── resources/
│       │   └── app_icon.ico         # 应用图标
│       └── Runner.rc                # Windows 资源
├── pubspec.yaml                      # 项目配置
├── CHANGELOG.md                      # 变更日志
└── README.md                         # 项目文档
```

## 🔗 有用的链接

### 官方文档
- [Flutter 文档](https://docs.flutter.dev/)
- [Dart 文档](https://dart.dev/guides)
- [Flutter Desktop](https://docs.flutter.dev/desktop)

### 社区资源
- [Flutter GitHub](https://github.com/flutter/flutter)
- [Pub.dev](https://pub.dev/)
- [Flutter 中文网](https://flutter.cn/)

### 工具
- [GitHub Actions](https://github.com/features/actions)
- [Flutter DevTools](https://docs.flutter.dev/tools/devtools)
- [Visual Studio Code](https://code.visualstudio.com/)

## ⚡ 快捷键

### VS Code Flutter 扩展

- `Ctrl+Shift+P` → "Flutter: Run Flutter Doctor"
- `Ctrl+Shift+P` → "Flutter: Clean Project"
- `F5` → 开始调试
- `Shift+F5` → 停止调试
- `Ctrl+F5` → 运行（不调试）

### 开发工具

- `Ctrl+/` → 注释/取消注释
- `Shift+Alt+F` → 格式化文档
- `Ctrl+.` → 快速修复
- `F2` → 重命名符号

## 📞 获取帮助

1. **查看文档**：
   - README.md
   - .github/RELEASE.md
   - .github/PORTABLE_GUIDE.md

2. **搜索问题**：
   - GitHub Issues
   - Stack Overflow
   - Flutter 文档

3. **提交 Issue**：
   - 描述问题
   - 提供复现步骤
   - 附上日志和截图

---

**提示**：将此文件添加到书签，作为快速参考！
