import 'package:json_annotation/json_annotation.dart';
import 'package:wordsapp/architect/interfaces/interfaces.dart';

part 'empty_word.g.dart';

@JsonSerializable()
class EmptyWord implements Wordable {
  static _toStringJson(json) => json.toString();

  @override
  @JsonKey(name: 'wordID', fromJson: _toStringJson)
  final String wordID;

  @override
  @JsonKey(name: 'English', fromJson: _toStringJson)
  final String english;

  @override
  @JsonKey(name: 'RUtranslate', fromJson: _toStringJson)
  final String ruTranslate;

  @override
  @JsonKey(name: 'EngTranscription', fromJson: _toStringJson)
  final String engTranscription;

  @override
  @JsonKey(name: 'RuTranscription', fromJson: _toStringJson)
  final String ruTranscription;

  EmptyWord(
    this.wordID,
    this.english,
    this.ruTranslate,
    this.engTranscription,
    this.ruTranscription,
  );

  factory EmptyWord.fromJson(Map<String, dynamic> json) =>
      _$EmptyWordFromJson(json);

  Map<String, dynamic> toJson() => _$EmptyWordToJson(this);

  @override
  String toString() => '$english($wordID)';
}
