import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wordsapp/architect/interfaces/interfaces.dart';

part 'word.g.dart';

//reserved ID 0 1 2 3 4 5 6 7 8 100
@JsonSerializable()
@HiveType(typeId: 1)
class Word implements ImagedWordable {
  static _toStringJson(json) => json.toString();

  @override
  @JsonKey(name: 'wordID', fromJson: _toStringJson)
  @HiveField(0)
  final String wordID;

  @override
  @JsonKey(name: 'English', fromJson: _toStringJson)
  @HiveField(1)
  final String english;

  @override
  @JsonKey(name: 'RUtranslate', fromJson: _toStringJson)
  @HiveField(2)
  final String ruTranslate;

  @override
  @JsonKey(name: 'EngTranscription', fromJson: _toStringJson)
  @HiveField(3)
  final String engTranscription;

  @JsonKey(name: 'Assotiation', fromJson: _toStringJson)
  @HiveField(4)
  final String assotiation;

  @HiveField(6)
  final String date;

  @HiveField(7)
  bool forRepeat;

  @override
  @JsonKey(name: 'RuTranscription', fromJson: _toStringJson)
  @HiveField(8)
  final String ruTranscription;

  @override
  @JsonKey(name: 'IsImaged')
  @HiveField(9)
  final bool isImaged;

  @JsonKey(ignore: true)
  FetchImage? imageProvider;

  Word(
      {required this.wordID,
      required this.english,
      required this.ruTranslate,
      required this.engTranscription,
      required this.assotiation,
      required this.ruTranscription,
      required this.isImaged,
      this.imageProvider,
      date,
      forRepeat})
      : assert(wordID.isNotEmpty,
            "wordID: $wordID is empty thar is involve errors in collections"),
        date = date ?? DateTime.now().toString().split(' ')[0],
        forRepeat = forRepeat ?? false;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  @override
  Future<Uint8List?> fetchImage() async {
    if (isImaged && imageProvider != null) {
      final imageData = await imageProvider!(this);
      if (imageData != null) {
        return imageData;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() => _$WordToJson(this);

  @override
  String toString() => '$english($wordID)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Word &&
          runtimeType == other.runtimeType &&
          wordID == other.wordID;
  @override
  int get hashCode => wordID.hashCode + english.hashCode;
}
