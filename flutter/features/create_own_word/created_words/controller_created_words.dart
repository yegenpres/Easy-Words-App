import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/architect/abstract/abstracts.dart';
import 'package:wordsapp/features/create_own_word/created_words/model_created_words.dart';
import 'package:wordsapp/features/word/word.dart';

class ControllerCreatedWords extends DataController<CreatedWords> {
  static late StateNotifierProvider<ControllerCreatedWords, CreatedWords>
      stateProvider;

  ControllerCreatedWords({
    required super.provider,
    super.initialHandler,
  }) : super(initialData: CreatedWords());

  void addWord(Word word) {
    state = state.copyWith(words: {...state.words, word});
    provider.save(state);
  }

  Set<Word> get words => state.words;
}
