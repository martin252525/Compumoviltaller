# google-services.json Configuration

This file is **intentionally not included** in the repository for security reasons.

## Why is this file missing?

The `google-services.json` file contains Firebase project-specific configuration including API keys and project IDs. Each developer needs their own Firebase project and configuration file.

## Do I need this file?

**NO** - if you only want to:
- Browse votations
- Search and filter votations
- View votation details
- See results

**YES** - if you want to:
- Sign in with Google
- Cast votes
- See your vote history

## How to get this file?

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project (or use existing)
3. Add an Android app to your project:
   - **Package name:** `cm.utem.app` (must match exactly)
   - **App nickname:** Any name you want
   - Skip SHA-1 for now (optional for development)
4. Download the `google-services.json` file
5. Place it in: `app/android/app/google-services.json`
6. Enable Google Sign-In in Firebase Console:
   - Go to Authentication → Sign-in method
   - Enable "Google"
7. Rebuild your app:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

## File location

The file should be placed at:
```
app/
└── android/
    └── app/
        └── google-services.json  <-- Here
```

## Structure (for reference)

The file should look something like this (with your own values):

```json
{
  "project_info": {
    "project_number": "123456789012",
    "project_id": "your-project-id",
    "storage_bucket": "your-project-id.appspot.com"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "1:123456789012:android:abcdef123456",
        "android_client_info": {
          "package_name": "cm.utem.app"
        }
      },
      "oauth_client": [
        {
          "client_id": "123456789012-abcdefghijklmnop.apps.googleusercontent.com",
          "client_type": 3
        }
      ],
      "api_key": [
        {
          "current_key": "AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        }
      ],
      "services": {
        "appinvite_service": {
          "other_platform_oauth_client": []
        }
      }
    }
  ],
  "configuration_version": "1"
}
```

## Security Notice

⚠️ **NEVER** commit this file to a public repository!

The `.gitignore` file already excludes `google-services.json` to prevent accidental commits.

## Troubleshooting

### "Default FirebaseApp is not initialized"
- Make sure the file is in the correct location
- Verify the package name matches: `cm.utem.app`
- Run `flutter clean` and rebuild

### "No matching client found for package name"
- The package name in the file must be exactly: `cm.utem.app`
- Download the file again from Firebase Console
- Ensure you added the correct package name when creating the Android app

### Build errors after adding the file
```bash
flutter clean
cd android
./gradlew clean
cd ..
flutter pub get
flutter run
```

## More Information

See the complete Firebase setup guide in:
- [GUIA_EMULADOR_COMPLETA.md](../GUIA_EMULADOR_COMPLETA.md) - Section "Configurar Firebase"
- [README.md](../README.md) - Section "Configuración de Firebase"
