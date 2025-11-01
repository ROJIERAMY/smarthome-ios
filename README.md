# 🏠 Smart Home AI App

A comprehensive Flutter application for smart home automation with Firebase backend integration.

## ✨ Features

### 🔐 **Authentication System**
- **Secure Login/Registration** with Firebase Authentication
- **User Role Management** (Admin vs Regular User)
- **Persistent Sessions** with SharedPreferences

### 🏡 **Smart Home Controls**
- **Quick Controls**: Lights, Fan, AC toggle switches
- **Temperature Control**: Interactive AC temperature slider
- **Brightness Control**: Light brightness adjustment
- **Security System**: Armed/disarmed status monitoring
- **Device Status**: Real-time device status indicators

### 👨‍💼 **Admin Dashboard**
- **User Management**: View, edit, and manage users
- **Device Monitoring**: Track all connected devices
- **Activity Logs**: System activity and user actions
- **System Settings**: Configure system parameters
- **Statistics Overview**: System performance metrics

### 📱 **Cross-Platform Support**
- **Android**: ✅ Built and tested (APK available)
- **iOS**: ✅ Ready for build (requires macOS)
- **Web**: ✅ Built and ready for deployment

## 🚀 Quick Start

### **Prerequisites**
- Flutter SDK (3.6.0+)
- Firebase project setup
- Android Studio / Xcode (for mobile development)

### **Installation**
```bash
# Clone the repository
git clone <repository-url>
cd smarthome

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 📱 Platform-Specific Builds

### **Android**
```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release
```
**Output**: `build/app/outputs/flutter-apk/app-release.apk`

### **iOS** (macOS required)
```bash
# iOS Simulator
flutter build ios --simulator

# Physical Device
flutter build ios --release
```

### **Web**
```bash
# Web build
flutter build web
```
**Output**: `build/web/` directory

## 🔧 Configuration

### **Firebase Setup**
The app is pre-configured with Firebase:
- **Project ID**: `smart-home-81d77`
- **Authentication**: Email/Password enabled
- **Database**: Realtime Database configured
- **Platforms**: Android, iOS, Web configured

### **Environment Variables**
No additional environment variables needed - Firebase configuration is included.

## 📋 App Structure

```
lib/
├── main.dart                 # App entry point
├── auth_provider.dart        # Authentication state management
├── splash_screen.dart        # App loading screen
├── login_screen.dart         # User login interface
├── registration_screen.dart # User registration interface
├── home_page.dart           # Main smart home dashboard
├── admin_dashboard.dart     # Admin management panel
└── firebase_options.dart    # Firebase configuration
```

## 🎯 User Roles

### **Regular User**
- Access to smart home controls
- View device status
- Control lights, fan, AC, security
- Temperature and brightness adjustment

### **Admin User**
- All regular user features
- Access to admin dashboard
- User management capabilities
- System monitoring and logs
- Device management

## 🔒 Security Features

- **Firebase Authentication**: Secure user authentication
- **Role-based Access**: Admin features protected
- **Data Encryption**: Firebase handles data security
- **Session Management**: Secure token handling

## 📊 Technical Specifications

- **Framework**: Flutter 3.27.4
- **Language**: Dart 3.6.0+
- **Backend**: Firebase (Auth, Database)
- **State Management**: Provider pattern
- **Minimum Android**: API 23 (Android 6.0)
- **Minimum iOS**: iOS 12.0+
- **Architecture**: Clean architecture with separation of concerns

## 🚀 Deployment

### **Android Play Store**
1. Build release APK: `flutter build appbundle --release`
2. Upload to Google Play Console
3. Complete store listing and publish

### **iOS App Store**
1. Build iOS app on macOS: `flutter build ios --release`
2. Archive in Xcode
3. Upload to App Store Connect
4. Submit for review

### **Web Deployment**
1. Build web version: `flutter build web`
2. Deploy `build/web/` to any web hosting service
3. Configure Firebase hosting (optional)

## 🛠️ Development

### **Running Tests**
```bash
flutter test
```

### **Code Analysis**
```bash
flutter analyze
```

### **Hot Reload**
```bash
flutter run --hot
```

## 📞 Support

For iOS development, see [iOS_SETUP_GUIDE.md](iOS_SETUP_GUIDE.md)

## 📄 License

This project is licensed under the MIT License.

---

**Built with ❤️ using Flutter & Firebase**
