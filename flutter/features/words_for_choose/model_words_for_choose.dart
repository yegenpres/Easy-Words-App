import 'package:flutter/foundation.dart';
import 'package:wordsapp/architect/abstract/abstracts.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordsapp/features/word/word.dart';

part 'model_words_for_choose.freezed.dart';

@freezed
class WordsForChooseData extends DataClass<WordsForChooseData>
    with _$WordsForChooseData {
  const factory WordsForChooseData({
    @Default({}) Set<Word> words,
  }) = _WordsForChooseData;
}
