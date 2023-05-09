import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:wordsapp/architect/abstract/abstracts.dart';

part 'session.freezed.dart';

@freezed
class SessionData extends DataClass<SessionData> with _$SessionData {
  factory SessionData({
    String? theLastUpdate,
    @Default(false) bool isRepeated,
    @Default(false) bool timeToGetNewWords,
  }) = _SessionData;
}
