# Windows 便携版发布功能说明

## 🎉 功能已完成

为 Project Cat Calculator 项目添加了完整的 Windows 便携版自动发布功能。

## ✨ 主要特性

### 1. 自动化构建发布
- ✅ GitHub Actions 自动构建工作流
- ✅ 支持 Windows 10 1803 及更高版本
- ✅ 生成便携 ZIP 包，无需安装
- ✅ 自动发布到 GitHub Releases

### 2. 两种发布方式

#### 方式一：推送标签触发（推荐）
```bash
# 创建版本标签
git tag -a v1.0.0 -m "Release version 1.0.0"

# 推送标签
git push origin v1.0.0

# GitHub Actions 自动开始构建和发布
```

#### 方式二：手动触发
1. 访问 GitHub 仓库的 Actions 页面
2. 选择 "Windows Portable Release" 工作流
3. 点击 "Run workflow"
4. 输入版本号（如 v1.0.0）
5. 点击运行

## 📦 发布产物

每次构建生成：
- **文件名**: `project_cat_windows_portable_v1.0.0.zip`
- **内容**: 完整的便携版应用程序
- **大小**: 约 30-50MB
- **位置**: GitHub Releases

### ZIP 包内容
```
project_cat_portable/
├── project_cat.exe          # 主程序
├── flutter_windows.dll      # Flutter 运行时
├── data/                    # 数据文件
├── README.txt               # 使用说明
└── [其他依赖文件]
```

## 🖥️ 系统要求

- **操作系统**: Windows 10 1803 或更高版本
- **架构**: 64-bit (x64)
- **特点**: 
  - 无需安装
  - 无需管理员权限
  - 可从任何位置运行
  - 可放在 U 盘携带使用

## 📁 新增文件

### GitHub Actions 配置
- `.github/workflows/windows-release.yml` - 自动发布工作流

### 文档
- `CHANGELOG.md` - 版本变更日志
- `WINDOWS_RELEASE_SETUP.md` - 完整的配置说明
- `Windows发布说明.md` - 本文件（中文简要说明）

### 指南文档（.github/ 目录）
- `README.md` - GitHub 配置总览
- `RELEASE.md` - 发布指南
- `PORTABLE_GUIDE.md` - Windows 便携版使用指南
- `WINDOWS_CUSTOMIZATION.md` - Windows 自定义配置指南
- `QUICK_REFERENCE.md` - 快速参考手册

### 更新的文件
- `README.md` - 添加了 Windows 便携版发布说明和徽章

## 🚀 快速开始

### 首次发布流程

```bash
# 1. 确认所有更改已提交
git status

# 2. 创建版本标签
git tag -a v1.0.0 -m "Release version 1.0.0"

# 3. 推送代码和标签
git push origin feat-windows-portable-release-win10-1803
git push origin v1.0.0

# 4. 等待 5-10 分钟，GitHub Actions 自动完成构建
# 5. 访问 https://github.com/YOUR_REPO/releases 查看发布
```

### 本地测试构建

```bash
# 编译 Release 版本
flutter build windows --release

# 构建产物位于
# build/windows/x64/runner/Release/

# 测试运行
cd build/windows/x64/runner/Release
./project_cat.exe
```

## 🔄 工作流程

```
推送标签 (v1.0.0)
    ↓
GitHub Actions 触发
    ↓
安装 Flutter SDK
    ↓
编译 Windows Release
    ↓
创建便携 ZIP 包
    ↓
创建 GitHub Release
    ↓
上传 ZIP 文件
    ↓
发布完成！
```

## 📊 监控构建

### 查看构建状态
1. 访问: `https://github.com/YOUR_REPO/actions`
2. 查看 "Windows Portable Release" 工作流
3. 点击具体运行查看详细日志

### README 徽章
在 README.md 顶部已添加构建状态徽章，实时显示构建状态。

## 🎯 版本号规范

采用语义化版本：`vMAJOR.MINOR.PATCH`

```
v1.0.0 - 首次正式发布
v1.1.0 - 添加新功能
v1.1.1 - 修复 bug
v2.0.0 - 重大更新
```

## 📝 发布前检查

在创建新版本前，请确保：

- [ ] 更新 `pubspec.yaml` 中的版本号
- [ ] 更新 `CHANGELOG.md` 文件
- [ ] 本地测试编译通过
- [ ] 所有更改已提交

## 💡 使用提示

### 给最终用户的说明

用户下载后：
1. 解压 ZIP 文件
2. 双击 `project_cat.exe` 运行
3. 首次可能需要点击"仍要运行"（SmartScreen 警告）
4. 无需安装，可直接使用

### 便携版特点

- ✅ 绿色软件，无需安装
- ✅ 可在 U 盘上运行
- ✅ 不修改系统注册表
- ✅ 删除文件夹即可完全卸载
- ✅ 可同时运行多个版本

## 🔧 自定义配置

如需修改：
- **Flutter 版本**: 编辑 `.github/workflows/windows-release.yml`
- **应用图标**: 替换 `windows/runner/resources/app_icon.ico`
- **应用名称**: 修改 `windows/CMakeLists.txt` 中的 `BINARY_NAME`
- **Release 说明**: 编辑工作流文件中的 Release body 部分

详细说明请参考 `.github/WINDOWS_CUSTOMIZATION.md`

## 📚 完整文档

详细的配置和使用说明：

1. **WINDOWS_RELEASE_SETUP.md** - 完整的配置说明（英文）
2. **.github/RELEASE.md** - 发布流程指南
3. **.github/PORTABLE_GUIDE.md** - 便携版使用指南
4. **.github/QUICK_REFERENCE.md** - 快速参考手册

## ⚠️ 注意事项

### 首次使用

1. 确保已将代码推送到 GitHub
2. 确保 GitHub Actions 已启用
3. 标签必须以 `v` 开头（如 v1.0.0）

### 常见问题

**Q: 推送标签后没有触发构建？**
A: 确认标签格式正确（v开头），检查 GitHub Actions 是否启用

**Q: 构建失败？**
A: 查看 Actions 日志，常见原因是依赖问题或代码错误

**Q: Release 创建失败？**
A: 检查是否有同名 Release 已存在，或标签名称是否正确

**Q: ZIP 文件无法运行？**
A: 确认在 Windows 10 1803+ 系统上运行，检查所有文件完整

## 🎊 完成状态

- ✅ GitHub Actions 工作流配置完成
- ✅ 文档编写完成
- ✅ README 更新完成
- ✅ 测试说明完成
- ✅ 就绪发布！

## 🆘 获取帮助

如有问题：
1. 查看 `WINDOWS_RELEASE_SETUP.md` 详细说明
2. 查看 `.github/` 目录下的各类指南
3. 查看 GitHub Actions 构建日志
4. 在项目中提交 Issue

---

**配置完成**: 2024年
**状态**: ✅ 就绪
**支持平台**: Windows 10 1803+, Windows 11 (x64)

祝使用愉快！ 🎉
