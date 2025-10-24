# GitHub Actions for iOS Building

## 🆓 **Free iOS Building with GitHub Actions**

GitHub Actions provides free macOS runners that can build iOS apps for public repositories.

### **✅ Advantages:**
- **Completely Free**: For public repositories
- **No Setup Required**: Just push code to GitHub
- **Automatic Builds**: Build on every commit
- **Easy Integration**: Built into GitHub

### **📋 Requirements:**
- **GitHub Account**: Free
- **Public Repository**: Required for free builds
- **Apple Developer Account**: For App Store deployment ($99/year)

## 🔧 **Setup Instructions**

### **Step 1: Create GitHub Repository**
1. **Go to** github.com
2. **Create** new repository: `smarthome-ios`
3. **Make it public** (required for free builds)
4. **Initialize** with README

### **Step 2: Upload Your Project**
```bash
# In your project directory
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/yourusername/smarthome-ios.git
git push -u origin main
```

### **Step 3: Create GitHub Actions Workflow**
Create file: `.github/workflows/ios-build.yml`

```yaml
name: iOS Build

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  workflow_dispatch: # Allow manual triggers

jobs:
  build-ios:
    runs-on: macos-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      
    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.27.4'
        channel: 'stable'
        
    - name: Install dependencies
      run: flutter pub get
      
    - name: Run Flutter analyze
      run: flutter analyze
      
    - name: Run Flutter tests
      run: flutter test
      
    - name: Build iOS app
      run: flutter build ios --release --no-codesign
      
    - name: Upload build artifacts
      uses: actions/upload-artifact@v4
      with:
        name: ios-build-${{ github.run_number }}
        path: build/ios/
        retention-days: 30
```

### **Step 4: Trigger Build**
1. **Commit** the workflow file
2. **Push** to GitHub
3. **Go to** Actions tab in GitHub
4. **Watch** the build process

### **Step 5: Download Build**
1. **Go to** Actions tab
2. **Click** on completed workflow
3. **Download** artifacts
4. **Extract** iOS build files

## 📱 **Advanced: App Store Deployment**

### **For App Store Distribution:**
```yaml
# Add to workflow after iOS build step
- name: Setup Xcode
  uses: maxim-lobanov/setup-xcode@v1
  with:
    xcode-version: latest-stable

- name: Build and sign iOS app
  run: |
    flutter build ios --release
    cd ios
    xcodebuild -workspace Runner.xcworkspace \
               -scheme Runner \
               -configuration Release \
               -destination generic/platform=iOS \
               -archivePath Runner.xcarchive \
               archive

- name: Export IPA
  run: |
    xcodebuild -exportArchive \
               -archivePath Runner.xcarchive \
               -exportPath . \
               -exportOptionsPlist ExportOptions.plist
```

## 🎯 **Complete Workflow Example**

### **Full iOS Build with Testing:**
```yaml
name: Smart Home iOS Build

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]
  schedule:
    - cron: '0 0 * * 1' # Weekly builds

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.27.4'
    - run: flutter pub get
    - run: flutter analyze
    - run: flutter test

  build-ios:
    needs: test
    runs-on: macos-latest
    steps:
    - uses: actions/checkout@v4
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.27.4'
    - run: flutter pub get
    - run: flutter build ios --release --no-codesign
    - uses: actions/upload-artifact@v4
      with:
        name: ios-build
        path: build/ios/
```

## 🚀 **Quick Start Guide**

### **5-Minute Setup:**

1. **Create GitHub repo** (public)
2. **Upload your code**:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/yourusername/smarthome.git
   git push -u origin main
   ```

3. **Create workflow file**:
   - Go to Actions tab
   - Click "New workflow"
   - Choose "Flutter" template
   - Modify for iOS build

4. **Run build**:
   - Push workflow file
   - Watch build in Actions tab
   - Download artifacts when complete

## 💡 **Pro Tips**

### **Optimize Build Time:**
- Use `flutter build ios --release --no-codesign` for faster builds
- Cache Flutter dependencies
- Use matrix builds for multiple iOS versions

### **Security:**
- Use GitHub Secrets for sensitive data
- Don't commit API keys or certificates
- Use environment variables for configuration

## 📊 **Build Status**

After setup, you'll see:
- ✅ **Automatic builds** on every commit
- ✅ **Build status** in repository
- ✅ **Downloadable artifacts**
- ✅ **Build logs** for debugging

## 🎉 **Result**

You'll get:
- **iOS app** built automatically
- **No macOS required**
- **Free** (for public repos)
- **Professional** CI/CD pipeline

Ready to set up GitHub Actions for your iOS build?

