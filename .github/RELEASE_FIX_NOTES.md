# Release Publishing Fix

## 问题描述 (Problem Description)

之前的 GitHub Actions 工作流虽然运行成功，但在某些情况下不会发布 Release。

Previously, the GitHub Actions workflow would run successfully but wouldn't publish releases in certain cases.

## 根本原因 (Root Cause)

工作流中的 "Create Release" 步骤有条件限制：
```yaml
if: github.event_name == 'push' && startsWith(github.ref, 'refs/tags/')
```

这意味着：
- ✅ 当通过推送标签触发时，会创建 Release
- ❌ 当手动触发工作流（workflow_dispatch）时，**不会**创建 Release

The "Create Release" step in the workflow had a conditional that restricted it to only run when triggered by pushing a tag, not when manually triggered via workflow_dispatch.

## 解决方案 (Solution)

已移除条件限制，现在两种触发方式都会创建 Release：

1. **标签推送触发** (Tag Push)
   - 推送格式为 `v*` 的标签时自动触发
   - 使用标签名称作为版本号

2. **手动触发** (Manual Trigger)
   - 通过 GitHub Actions UI 手动触发
   - 输入自定义版本号
   - 工作流会自动创建对应的标签和 Release

Removed the conditional restriction so that releases are now created for both trigger methods.

## 修改内容 (Changes Made)

### 1. `.github/workflows/windows-release.yml`
- 移除了 "Verify file exists before release" 步骤的条件限制
- 移除了 "Create Release" 步骤的条件限制  
- 合并了 "Update release notes" 和 "Workflow dispatch summary" 步骤

### 2. `.github/RELEASE.md`
- 更新文档说明手动触发也会创建 Release
- 澄清了发布流程的行为

## 使用方法 (Usage)

### 方法 1：推送标签（推荐）
```bash
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

### 方法 2：手动触发
1. 访问 GitHub Actions 页面
2. 选择 "Windows Portable Release" 工作流
3. 点击 "Run workflow"
4. 输入版本号（如：v1.0.0）
5. 选择分支并运行

两种方法都会：
- ✅ 构建 Windows 便携版
- ✅ 创建 GitHub Release
- ✅ 上传 ZIP 文件到 Release
- ✅ 创建标签（如果不存在）

Both methods will now:
- ✅ Build the Windows portable version
- ✅ Create a GitHub Release
- ✅ Upload the ZIP file to the release
- ✅ Create the tag (if it doesn't exist)

## 验证 (Verification)

工作流运行后，检查：
1. GitHub Actions 是否显示所有步骤成功
2. GitHub Releases 页面是否显示新的 Release
3. Release 是否包含 ZIP 文件附件
4. 标签是否已创建

After the workflow runs, verify:
1. GitHub Actions shows all steps succeeded
2. GitHub Releases page shows the new release
3. The release contains the ZIP file attachment
4. The tag has been created
