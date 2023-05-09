import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  Color Function(LocalizationColor) handler;

  AppColors(this.handler);

  Color get backgroundCardCorner => handler(LocalizationColor(
        materialLight: Colors.blue.shade100,
        materialDark: Colors.blue.shade600,
        cupertinoLight: Colors.blue.shade100,
        cupertinoDark: Colors.blue.shade600,
      ));

  Color get textFormColor => handler(LocalizationColor(
        cupertinoDark: CupertinoColors.lightBackgroundGray,
        cupertinoLight: CupertinoColors.white.withOpacity(.7),
        materialDark: Colors.black.withOpacity(.8),
        materialLight: CupertinoColors.white.withOpacity(.9),
      ));

  Color get cardColor => handler(LocalizationColor(
        cupertinoDark: CupertinoColors.darkBackgroundGray.withOpacity(.8),
        cupertinoLight: CupertinoColors.white.withOpacity(.7),
        materialDark: Colors.black.withOpacity(.8),
        materialLight: CupertinoColors.white.withOpacity(.9),
      ));

  Color get draggableLIst => handler(LocalizationColor(
        cupertinoDark: CupertinoColors.darkBackgroundGray,
        cupertinoLight: CupertinoColors.white,
        materialDark: Color.alphaBlend(Colors.white24, Colors.black),
        materialLight: CupertinoColors.white,
      ));

  Color get separator => handler(LocalizationColor(
        cupertinoDark: const Color(0xff252528),
        cupertinoLight: const Color(0xffEBEBEC),
        materialDark: Colors.white12,
        materialLight: Colors.black12,
      ));

  Color get scaffold => handler(LocalizationColor(
        cupertinoDark: const Color(0xff000000),
        cupertinoLight: const Color(0xffEFEEF6),
        materialDark: Colors.white,
        materialLight: Colors.black26,
      ));

  Color get text => handler(LocalizationColor(
        cupertinoDark: CupertinoColors.label.darkColor,
        cupertinoLight: Colors.black,
        materialDark: Colors.white,
        materialLight: Colors.black87,
      ));

  Color get hinText => handler(LocalizationColor(
        cupertinoDark: CupertinoColors.label.darkColor.withOpacity(.7),
        cupertinoLight: Colors.black.withOpacity(.7),
        materialDark: Colors.white.withOpacity(.7),
        materialLight: Colors.black12.withOpacity(.7),
      ));

  Color get shadows => handler(LocalizationColor(
        cupertinoDark: Colors.black,
        cupertinoLight: CupertinoColors.systemGrey,
        materialDark: Colors.black,
        materialLight: CupertinoColors.systemGrey,
      ));
}

class LocalizationColor {
  final Color cupertinoDark;
  final Color cupertinoLight;

  final Color materialDark;

  final Color materialLight;

  LocalizationColor({
    required this.cupertinoDark,
    required this.cupertinoLight,
    required this.materialDark,
    required this.materialLight,
  });
}
