import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordsapp/features/progress/progress_controller.dart';
import 'package:wordsapp/features/word/word.dart';
import 'package:wordsapp/features/words_for_choose/controller_words_for_choose.dart';

part 'available_today_for_choose_state.freezed.dart';

@freezed
class AvailableTodayForChooseState with _$AvailableTodayForChooseState {
  const factory AvailableTodayForChooseState.empty() =
      _AvailableTodayForChooseStateEmpty;
  const factory AvailableTodayForChooseState.loaded(Set<Word> words) =
      _AvailableTodayForChooseStateLoaded;
}

final forChooseAytoAction = Provider<AvailableTodayForChooseState>(((ref) {
  final words = ref.watch(WordsForChooseController.stateProvider).words;

  if (words.isEmpty) {
    return const AvailableTodayForChooseState.empty();
  } else {
    return AvailableTodayForChooseState.loaded(words);
  }
}));
final forChooseUserAction = Provider<void Function(Word)>(
  (ref) {
    ref.watch(WordsForChooseController.stateProvider).words.length;

    void addWord(Word word) {
      ref.watch(ProgressController.stateProvider.notifier).addWord(word);
      ref.watch(WordsForChooseController.stateProvider.notifier).remove(word);
    }

    return addWord;
  },
);
