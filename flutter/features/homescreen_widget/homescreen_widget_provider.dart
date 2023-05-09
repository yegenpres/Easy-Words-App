import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordsapp/architect/interfaces/interfaces.dart';
import 'package:wordsapp/config.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';

class HomeScreenWidgetProvider {
  static const String _key = "widgetWords";

  static Future<String?> _fetchImage(ImagedWordable word) async {
    final storeLazy = Hive.lazyBox(HiveBoxes.imagesBox.name);
    final Uint8List bytes =
        await storeLazy.get(word.wordID, defaultValue: Uint8List(0));
    var printableString = base64.encode(bytes);

    if (printableString.isNotEmpty) return printableString;
    return null;
  }

  static Future<String> _parseWord(ImagedWordable word) async =>
      '${word.english} | ${word.ruTranslate} | ${await _fetchImage(word) ?? ""}';

  static void save(List<ImagedWordable> words) async {
    String result = '';
    for (var word in words) {
      result += ' || ${await _parseWord(word)}';
    }

    lv6(result);
    if (Platform.isIOS || Platform.isMacOS) {
      await SharedPreferenceAppGroup.setAppGroup(appGroup);
      SharedPreferenceAppGroup.setString("flutter.$_key", result);
    } else {
      final store = await SharedPreferences.getInstance();
      store.setString(_key, result);
    }
  }
}
