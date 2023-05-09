import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordsapp/architect/abstract/abstracts.dart';

@immutable
abstract class DataProvider<T extends DataClass<T>> {
  dynamic fetch();
  void save(T object);
}

abstract class Wordable {
  static _toStringJson(json) => json.toString();

  @JsonKey(name: 'wordID', fromJson: _toStringJson)
  final String wordID;

  @JsonKey(name: 'English', fromJson: _toStringJson)
  final String english;

  @JsonKey(name: 'RUtranslate', fromJson: _toStringJson)
  final String ruTranslate;

  @JsonKey(name: 'EngTranscription', fromJson: _toStringJson)
  final String engTranscription;

  @JsonKey(name: 'RuTranscription', fromJson: _toStringJson)
  final String ruTranscription;

  Wordable(
    this.wordID,
    this.english,
    this.ruTranslate,
    this.engTranscription,
    this.ruTranscription,
  );
}

abstract class ImagedWordable extends Wordable {
  @JsonKey(name: 'IsImaged')
  final bool isImaged;

  Future<Uint8List?> fetchImage();

  ImagedWordable(
    this.isImaged,
    super.wordID,
    super.english,
    super.ruTranslate,
    super.engTranscription,
    super.ruTranscription,
  );
}

@immutable
abstract class DataProviderSync<T extends DataClass<T>>
    extends DataProvider<T> {
  @override
  T fetch();

  @override
  save(T object);
}

@immutable
abstract class DataProviderAsync<T extends DataClass<T>>
    extends DataProvider<T> {
  @override
  Future<T> fetch();

  @override
  Future save(T object);
}

abstract class ImageFetch {
  Future<Uint8List?> fetchImage(ImagedWordable word);
}

typedef FetchImage = Future<Uint8List?> Function(ImagedWordable);

abstract class FetchableWordsProviderAsync<T extends DataClass<T>>
    extends DataProviderAsync<T> implements ImageFetch {}

abstract class FetchableWordsProviderSync<T extends DataClass<T>>
    extends DataProviderSync<T> implements ImageFetch {}
