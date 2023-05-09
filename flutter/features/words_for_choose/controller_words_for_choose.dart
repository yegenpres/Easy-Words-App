import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/architect/abstract/abstracts.dart';
import 'package:wordsapp/architect/interfaces/interfaces.dart';
import 'package:wordsapp/features/word/word.dart';
import 'package:wordsapp/features/words_for_choose/model_words_for_choose.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';

class WordsForChooseController extends DataController<WordsForChooseData> {
  static late StateNotifierProvider<WordsForChooseController,
      WordsForChooseData> stateProvider;

  WordsForChooseController({required DataProvider<WordsForChooseData> provider})
      : super(
            initialData: const WordsForChooseData(words: {}),
            provider: provider) {
    lv6("                !!!!!!!!!!!!!!!!!!!!!init WordsForChooseController");
  }

  Set<Word> get words => state.words;

  void remove(Word word) {
    var words = {...state.words};
    words.remove(word);
    state = state.copyWith(words: words);
  }
}
