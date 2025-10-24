# Codemagic CI/CD for iOS Building

## 🚀 **Codemagic - Best Option for Windows Users**

Codemagic is a cloud-based CI/CD service that can build iOS apps from Windows without needing macOS access.

### **✅ Advantages:**
- **No macOS Required**: Build iOS apps from any platform
- **Free Tier**: 500 build minutes/month free
- **Easy Setup**: Connect GitHub/GitLab repository
- **Automatic Builds**: Build on every commit
- **App Store Deployment**: Direct deployment to App Store

### **💰 Pricing:**
- **Free**: 500 build minutes/month
- **Paid**: $95/month for unlimited builds
- **Your Project**: Will likely fit in free tier

## 🔧 **Setup Instructions**

### **Step 1: Prepare Your Project**
1. **Commit** your code to GitHub/GitLab
2. **Ensure** all files are committed
3. **Verify** `pubspec.yaml` has correct dependencies

### **Step 2: Sign Up for Codemagic**
1. Go to [codemagic.io](https://codemagic.io)
2. **Sign up** with GitHub/GitLab account
3. **Connect** your repository

### **Step 3: Configure Build**
1. **Select** your repository
2. **Choose** Flutter workflow
3. **Configure** build settings:

```yaml
# codemagic.yaml
workflows:
  ios-workflow:
    name: iOS Workflow
    max_build_duration: 60
    environment:
      flutter: stable
      xcode: latest
      cocoapods: default
    scripts:
      - name: Set up code signing settings on Xcode project
        script: |
          xcode-project use-profiles
      - name: Get Flutter packages
        script: |
          flutter packages pub get
      - name: Flutter analyze
        script: |
          flutter analyze
      - name: Flutter unit tests
        script: |
          flutter test
      - name: Build ipa for distribution
        script: |
          flutter build ipa --release
    artifacts:
      - build/ios/ipa/*.ipa
      - /tmp/xcodebuild_logs/*.log
      - flutter_drive.log
    publishing:
      app_store_connect:
        auth: integration
        submit_to_testflight: true
```

### **Step 4: Apple Developer Setup**
1. **Apple Developer Account**: Required ($99/year)
2. **App Store Connect**: Create app listing
3. **Certificates**: Codemagic handles automatically

### **Step 5: Build and Deploy**
1. **Trigger** build manually or on commit
2. **Wait** for build completion (5-10 minutes)
3. **Download** IPA file or deploy to TestFlight

## 📱 **Alternative: GitHub Actions**

### **GitHub Actions with macOS Runner**
```yaml
# .github/workflows/ios.yml
name: iOS Build

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: macos-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.27.4'
        
    - name: Install dependencies
      run: flutter pub get
      
    - name: Run tests
      run: flutter test
      
    - name: Build iOS
      run: flutter build ios --release
      
    - name: Upload build artifacts
      uses: actions/upload-artifact@v3
      with:
        name: ios-build
        path: build/ios/
```

## 🎯 **Recommended Workflow**

### **For Your Smart Home App:**

1. **Upload to GitHub**:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/yourusername/smarthome.git
   git push -u origin main
   ```

2. **Connect to Codemagic**:
   - Sign up at codemagic.io
   - Connect your GitHub repository
   - Use Flutter template

3. **Build iOS App**:
   - Codemagic builds automatically
   - Download IPA file
   - Deploy to TestFlight

## 💡 **Cost Breakdown**

| Option | Cost | Time | Effort |
|--------|------|------|--------|
| MacinCloud | $20/month | 2-4 hours | Medium |
| Codemagic | Free/Paid | 10 minutes | Low |
| GitHub Actions | Free | 10 minutes | Low |
| Hire Developer | $50-200 | 1-2 days | Very Low |

## 🚀 **Quick Start with Codemagic**

1. **Upload** your project to GitHub
2. **Sign up** at codemagic.io
3. **Connect** repository
4. **Run** first build
5. **Download** iOS app

**Total time**: 30 minutes
**Cost**: Free (if under 500 minutes/month)

Would you like me to help you set up Codemagic or GitHub Actions?
