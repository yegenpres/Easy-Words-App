import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/architect/abstract/abstracts.dart';
import 'package:wordsapp/architect/interfaces/interfaces.dart';
import 'package:wordsapp/features/http_client.dart';
import 'package:wordsapp/features/progress/model_progress.dart';
import 'package:wordsapp/features/progress/words_sorter.dart';
import 'package:wordsapp/features/word/word.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';

class ProgressController extends DataController<ProgressData> {
  static late StateNotifierProvider<ProgressController, ProgressData>
      stateProvider;
  final WordsSorter _sorter;

  ProgressController({
    required FetchableWordsProviderSync<ProgressData> provider,
    WordsSorter sorter = const WordsSorter(),
    super.initialHandler,
  })  : _sorter = sorter,
        super(initialData: ProgressData(), provider: provider);

  void addWord(Word word) {
    state = state.copyWith(todayChoosen: {...state.todayChoosen, word});
    provider.save(state);
    try {
      NetworkClient.wordsForChoose.markWordLikeKnown(word.wordID);
    } catch (e) {
      lv6(e.toString());
    }
  }

  List<Word> get getWordsForRepeat {
    final result = _sorter.selectByInterval(state.userStore.toList());
//todo make it empty with today words
//     if (result.isEmpty) {
//       return state.todayChoosen.toList();
//     } else {
    return result;
    // }
  }

  Set<Word> get userStory => state.userStore;
  Set<Word> get todayChoosen => state.todayChoosen;
}
