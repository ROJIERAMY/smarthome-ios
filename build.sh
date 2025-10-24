#!/bin/bash

# Smart Home App - Cross-Platform Build Script
# This script builds the app for different platforms

echo "🏠 Smart Home AI App - Build Script"
echo "=================================="

# Function to check if Flutter is installed
check_flutter() {
    if ! command -v flutter &> /dev/null; then
        echo "❌ Flutter is not installed or not in PATH"
        echo "Please install Flutter: https://flutter.dev/docs/get-started/install"
        exit 1
    fi
    echo "✅ Flutter found: $(flutter --version | head -n 1)"
}

# Function to clean and get dependencies
setup_project() {
    echo "🧹 Cleaning project..."
    flutter clean
    
    echo "📦 Getting dependencies..."
    flutter pub get
    
    echo "🔍 Analyzing code..."
    flutter analyze
}

# Function to build for Android
build_android() {
    echo "🤖 Building for Android..."
    
    # Debug build
    echo "Building debug APK..."
    flutter build apk --debug
    echo "✅ Debug APK built: build/app/outputs/flutter-apk/app-debug.apk"
    
    # Release build
    echo "Building release APK..."
    flutter build apk --release
    echo "✅ Release APK built: build/app/outputs/flutter-apk/app-release.apk"
    
    # App Bundle (for Play Store)
    echo "Building App Bundle..."
    flutter build appbundle --release
    echo "✅ App Bundle built: build/app/outputs/bundle/release/app-release.aab"
}

# Function to build for iOS (macOS only)
build_ios() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        echo "❌ iOS builds require macOS"
        echo "Please run this script on macOS for iOS builds"
        return 1
    fi
    
    echo "🍎 Building for iOS..."
    
    # Check if Xcode is installed
    if ! command -v xcodebuild &> /dev/null; then
        echo "❌ Xcode is not installed"
        echo "Please install Xcode from the App Store"
        return 1
    fi
    
    # Simulator build
    echo "Building for iOS Simulator..."
    flutter build ios --simulator
    echo "✅ iOS Simulator build completed"
    
    # Device build (requires Apple Developer Account)
    echo "Building for iOS Device..."
    flutter build ios --release
    echo "✅ iOS Device build completed"
}

# Function to build for Web
build_web() {
    echo "🌐 Building for Web..."
    flutter build web
    echo "✅ Web build completed: build/web/"
}

# Function to run tests
run_tests() {
    echo "🧪 Running tests..."
    flutter test
    echo "✅ Tests completed"
}

# Function to show help
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  android    Build for Android (APK and App Bundle)"
    echo "  ios        Build for iOS (macOS only)"
    echo "  web        Build for Web"
    echo "  all        Build for all platforms"
    echo "  test       Run tests"
    echo "  clean      Clean project and get dependencies"
    echo "  help       Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 android    # Build Android APK"
    echo "  $0 ios        # Build iOS app (macOS)"
    echo "  $0 web        # Build web version"
    echo "  $0 all        # Build for all platforms"
}

# Main script logic
main() {
    check_flutter
    
    case "${1:-help}" in
        "android")
            setup_project
            build_android
            ;;
        "ios")
            setup_project
            build_ios
            ;;
        "web")
            setup_project
            build_web
            ;;
        "all")
            setup_project
            build_android
            build_web
            if [[ "$OSTYPE" == "darwin"* ]]; then
                build_ios
            else
                echo "⚠️  Skipping iOS build (requires macOS)"
            fi
            ;;
        "test")
            setup_project
            run_tests
            ;;
        "clean")
            setup_project
            ;;
        "help"|*)
            show_help
            ;;
    esac
    
    echo ""
    echo "🎉 Build process completed!"
    echo ""
    echo "📱 Platform Status:"
    echo "  Android: ✅ Ready"
    echo "  iOS: ✅ Ready (requires macOS)"
    echo "  Web: ✅ Ready"
    echo ""
    echo "📁 Build outputs:"
    echo "  Android APK: build/app/outputs/flutter-apk/"
    echo "  Android Bundle: build/app/outputs/bundle/"
    echo "  iOS: build/ios/"
    echo "  Web: build/web/"
}

# Run main function with all arguments
main "$@"

