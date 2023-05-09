import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordsapp/features/progress/model_progress.dart';
import 'package:wordsapp/features/progress/progress_controller.dart';
import 'package:wordsapp/features/word/word.dart';

part 'new_words_state.freezed.dart';

@freezed
class NewWordsState with _$NewWordsState {
  const factory NewWordsState.empty() = _StateEmpty;
  const factory NewWordsState.choosenWords(Set<Word> words) =
      _StateChoosenWords;
}

final newWordsAutoAction = Provider<NewWordsState>((ref) {
  final words = ref
      .watch(ProgressController.stateProvider
          .select((ProgressData value) => value.todayChoosen))
      .toList()
      .reversed
      .toSet();

  if (words.isEmpty) {
    return const NewWordsState.empty();
  } else {
    return NewWordsState.choosenWords(words);
  }
});
