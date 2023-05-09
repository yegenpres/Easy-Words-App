// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProgressData {
  Set<Word> get userStore => throw _privateConstructorUsedError;
  Set<Word> get todayChoosen => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProgressDataCopyWith<ProgressData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressDataCopyWith<$Res> {
  factory $ProgressDataCopyWith(
          ProgressData value, $Res Function(ProgressData) then) =
      _$ProgressDataCopyWithImpl<$Res, ProgressData>;
  @useResult
  $Res call({Set<Word> userStore, Set<Word> todayChoosen});
}

/// @nodoc
class _$ProgressDataCopyWithImpl<$Res, $Val extends ProgressData>
    implements $ProgressDataCopyWith<$Res> {
  _$ProgressDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userStore = null,
    Object? todayChoosen = null,
  }) {
    return _then(_value.copyWith(
      userStore: null == userStore
          ? _value.userStore
          : userStore // ignore: cast_nullable_to_non_nullable
              as Set<Word>,
      todayChoosen: null == todayChoosen
          ? _value.todayChoosen
          : todayChoosen // ignore: cast_nullable_to_non_nullable
              as Set<Word>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProgressDataCopyWith<$Res>
    implements $ProgressDataCopyWith<$Res> {
  factory _$$_ProgressDataCopyWith(
          _$_ProgressData value, $Res Function(_$_ProgressData) then) =
      __$$_ProgressDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Set<Word> userStore, Set<Word> todayChoosen});
}

/// @nodoc
class __$$_ProgressDataCopyWithImpl<$Res>
    extends _$ProgressDataCopyWithImpl<$Res, _$_ProgressData>
    implements _$$_ProgressDataCopyWith<$Res> {
  __$$_ProgressDataCopyWithImpl(
      _$_ProgressData _value, $Res Function(_$_ProgressData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userStore = null,
    Object? todayChoosen = null,
  }) {
    return _then(_$_ProgressData(
      userStore: null == userStore
          ? _value._userStore
          : userStore // ignore: cast_nullable_to_non_nullable
              as Set<Word>,
      todayChoosen: null == todayChoosen
          ? _value._todayChoosen
          : todayChoosen // ignore: cast_nullable_to_non_nullable
              as Set<Word>,
    ));
  }
}

/// @nodoc

class _$_ProgressData implements _ProgressData {
  _$_ProgressData(
      {final Set<Word> userStore = const {},
      final Set<Word> todayChoosen = const {}})
      : _userStore = userStore,
        _todayChoosen = todayChoosen;

  final Set<Word> _userStore;
  @override
  @JsonKey()
  Set<Word> get userStore {
    if (_userStore is EqualUnmodifiableSetView) return _userStore;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_userStore);
  }

  final Set<Word> _todayChoosen;
  @override
  @JsonKey()
  Set<Word> get todayChoosen {
    if (_todayChoosen is EqualUnmodifiableSetView) return _todayChoosen;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_todayChoosen);
  }

  @override
  String toString() {
    return 'ProgressData(userStore: $userStore, todayChoosen: $todayChoosen)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProgressData &&
            const DeepCollectionEquality()
                .equals(other._userStore, _userStore) &&
            const DeepCollectionEquality()
                .equals(other._todayChoosen, _todayChoosen));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_userStore),
      const DeepCollectionEquality().hash(_todayChoosen));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProgressDataCopyWith<_$_ProgressData> get copyWith =>
      __$$_ProgressDataCopyWithImpl<_$_ProgressData>(this, _$identity);
}

abstract class _ProgressData implements ProgressData {
  factory _ProgressData(
      {final Set<Word> userStore,
      final Set<Word> todayChoosen}) = _$_ProgressData;

  @override
  Set<Word> get userStore;
  @override
  Set<Word> get todayChoosen;
  @override
  @JsonKey(ignore: true)
  _$$_ProgressDataCopyWith<_$_ProgressData> get copyWith =>
      throw _privateConstructorUsedError;
}
