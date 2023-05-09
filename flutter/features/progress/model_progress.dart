import 'package:wordsapp/architect/abstract/abstracts.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordsapp/features/word/word.dart';

part 'model_progress.freezed.dart';

@freezed
class ProgressData extends DataClass<ProgressData> with _$ProgressData {
  factory ProgressData({
    @Default({}) Set<Word> userStore,
    @Default({}) Set<Word> todayChoosen,
  }) = _ProgressData;
}
