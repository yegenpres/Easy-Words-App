import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:wordsapp/config.dart';
import 'package:wordsapp/features/word/word.dart';

class Search extends ChangeNotifier {
  static late ChangeNotifierProvider<Search> provider;
  final Box _box = Hive.box(HiveBoxes.searchKeshBox.name);

  final _rulEng = RegExp(r'^[a-zA-Z ]+$');
  final _rulRu = RegExp(r'^[а-яА-Я ]+$');
  final _rulDate = RegExp(r'^[0-9 .-]+$');

  Timer? _searchDebounce;

  Set<Word> result = {};

  List<dynamic> get getKesh => _box.values.toList();

  int _positionInList(String query) {
    if (_rulEng.hasMatch(query)) return 0;
    if (_rulRu.hasMatch(query)) return 1;
    if (_rulDate.hasMatch(query)) return 2;
    return -1;
  }

  List _searchWordsIndex(String query) {
    final int position = _positionInList(query);
    List<int> result = [];

    if (position != -1) {
      _box.values.toList().forEach((item) {
        final bool isContain =
            item[position].toLowerCase().contains(query.toLowerCase());

        if (isContain) {
          final int index = _box.values.toList().indexOf(item);
          result.add(index);
        }
      });
    }

    return result;
  }

  _search(query) {
    final store = Hive.box<Word>(HiveBoxes.wordBox.name);
    final searchedIndex = _searchWordsIndex(query);
    if (searchedIndex.isNotEmpty) {
      for (var index in searchedIndex) {
        Word word = store.values.toList()[index];

        result.add(word);
      }
    }

    notifyListeners();
  }

  void search(query) {
    result = {};
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      _search(query);
    });
  }
}
