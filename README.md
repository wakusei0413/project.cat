# Project Cat Calculator

A cross-platform calculator application built with Flutter, featuring Material 3 design and clean architecture.

## Features

- 🎨 Material 3 Design with light and dark theme support
- 🏗️ Clean Architecture with layered structure
- 📱 Cross-platform support (Android, iOS, Web, macOS, Windows, Linux)
- 🔥 State management with Riverpod
- 🧮 Mathematical expression evaluation

## Project Structure

```
lib/
├── app.dart                    # App entry point with theme configuration
├── main.dart                   # Main entry with ProviderScope
└── features/
    └── calculator/
        ├── presentation/       # UI components and pages
        ├── application/        # Business logic and state management
        ├── domain/            # Domain models and interfaces
        └── infrastructure/    # External services and implementations
```

## Dependencies

- **flutter_riverpod** & **hooks_riverpod**: State management
- **math_expressions**: Mathematical expression parsing and evaluation
- **shared_preferences**: Local data persistence
- **flutter_lints**: Code quality and style enforcement

## Getting Started

### Prerequisites

- Flutter SDK (3.35.7 or higher)
- Dart SDK (3.9.2 or higher)
- Platform-specific requirements:
  - **Android**: Android Studio or Android SDK
  - **iOS**: Xcode (macOS only)
  - **Web**: Chrome browser
  - **Desktop**: Platform-specific build tools

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd project_cat
```

2. Install dependencies:
```bash
flutter pub get
```

3. Verify the installation:
```bash
flutter doctor
```

### Running the Application

#### All Platforms

```bash
# Run on connected device or emulator
flutter run

# Run on specific platform
flutter run -d chrome           # Web
flutter run -d macos            # macOS
flutter run -d windows          # Windows
flutter run -d linux            # Linux
flutter run -d <device-id>      # Mobile device
```

#### Web

```bash
flutter run -d chrome
# or
flutter run -d web-server --web-port=8080
```

#### Desktop

```bash
# macOS
flutter run -d macos

# Windows
flutter run -d windows

# Linux
flutter run -d linux
```

#### Mobile

```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

### Building for Production

```bash
# Android APK
flutter build apk

# Android App Bundle
flutter build appbundle

# iOS
flutter build ios

# Web
flutter build web

# Desktop
flutter build macos
flutter build windows
flutter build linux
```

## Development

### Code Quality

This project uses `flutter_lints` for code quality enforcement. Run the analyzer:

```bash
flutter analyze
```

### Code Formatting

Format your code using:

```bash
dart format .
```

### Testing

Run tests:

```bash
flutter test
```

## Architecture

The project follows Clean Architecture principles with separation into layers:

- **Presentation Layer**: UI components, widgets, and pages
- **Application Layer**: Business logic, use cases, and state management
- **Domain Layer**: Core business entities and repository interfaces
- **Infrastructure Layer**: External services, API clients, and data sources

## Theme

The app supports both light and dark themes using Material 3 design system. The theme automatically adapts based on system preferences.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is private and not published to pub.dev.

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Material 3 Design](https://m3.material.io/)
- [Riverpod Documentation](https://riverpod.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
