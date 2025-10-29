# Release Guide

本文档说明如何发布 Project Cat Calculator 的新版本。

## 自动发布流程

本项目使用 GitHub Actions 自动化构建和发布流程。

### 方式 1：通过 Git Tag 触发（推荐）

这是最简单和推荐的发布方式：

```bash
# 1. 确保所有更改已提交
git add .
git commit -m "Prepare for release v1.0.0"

# 2. 创建并推送版本标签
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0

# 3. GitHub Actions 将自动开始构建
# 访问 https://github.com/YOUR_USERNAME/YOUR_REPO/actions 查看进度
```

### 方式 2：手动触发工作流

如果你想在不预先创建标签的情况下构建和发布：

1. 访问 GitHub 仓库的 Actions 页面
2. 在左侧选择 "Windows Portable Release" 工作流
3. 点击右上角的 "Run workflow" 按钮
4. 输入版本号（例如：v1.0.0）
5. 选择分支（通常是 main 或 master）
6. 点击 "Run workflow" 开始构建

**注意**：手动触发工作流也会创建 GitHub Release 和相应的标签。

## 发布流程详情

GitHub Actions 工作流会自动执行以下步骤：

1. **检出代码**：从仓库获取最新代码
2. **设置 Flutter**：安装 Flutter SDK 3.35.7
3. **启用 Windows 桌面支持**：配置 Flutter Windows 支持
4. **安装依赖**：运行 `flutter pub get`
5. **构建 Windows 版本**：编译 Release 版本
6. **创建便携包**：
   - 将所有必要文件复制到便携目录
   - 生成 README.txt 说明文件
   - 使用 7-Zip 创建 ZIP 压缩包
7. **上传构建产物**：保存到 GitHub Artifacts（保留 7 天）
8. **创建 GitHub Release**：
   - 创建新的 Release（如果标签不存在则自动创建）
   - 生成 Release 说明
   - 上传 ZIP 文件到 Release

## 版本号规范

本项目遵循 [语义化版本](https://semver.org/lang/zh-CN/) 规范：

- **主版本号（Major）**：不兼容的 API 修改
- **次版本号（Minor）**：向下兼容的功能性新增
- **修订号（Patch）**：向下兼容的问题修正

格式：`vMAJOR.MINOR.PATCH`

示例：
- `v1.0.0` - 首次正式发布
- `v1.1.0` - 添加新功能
- `v1.1.1` - 修复 bug

## 发布前检查清单

在创建新版本之前，请确保：

- [ ] 所有测试通过（`flutter test`）
- [ ] 代码已格式化（`dart format .`）
- [ ] 代码分析无错误（`flutter analyze`）
- [ ] 更新了 `CHANGELOG.md` 文件
- [ ] 更新了 `pubspec.yaml` 中的版本号
- [ ] 所有更改已提交到 Git
- [ ] 文档已更新（如有必要）

## 发布后操作

发布成功后：

1. **验证 Release**：
   - 访问 GitHub Releases 页面
   - 检查 Release 说明是否正确
   - 下载并测试 ZIP 文件

2. **公告**：
   - 在项目 README 中更新最新版本信息
   - 发布更新公告（如适用）

3. **监控**：
   - 关注 GitHub Issues 中的问题报告
   - 准备快速发布补丁版本（如有必要）

## 回滚发布

如果发布出现问题：

1. 删除有问题的 Release：
   - 访问 GitHub Releases 页面
   - 找到相应的 Release
   - 点击 "Delete" 删除

2. 删除对应的标签：
   ```bash
   # 删除本地标签
   git tag -d v1.0.0
   
   # 删除远程标签
   git push origin :refs/tags/v1.0.0
   ```

3. 修复问题后重新发布

## Windows 10 1803 兼容性

构建的 Windows 版本支持 Windows 10 1803（2018 年 4 月更新）及更高版本。这是通过以下方式确保的：

- 使用稳定版本的 Flutter SDK
- 不使用需要更高 Windows 版本的特性
- 在 Release 说明中明确标注系统要求

## 故障排除

### 构建失败

如果 GitHub Actions 构建失败：

1. 查看 Actions 日志找出错误原因
2. 常见问题：
   - Flutter 依赖冲突：运行 `flutter pub upgrade`
   - 代码错误：确保本地测试通过
   - 网络问题：重新运行工作流

### Release 创建失败

如果 Release 创建失败：

1. 检查是否有足够的权限
2. 确认 `GITHUB_TOKEN` 正确配置
3. 验证标签名称格式正确

## 支持

如有问题，请：

1. 查看 GitHub Actions 日志
2. 阅读本文档
3. 提交 Issue 寻求帮助
