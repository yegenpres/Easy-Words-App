import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordsapp/architect/abstract/abstracts.dart';
import 'package:wordsapp/features/create_own_word/empty_word.dart';

part 'model_own_words.freezed.dart';

@freezed
class ModelOwnWords extends DataClass<ModelOwnWords> with _$ModelOwnWords {
  factory ModelOwnWords({
    @Default({"initialData"}) Set<String> wordsParts,
    @Default({}) Set<EmptyWord> emptyWords,
  }) = _ModelOwnWords;
}
