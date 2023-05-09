// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordAdapter extends TypeAdapter<Word> {
  @override
  final int typeId = 1;

  @override
  Word read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Word(
      wordID: fields[0] as String,
      english: fields[1] as String,
      ruTranslate: fields[2] as String,
      engTranscription: fields[3] as String,
      assotiation: fields[4] as String,
      ruTranscription: fields[8] as String,
      isImaged: fields[9] as bool,
      date: fields[6] as dynamic,
      forRepeat: fields[7] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Word obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.wordID)
      ..writeByte(1)
      ..write(obj.english)
      ..writeByte(2)
      ..write(obj.ruTranslate)
      ..writeByte(3)
      ..write(obj.engTranscription)
      ..writeByte(4)
      ..write(obj.assotiation)
      ..writeByte(6)
      ..write(obj.date)
      ..writeByte(7)
      ..write(obj.forRepeat)
      ..writeByte(8)
      ..write(obj.ruTranscription)
      ..writeByte(9)
      ..write(obj.isImaged);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      wordID: Word._toStringJson(json['wordID']),
      english: Word._toStringJson(json['English']),
      ruTranslate: Word._toStringJson(json['RUtranslate']),
      engTranscription: Word._toStringJson(json['EngTranscription']),
      assotiation: Word._toStringJson(json['Assotiation']),
      ruTranscription: Word._toStringJson(json['RuTranscription']),
      isImaged: json['IsImaged'] as bool,
      date: json['date'],
      forRepeat: json['forRepeat'],
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'wordID': instance.wordID,
      'English': instance.english,
      'RUtranslate': instance.ruTranslate,
      'EngTranscription': instance.engTranscription,
      'Assotiation': instance.assotiation,
      'date': instance.date,
      'forRepeat': instance.forRepeat,
      'RuTranscription': instance.ruTranscription,
      'IsImaged': instance.isImaged,
    };
