# Windows 版本自定义指南

本文档说明如何自定义 Windows 便携版的各种配置。

## 🎨 应用程序图标

### 更换应用图标

Windows 应用程序的图标位于：

```
windows/runner/resources/app_icon.ico
```

要更换图标：

1. **准备图标文件**：
   - 格式：.ico
   - 推荐尺寸：包含多个尺寸（16x16, 32x32, 48x48, 256x256）
   - 工具：[IcoFX](https://icofx.ro/)、[GIMP](https://www.gimp.org/)、在线转换器

2. **替换文件**：
   ```bash
   # 将新图标复制到 Windows 资源目录
   cp your_icon.ico windows/runner/resources/app_icon.ico
   ```

3. **重新编译**：
   ```bash
   flutter build windows --release
   ```

### 从 PNG 创建 ICO

使用 ImageMagick：

```bash
# 安装 ImageMagick
# Windows: https://imagemagick.org/script/download.php

# 转换 PNG 到 ICO
magick convert icon.png -define icon:auto-resize=256,128,64,48,32,16 app_icon.ico
```

在线工具：
- [ConvertICO](https://convertico.com/)
- [ICO Convert](https://icoconvert.com/)

## 📝 应用程序信息

### 修改应用程序名称

编辑 `windows/CMakeLists.txt`：

```cmake
# 第 7 行
set(BINARY_NAME "project_cat")  # 修改为您的应用名称
```

### 修改版本信息

1. **应用版本**（`pubspec.yaml`）：
   ```yaml
   version: 1.0.0+1  # 修改版本号
   ```

2. **Windows 版本信息**（`windows/runner/Runner.rc`）：
   ```rc
   #define VERSION_AS_NUMBER 1,0,0,1
   #define VERSION_AS_STRING "1.0.0.1"
   ```

### 添加产品信息

编辑 `windows/runner/Runner.rc`：

```rc
STRINGTABLE
BEGIN
    IDS_APP_TITLE           "Project Cat Calculator"
    IDS_APP_COMPANY         "Your Company Name"
    IDS_APP_COPYRIGHT       "Copyright © 2024"
END
```

## 🪟 窗口配置

### 默认窗口大小

编辑 `windows/runner/main.cpp`：

```cpp
// 查找窗口创建代码，修改宽度和高度
const int windowWidth = 800;   // 修改宽度
const int windowHeight = 600;  // 修改高度
```

### 最小窗口大小

在 `windows/runner/flutter_window.cpp` 中：

```cpp
// 设置最小窗口尺寸
SetMinimumSize(Size(400, 300));  // 宽度, 高度
```

### 启动时最大化

```cpp
// 在窗口创建后添加
ShowWindow(hwnd, SW_MAXIMIZE);
```

## 📦 安装程序配置

### 使用 Inno Setup 创建安装程序

1. **安装 Inno Setup**：
   - 下载：https://jrsoftware.org/isdl.php

2. **创建配置文件**（`windows_installer.iss`）：

```iss
[Setup]
AppName=Project Cat Calculator
AppVersion=1.0.0
AppPublisher=Your Company Name
AppPublisherURL=https://github.com/YOUR_USERNAME/YOUR_REPO
DefaultDirName={autopf}\ProjectCat
DefaultGroupName=Project Cat Calculator
OutputBaseFilename=project_cat_setup_v1.0.0
Compression=lzma2
SolidCompression=yes
MinVersion=10.0.17134
ArchitecturesInstallIn64BitMode=x64

[Files]
Source: "build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs

[Icons]
Name: "{group}\Project Cat Calculator"; Filename: "{app}\project_cat.exe"
Name: "{commondesktop}\Project Cat Calculator"; Filename: "{app}\project_cat.exe"

[Run]
Filename: "{app}\project_cat.exe"; Description: "Launch Project Cat Calculator"; Flags: nowait postinstall skipifsilent
```

3. **编译安装程序**：
   ```bash
   # 使用 Inno Setup 编译
   iscc windows_installer.iss
   ```

### 使用 NSIS 创建安装程序

1. **安装 NSIS**：
   - 下载：https://nsis.sourceforge.io/

2. **创建配置文件**（`windows_installer.nsi`）：

```nsis
!define APP_NAME "Project Cat Calculator"
!define COMP_NAME "Your Company Name"
!define VERSION "1.0.0.0"
!define INSTALLER_NAME "project_cat_setup_v1.0.0.exe"

Name "${APP_NAME}"
OutFile "${INSTALLER_NAME}"
InstallDir "$PROGRAMFILES64\ProjectCat"

Section "Main"
  SetOutPath "$INSTDIR"
  File /r "build\windows\x64\runner\Release\*.*"
  CreateShortcut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\project_cat.exe"
  CreateDirectory "$SMPROGRAMS\${APP_NAME}"
  CreateShortcut "$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk" "$INSTDIR\project_cat.exe"
SectionEnd
```

## 🔧 高级配置

### 启用单实例模式

防止应用程序多次运行。编辑 `windows/runner/main.cpp`：

```cpp
// 添加互斥锁
HANDLE mutex = CreateMutex(NULL, TRUE, L"ProjectCatCalculatorMutex");
if (GetLastError() == ERROR_ALREADY_EXISTS) {
  MessageBox(NULL, L"Application is already running!", L"Project Cat", MB_OK);
  return 0;
}
```

### 添加启动画面

1. 准备启动画面图片
2. 在应用启动时显示
3. 加载完成后隐藏

### 系统托盘图标

实现系统托盘功能需要使用 Flutter 插件：

```yaml
dependencies:
  system_tray: ^2.0.3
```

## 🎯 代码签名

### 为什么需要代码签名？

- 避免 Windows SmartScreen 警告
- 增强用户信任
- 证明软件来源

### 获取代码签名证书

1. **商业证书**：
   - DigiCert
   - Sectigo
   - GlobalSign

2. **开源项目**（免费）：
   - SignPath.io（开源项目免费）

### 签名命令

```bash
# 使用 Windows SDK 的 signtool
signtool sign /f "certificate.pfx" /p "password" /tr http://timestamp.digicert.com /td sha256 /fd sha256 project_cat.exe

# 或使用 Azure SignTool
azuresigntool sign -kvu "https://vault.azure.net/" -kvt "<tenant-id>" -kvi "<client-id>" -kvs "<secret>" -kvc "<cert-name>" -tr http://timestamp.digicert.com -v project_cat.exe
```

### 在 GitHub Actions 中自动签名

在 `windows-release.yml` 中添加签名步骤：

```yaml
- name: Sign executable
  run: |
    # 从 GitHub Secrets 获取证书
    echo "${{ secrets.SIGNING_CERT }}" | base64 -d > cert.pfx
    signtool sign /f cert.pfx /p "${{ secrets.CERT_PASSWORD }}" project_cat.exe
  shell: bash
```

## 🌐 国际化

### 支持多语言窗口标题

编辑 `windows/runner/Runner.rc`：

```rc
// 添加多语言资源
LANGUAGE LANG_CHINESE, SUBLANG_CHINESE_SIMPLIFIED
STRINGTABLE
BEGIN
    IDS_APP_TITLE           "项目猫计算器"
END

LANGUAGE LANG_ENGLISH, SUBLANG_ENGLISH_US
STRINGTABLE
BEGIN
    IDS_APP_TITLE           "Project Cat Calculator"
END
```

## 📊 性能优化

### 优化编译大小

```bash
# 使用 --split-debug-info 分离调试信息
flutter build windows --release --split-debug-info=./debug-info

# 使用 --obfuscate 混淆代码
flutter build windows --release --obfuscate --split-debug-info=./debug-info
```

### 编译优化选项

编辑 `windows/runner/CMakeLists.txt`：

```cmake
# 添加编译优化
if(CMAKE_BUILD_TYPE STREQUAL "Release")
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /O2 /Ob2")
endif()
```

## 🔍 调试配置

### 启用控制台窗口（调试用）

编辑 `windows/runner/main.cpp`：

```cpp
// 注释掉这行以显示控制台
// #pragma comment(linker, "/SUBSYSTEM:WINDOWS")
```

### 添加日志输出

```cpp
// 在 main.cpp 中添加
#include <iostream>
std::cout << "Application starting..." << std::endl;
```

## 📚 参考资料

- [Flutter Desktop 文档](https://docs.flutter.dev/desktop)
- [Windows 应用程序清单](https://docs.microsoft.com/en-us/windows/apps/desktop/)
- [Inno Setup 文档](https://jrsoftware.org/ishelp/)
- [NSIS 文档](https://nsis.sourceforge.io/Docs/)
- [Windows 代码签名指南](https://docs.microsoft.com/en-us/windows/win32/seccrypto/cryptography-tools)

## 💡 最佳实践

1. **版本控制**：在每次发布前更新版本号
2. **测试**：在多个 Windows 版本上测试
3. **文档**：保持文档与实际配置同步
4. **备份**：保存证书和密钥的备份
5. **自动化**：使用 CI/CD 自动化构建流程

## 🆘 需要帮助？

如有问题，请：
1. 查看本文档
2. 搜索 [Flutter GitHub Issues](https://github.com/flutter/flutter/issues)
3. 在项目中提交 Issue
