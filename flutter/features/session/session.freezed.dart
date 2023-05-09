// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SessionData {
  String? get theLastUpdate => throw _privateConstructorUsedError;
  bool get isRepeated => throw _privateConstructorUsedError;
  bool get timeToGetNewWords => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SessionDataCopyWith<SessionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionDataCopyWith<$Res> {
  factory $SessionDataCopyWith(
          SessionData value, $Res Function(SessionData) then) =
      _$SessionDataCopyWithImpl<$Res, SessionData>;
  @useResult
  $Res call({String? theLastUpdate, bool isRepeated, bool timeToGetNewWords});
}

/// @nodoc
class _$SessionDataCopyWithImpl<$Res, $Val extends SessionData>
    implements $SessionDataCopyWith<$Res> {
  _$SessionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theLastUpdate = freezed,
    Object? isRepeated = null,
    Object? timeToGetNewWords = null,
  }) {
    return _then(_value.copyWith(
      theLastUpdate: freezed == theLastUpdate
          ? _value.theLastUpdate
          : theLastUpdate // ignore: cast_nullable_to_non_nullable
              as String?,
      isRepeated: null == isRepeated
          ? _value.isRepeated
          : isRepeated // ignore: cast_nullable_to_non_nullable
              as bool,
      timeToGetNewWords: null == timeToGetNewWords
          ? _value.timeToGetNewWords
          : timeToGetNewWords // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SessionDataCopyWith<$Res>
    implements $SessionDataCopyWith<$Res> {
  factory _$$_SessionDataCopyWith(
          _$_SessionData value, $Res Function(_$_SessionData) then) =
      __$$_SessionDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? theLastUpdate, bool isRepeated, bool timeToGetNewWords});
}

/// @nodoc
class __$$_SessionDataCopyWithImpl<$Res>
    extends _$SessionDataCopyWithImpl<$Res, _$_SessionData>
    implements _$$_SessionDataCopyWith<$Res> {
  __$$_SessionDataCopyWithImpl(
      _$_SessionData _value, $Res Function(_$_SessionData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theLastUpdate = freezed,
    Object? isRepeated = null,
    Object? timeToGetNewWords = null,
  }) {
    return _then(_$_SessionData(
      theLastUpdate: freezed == theLastUpdate
          ? _value.theLastUpdate
          : theLastUpdate // ignore: cast_nullable_to_non_nullable
              as String?,
      isRepeated: null == isRepeated
          ? _value.isRepeated
          : isRepeated // ignore: cast_nullable_to_non_nullable
              as bool,
      timeToGetNewWords: null == timeToGetNewWords
          ? _value.timeToGetNewWords
          : timeToGetNewWords // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_SessionData implements _SessionData {
  _$_SessionData(
      {this.theLastUpdate,
      this.isRepeated = false,
      this.timeToGetNewWords = false});

  @override
  final String? theLastUpdate;
  @override
  @JsonKey()
  final bool isRepeated;
  @override
  @JsonKey()
  final bool timeToGetNewWords;

  @override
  String toString() {
    return 'SessionData(theLastUpdate: $theLastUpdate, isRepeated: $isRepeated, timeToGetNewWords: $timeToGetNewWords)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionData &&
            (identical(other.theLastUpdate, theLastUpdate) ||
                other.theLastUpdate == theLastUpdate) &&
            (identical(other.isRepeated, isRepeated) ||
                other.isRepeated == isRepeated) &&
            (identical(other.timeToGetNewWords, timeToGetNewWords) ||
                other.timeToGetNewWords == timeToGetNewWords));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, theLastUpdate, isRepeated, timeToGetNewWords);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionDataCopyWith<_$_SessionData> get copyWith =>
      __$$_SessionDataCopyWithImpl<_$_SessionData>(this, _$identity);
}

abstract class _SessionData implements SessionData {
  factory _SessionData(
      {final String? theLastUpdate,
      final bool isRepeated,
      final bool timeToGetNewWords}) = _$_SessionData;

  @override
  String? get theLastUpdate;
  @override
  bool get isRepeated;
  @override
  bool get timeToGetNewWords;
  @override
  @JsonKey(ignore: true)
  _$$_SessionDataCopyWith<_$_SessionData> get copyWith =>
      throw _privateConstructorUsedError;
}
