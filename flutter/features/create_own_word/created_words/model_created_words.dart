import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordsapp/architect/abstract/abstracts.dart';
import 'package:wordsapp/features/word/word.dart';

part 'model_created_words.freezed.dart';

@freezed
class CreatedWords extends DataClass<CreatedWords> with _$CreatedWords {
  factory CreatedWords({
    @Default({}) Set<Word> words,
  }) = _CreatedWords;
}
