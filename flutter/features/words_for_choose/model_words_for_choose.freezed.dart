// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_words_for_choose.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WordsForChooseData {
  Set<Word> get words => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WordsForChooseDataCopyWith<WordsForChooseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordsForChooseDataCopyWith<$Res> {
  factory $WordsForChooseDataCopyWith(
          WordsForChooseData value, $Res Function(WordsForChooseData) then) =
      _$WordsForChooseDataCopyWithImpl<$Res, WordsForChooseData>;
  @useResult
  $Res call({Set<Word> words});
}

/// @nodoc
class _$WordsForChooseDataCopyWithImpl<$Res, $Val extends WordsForChooseData>
    implements $WordsForChooseDataCopyWith<$Res> {
  _$WordsForChooseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? words = null,
  }) {
    return _then(_value.copyWith(
      words: null == words
          ? _value.words
          : words // ignore: cast_nullable_to_non_nullable
              as Set<Word>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WordsForChooseDataCopyWith<$Res>
    implements $WordsForChooseDataCopyWith<$Res> {
  factory _$$_WordsForChooseDataCopyWith(_$_WordsForChooseData value,
          $Res Function(_$_WordsForChooseData) then) =
      __$$_WordsForChooseDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Set<Word> words});
}

/// @nodoc
class __$$_WordsForChooseDataCopyWithImpl<$Res>
    extends _$WordsForChooseDataCopyWithImpl<$Res, _$_WordsForChooseData>
    implements _$$_WordsForChooseDataCopyWith<$Res> {
  __$$_WordsForChooseDataCopyWithImpl(
      _$_WordsForChooseData _value, $Res Function(_$_WordsForChooseData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? words = null,
  }) {
    return _then(_$_WordsForChooseData(
      words: null == words
          ? _value._words
          : words // ignore: cast_nullable_to_non_nullable
              as Set<Word>,
    ));
  }
}

/// @nodoc

class _$_WordsForChooseData
    with DiagnosticableTreeMixin
    implements _WordsForChooseData {
  const _$_WordsForChooseData({final Set<Word> words = const {}})
      : _words = words;

  final Set<Word> _words;
  @override
  @JsonKey()
  Set<Word> get words {
    if (_words is EqualUnmodifiableSetView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_words);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WordsForChooseData(words: $words)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WordsForChooseData'))
      ..add(DiagnosticsProperty('words', words));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WordsForChooseData &&
            const DeepCollectionEquality().equals(other._words, _words));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_words));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WordsForChooseDataCopyWith<_$_WordsForChooseData> get copyWith =>
      __$$_WordsForChooseDataCopyWithImpl<_$_WordsForChooseData>(
          this, _$identity);
}

abstract class _WordsForChooseData implements WordsForChooseData {
  const factory _WordsForChooseData({final Set<Word> words}) =
      _$_WordsForChooseData;

  @override
  Set<Word> get words;
  @override
  @JsonKey(ignore: true)
  _$$_WordsForChooseDataCopyWith<_$_WordsForChooseData> get copyWith =>
      throw _privateConstructorUsedError;
}
