import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordsapp/config.dart';
import 'package:wordsapp/features/homescreen_widget/homescreen_widget_provider.dart';
import 'package:wordsapp/features/progress/progress_controller.dart';
import 'package:wordsapp/features/session/session.dart';
import 'package:wordsapp/features/session/session_controller.dart';
import 'package:wordsapp/features/word/word.dart';

part 'today_state.freezed.dart';

@freezed
class TodayState with _$TodayState {
  const factory TodayState.chooseNewWords(
      {required bool allWordsChosen,
      required Set<Word> chosenWords}) = ChooseNewWords;
  factory TodayState.wordsForRepeat(
      {required Set<Word> words,
      required bool isNewAvailable,
      required void Function() onRepeatCallBack}) = WordsForRepeat;
}

final todayAutoAction = Provider<TodayState>(((ref) {
  bool isRepeated = ref.watch(SessionController.stateProvider
      .select((SessionData session) => session.isRepeated));
  final wordsForRepeat = ref.watch(ProgressController.stateProvider.notifier
      .select((progressController) => progressController.getWordsForRepeat));
  final todayChoosen = ref.watch(ProgressController.stateProvider
      .select((progressController) => progressController.todayChoosen));

  if (todayChoosen.length >= countDailyWords) {
    HomeScreenWidgetProvider.save(todayChoosen.toList());
  }

  if (todayChoosen.length >= countDailyWords && !isRepeated) {
    return TodayState.wordsForRepeat(
        isNewAvailable: false, words: todayChoosen, onRepeatCallBack: () {});
  }

  if (isRepeated || wordsForRepeat.isEmpty) {
    return TodayState.chooseNewWords(
        allWordsChosen: todayChoosen.length >= countDailyWords ? true : false,
        chosenWords: todayChoosen);
  }

  final onRepeatedCallback =
      ref.read(SessionController.stateProvider.notifier).wordsRepeated;

  return TodayState.wordsForRepeat(
    isNewAvailable: true,
    words: wordsForRepeat.toSet(),
    onRepeatCallBack: onRepeatedCallback,
  );
}));
