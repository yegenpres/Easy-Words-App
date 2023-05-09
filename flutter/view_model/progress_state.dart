import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordsapp/features/progress/progress_controller.dart';
import 'package:wordsapp/features/search/search_controller.dart';
import 'package:wordsapp/features/word/word.dart';
import "package:collection/collection.dart";

part 'progress_state.freezed.dart';

@freezed
class ProgressState with _$ProgressState {
  const factory ProgressState.userProgress(
    Map<String, List<Word>> groupsWords,
    List<String> titles,
  ) = _ProgressState;
  const factory ProgressState.foundedWords(
    Set<Word> searchedWords,
  ) = _SearchState;
}

final progressAutoAction = Provider<ProgressState>(((ref) {
  final Map<String, List<Word>> groupsWords = groupBy(
      ref.watch(ProgressController.stateProvider).userStore.toList().reversed,
      (Word word) => groupWordsBy(GroupBy.date)(word));
  final titles = groupsWords.keys.toList();
  final searchedWords = ref.watch(Search.provider).result;

  if (searchedWords.isNotEmpty) {
    return ProgressState.foundedWords(searchedWords);
  }

  assert(groupsWords.length == titles.length,
      'Something happend with words parser, parameter of pars and groups length is not equal');

  return ProgressState.userProgress(groupsWords, titles);
}));

enum GroupBy { date, az, za, translateAz, translateZa }

String Function(Word) groupWordsBy(GroupBy selector) {
  switch (selector) {
    case GroupBy.date:
      return (Word word) => word.date;
    case GroupBy.az:
      return (Word word) => word.english;
    case GroupBy.za:
      return (Word word) => word.english;
    case GroupBy.translateAz:
      return (Word word) => word.ruTranslate;
    case GroupBy.translateZa:
      return (Word word) => word.ruTranslate;
  }
}
