# wayfless_generator_flutter

This is a rewrite work of https://github.com/liudonghua123/wayfless-generator using flutter.

You can visit the web version on https://liudonghua123.github.io/wayfless_generator_flutter/, or download android/ios mobile apps, MacOS/Linux/Windows desktop apps on the release page.

## Getting Started

Because of using the web and desktop features, you should config flutter to use `master` branch. And enable these features via the following commands.

Please Note Windows and Linux desktop platform support are still in technical preview.

```bash
flutter config --enable-web
flutter config --enable-macos-desktop
flutter config --enable-linux-desktop
flutter config --enable-windows-desktop
```

Dev command:

`flutter run -d android/ios/chrome/macos/linux/windows`

Build command: (Does not support build other desktop platform apps, in short does not support *cross-compilation*)

```bash
> flutter build -h
Flutter build commands.

Usage: flutter build <subcommand> [arguments]
-h, --help    Print this usage information.

Available subcommands:
  aar             Build a repository containing an AAR and a POM file.
  aot             Build an ahead-of-time compiled snapshot of your app's Dart
                  code.
  apk             Build an Android APK file from your app.
  appbundle       Build an Android App Bundle file from your app.
  bundle          Build the Flutter assets directory from your app.
  ios             Build an iOS application bundle (Mac OS X host only).
  ios-framework   Produces a .framework directory for a Flutter module and its
                  plugins for integration into existing, plain Xcode projects.
  macos           build the MacOS desktop target.
  linux           build the Linux desktop target.
  web             build a web application bundle.
  windows         build the desktop Windows target.

Run "flutter help" to see global options.
```

## References

- [online documentation](https://flutter.dev/docs)
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Web support for Flutter](https://flutter.dev/web)
- [Building a web application with Flutter](https://flutter.dev/docs/get-started/web)
- [Desktop support for Flutter](https://flutter.dev/desktop)
- [Desktop shells](https://github.com/flutter/flutter/wiki/Desktop-shells)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [Dart cheatsheet codelab](https://dart.dev/codelabs/dart-cheatsheet)
- [DartPad](https://dartpad.cn/)
- [Particle Animations with Flutter](https://juejin.im/post/5e1d5b9b6fb9a03013306588)
- [Fancy background animations in Flutter](https://juejin.im/post/5e1c38c96fb9a02fee1ed09e)
