# QuickShop — Mobile Computing Assignment 1

**Student:** Hafiz Muhammad Ammar Ali  
**Roll number:** 2502123  
**Section:** BS IT 3B

QuickShop is a shopping app built in Flutter and Dart. It uses an in-memory list of products, without a backend, database, or external product API.

## Run on Android

1. Open the project in Android Studio or VS Code.
2. Start an Android emulator (the tested emulator was `emulator-5554`).
3. Run `flutter pub get` followed by `flutter run -d emulator-5554`.
4. Run `flutter test` for the included tests.

The debug APK built successfully with Flutter 3.47.4 and was installed on the Android emulator. Both Flutter tests passed.

## Features

- Shopping-bag splash screen with automatic Home navigation
- Home product cards and navigation drawer
- Product detail screen and Add to Cart SnackBar
- Validated Add Product form and in-memory list updates
- Single tap, double tap, long press, horizontal swipe, and vertical drag
- AnimatedContainer, counter increment/decrement using `setState()`
- Embedded WebView with Android INTERNET permission

## Assignment deliverables

- [Final assignment ZIP — source, Word report, PDF, and 16 emulator screenshots](submission/QuickShop_Assignment_1_FINAL_2502123.zip)
- [Final PDF report](submission/QuickShop_Assignment_1_Hafiz_Muhammad_Ammar_Ali_FINAL.pdf)
- [Flutter source ZIP](submission/QuickShop_Project.zip)

## Development notes

The working build pins `webview_flutter` to 4.10.0 and `webview_flutter_android` to 4.10.15 after a newer plugin produced Kotlin compilation errors with the installed Android build toolchain.

The WebView screen opens and starts loading `https://example.com`, but the external page did not finish rendering in the emulator test. This limitation is recorded in the report. Added products remain available only during the running app session.
