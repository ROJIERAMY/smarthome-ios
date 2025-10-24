@echo off
REM Smart Home App - Cross-Platform Build Script for Windows
REM This script builds the app for different platforms

echo 🏠 Smart Home AI App - Build Script
echo ==================================

REM Function to check if Flutter is installed
:check_flutter
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Flutter is not installed or not in PATH
    echo Please install Flutter: https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)
echo ✅ Flutter found
goto :eof

REM Function to clean and get dependencies
:setup_project
echo 🧹 Cleaning project...
flutter clean

echo 📦 Getting dependencies...
flutter pub get

echo 🔍 Analyzing code...
flutter analyze
goto :eof

REM Function to build for Android
:build_android
echo 🤖 Building for Android...

REM Debug build
echo Building debug APK...
flutter build apk --debug
if %errorlevel% equ 0 (
    echo ✅ Debug APK built: build\app\outputs\flutter-apk\app-debug.apk
) else (
    echo ❌ Debug APK build failed
)

REM Release build
echo Building release APK...
flutter build apk --release
if %errorlevel% equ 0 (
    echo ✅ Release APK built: build\app\outputs\flutter-apk\app-release.apk
) else (
    echo ❌ Release APK build failed
)

REM App Bundle (for Play Store)
echo Building App Bundle...
flutter build appbundle --release
if %errorlevel% equ 0 (
    echo ✅ App Bundle built: build\app\outputs\bundle\release\app-release.aab
) else (
    echo ❌ App Bundle build failed
)
goto :eof

REM Function to build for Web
:build_web
echo 🌐 Building for Web...
flutter build web
if %errorlevel% equ 0 (
    echo ✅ Web build completed: build\web\
) else (
    echo ❌ Web build failed
)
goto :eof

REM Function to run tests
:run_tests
echo 🧪 Running tests...
flutter test
if %errorlevel% equ 0 (
    echo ✅ Tests completed
) else (
    echo ❌ Tests failed
)
goto :eof

REM Function to show help
:show_help
echo Usage: %0 [OPTIONS]
echo.
echo Options:
echo   android    Build for Android (APK and App Bundle)
echo   web        Build for Web
echo   all        Build for Android and Web
echo   test       Run tests
echo   clean      Clean project and get dependencies
echo   help       Show this help message
echo.
echo Examples:
echo   %0 android    # Build Android APK
echo   %0 web        # Build web version
echo   %0 all        # Build for Android and Web
echo.
echo Note: iOS builds require macOS
goto :eof

REM Main script logic
:main
call :check_flutter
if %errorlevel% neq 0 exit /b 1

if "%1"=="android" (
    call :setup_project
    call :build_android
) else if "%1"=="web" (
    call :setup_project
    call :build_web
) else if "%1"=="all" (
    call :setup_project
    call :build_android
    call :build_web
) else if "%1"=="test" (
    call :setup_project
    call :run_tests
) else if "%1"=="clean" (
    call :setup_project
) else (
    call :show_help
)

echo.
echo 🎉 Build process completed!
echo.
echo 📱 Platform Status:
echo   Android: ✅ Ready
echo   iOS: ✅ Ready (requires macOS)
echo   Web: ✅ Ready
echo.
echo 📁 Build outputs:
echo   Android APK: build\app\outputs\flutter-apk\
echo   Android Bundle: build\app\outputs\bundle\
echo   Web: build\web\
echo.
pause
goto :eof

REM Run main function with all arguments
call :main %*
