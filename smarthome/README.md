# smarthome

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## CI/CD with GitHub Actions

This project includes GitHub Actions workflows for automated building:

### Android APK Build
- **Workflow**: `.github/workflows/android.yml`
- **Triggers**: Push to main/master/develop branches, pull requests, or manual trigger
- **Output**: APK artifact available for download from the Actions tab

### iOS Build
- **Workflow**: `.github/workflows/ios.yml`
- **Triggers**: Push to main/master/develop branches, pull requests, or manual trigger
- **Output**: IPA and App artifacts available for download from the Actions tab
- **Note**: iOS builds require macOS runners. For production releases, you may need to configure code signing with certificates and provisioning profiles.

### How to Use

1. Push your code to GitHub
2. Navigate to the **Actions** tab in your GitHub repository
3. Select the workflow you want to run (Build Android APK or Build iOS)
4. Click **Run workflow** to manually trigger a build
5. Once complete, download the artifacts from the workflow run

### Requirements for iOS Production Builds

For production iOS builds with code signing, you'll need to:
1. Add your Apple Developer certificates as GitHub Secrets
2. Configure provisioning profiles
3. Update the iOS workflow to use these credentials for signing

See [Flutter's iOS deployment guide](https://docs.flutter.dev/deployment/ios) for more details.