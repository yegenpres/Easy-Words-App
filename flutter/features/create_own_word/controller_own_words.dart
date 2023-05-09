import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/architect/abstract/abstracts.dart';
import 'package:wordsapp/features/create_own_word/empty_word.dart';
import 'package:wordsapp/features/create_own_word/model_own_words.dart';
import 'package:wordsapp/features/create_own_word/provider_own_words.dart';
import 'package:wordsapp/features/create_own_word/word_parts_enum.dart';
import 'package:wordsapp/features/http_client.dart';

class OwnWordsController extends DataController<ModelOwnWords> {
  static late StateNotifierProvider<OwnWordsController, ModelOwnWords>
      stateProvider;

  OwnWordsController({
    required OwnWordsProvider provider,
    super.initialHandler,
  }) : super(initialData: ModelOwnWords(), provider: provider);

  final String _percent = Platform.isIOS ? "%25" : "%";

  final Dio dio = NetworkClient.dio;

  void findTrailing(String query) {
    _fetchParts(_percent + query);
  }

  void findLeading(String query) {
    _fetchParts(query + _percent);
  }

  void findMiddle(String query) {
    _fetchParts(_percent + query + _percent);
  }

  void _fetchParts(String part) async {
    state = state.copyWith(wordsParts: {WordParts.loadingData.name});

    Set<String> words = await NetworkClient.ownWords.fetchParts(part);

    state = state.copyWith(wordsParts: words);
  }

  void remove(String id) {
    Set<EmptyWord> set = {...state.emptyWords};
    set.removeWhere((w) => w.wordID == id);

    state = state.copyWith(emptyWords: set);
  }

  Set<String> get wordParts {
    return state.wordsParts;
  }
}
