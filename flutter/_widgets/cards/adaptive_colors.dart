import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AdaptiveColors {
  static int index = 0;
  static final Map<String, int> _colorsMap = {};

  static final List<Color> _colors = [
    if (Platform.isIOS) ...{
      CupertinoColors.activeBlue,
      CupertinoColors.activeGreen,
      CupertinoColors.activeOrange,
      CupertinoColors.systemYellow,
    },
    if (!Platform.isIOS) ...{
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.yellow,
    }
  ];

  static Color getOrdered(String wordId) {
    if (_colorsMap.containsKey(wordId)) {
      final index = _colorsMap[wordId]!;
      return _colors[index];
    } else {
      _colorsMap[wordId] = _getNextColor();
      final index = _colorsMap[wordId]!;
      return _colors[index];
    }
  }

  static int _getNextColor() {
    if (index == _colors.length - 1) {
      index = 0;
      return _colors.indexOf(_colors.last);
    } else {
      return _colors.indexOf(_colors[index++]);
    }
  }
}
