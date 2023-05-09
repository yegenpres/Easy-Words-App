// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empty_word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmptyWord _$EmptyWordFromJson(Map<String, dynamic> json) => EmptyWord(
      EmptyWord._toStringJson(json['wordID']),
      EmptyWord._toStringJson(json['English']),
      EmptyWord._toStringJson(json['RUtranslate']),
      EmptyWord._toStringJson(json['EngTranscription']),
      EmptyWord._toStringJson(json['RuTranscription']),
    );

Map<String, dynamic> _$EmptyWordToJson(EmptyWord instance) => <String, dynamic>{
      'wordID': instance.wordID,
      'English': instance.english,
      'RUtranslate': instance.ruTranslate,
      'EngTranscription': instance.engTranscription,
      'RuTranscription': instance.ruTranscription,
    };
