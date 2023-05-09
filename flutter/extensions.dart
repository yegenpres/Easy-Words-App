import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordsapp/view/app_geometry.dart';
import 'package:wordsapp/view/colors.dart';

enum ThemeMode { cupertinoLight, cupertinoDark, materialLight, materialDark }

T platformSelector<T>({
  required T material,
  required T cupertino,
}) {
  if (Platform.isIOS || Platform.isMacOS) {
    return cupertino;
  } else {
    return material;
  }
}

extension Geometry on BuildContext {
  AppGeometry get appGeometry => AppGeometry((LocalizationGeometry geometry) {
        if (Platform.isIOS || Platform.isMacOS) {
          return geometry.cupertino;
        } else {
          return geometry.material;
        }
      });
}

extension Themes on BuildContext {
  ThemeMode get themeMode {
    var brightness = MediaQuery.of(this).platformBrightness;
    if (Platform.isIOS || Platform.isMacOS) {
      return brightness == Brightness.dark
          ? ThemeMode.cupertinoDark
          : ThemeMode.cupertinoLight;
    } else {
      return brightness == Brightness.dark
          ? ThemeMode.materialDark
          : ThemeMode.materialLight;
    }
  }

  bool isDarkMode() {
    var brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }

  T platformSelector<T>({
    required T material,
    required T cupertino,
  }) {
    switch (Theme.of(this).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return material;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return cupertino;
    }
  }

  Color get primaryColor {
    return platformSelector(
      material: Theme.of(this).primaryColor,
      cupertino: CupertinoTheme.of(this).primaryColor,
    );
  }

  Color get scaffoldBackgroundColor {
    return platformSelector(
      material: Theme.of(this).scaffoldBackgroundColor,
      cupertino: CupertinoTheme.of(this).scaffoldBackgroundColor,
    );
  }

  Color get barBackgroundColor {
    return platformSelector(
      material: Theme.of(this).bottomAppBarColor,
      cupertino: CupertinoTheme.of(this).barBackgroundColor,
    );
  }

  Color get primaryContrastingColors {
    return platformSelector(
      material: Theme.of(this).cardColor,
      cupertino: CupertinoTheme.of(this).primaryContrastingColor,
    );
  }

  Color _testColor(LocalizationColor colors) {
    switch (themeMode) {
      case ThemeMode.cupertinoLight:
        return colors.cupertinoLight;

      case ThemeMode.cupertinoDark:
        return colors.cupertinoDark;
      case ThemeMode.materialLight:
        return colors.materialLight;
      case ThemeMode.materialDark:
        return colors.materialDark;
    }
  }

  Color testColor({
    required Color cupertinoDark,
    required cupertinoLight,
    required Color materialDark,
    required Color materialLight,
  }) {
    switch (themeMode) {
      case ThemeMode.cupertinoLight:
        return cupertinoLight;

      case ThemeMode.cupertinoDark:
        return cupertinoDark;
      case ThemeMode.materialLight:
        return materialLight;
      case ThemeMode.materialDark:
        return materialDark;
    }
  }

  Color get coloredPrimaryText => platformSelector(
        material: Theme.of(this).colorScheme.secondary,
        cupertino: primaryColor,
      );

  AppColors get appColors => AppColors(_testColor);
}

extension StringValidators on String {
  bool get containsUppercase => contains(RegExp(r'[A-Z,А-Я]'));
  bool get containsLowercase => contains(RegExp(r'[a-z,а-я]'));
}
