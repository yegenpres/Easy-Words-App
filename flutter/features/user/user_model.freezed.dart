// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserData {
  String? get id => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  dynamic get isSubscribed => throw _privateConstructorUsedError;
  dynamic get isLogedIn => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserDataCopyWith<UserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataCopyWith<$Res> {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) then) =
      _$UserDataCopyWithImpl<$Res, UserData>;
  @useResult
  $Res call(
      {String? id, String? email, dynamic isSubscribed, dynamic isLogedIn});
}

/// @nodoc
class _$UserDataCopyWithImpl<$Res, $Val extends UserData>
    implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
    Object? isSubscribed = freezed,
    Object? isLogedIn = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      isSubscribed: freezed == isSubscribed
          ? _value.isSubscribed
          : isSubscribed // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isLogedIn: freezed == isLogedIn
          ? _value.isLogedIn
          : isLogedIn // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserDataCopyWith<$Res> implements $UserDataCopyWith<$Res> {
  factory _$$_UserDataCopyWith(
          _$_UserData value, $Res Function(_$_UserData) then) =
      __$$_UserDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id, String? email, dynamic isSubscribed, dynamic isLogedIn});
}

/// @nodoc
class __$$_UserDataCopyWithImpl<$Res>
    extends _$UserDataCopyWithImpl<$Res, _$_UserData>
    implements _$$_UserDataCopyWith<$Res> {
  __$$_UserDataCopyWithImpl(
      _$_UserData _value, $Res Function(_$_UserData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
    Object? isSubscribed = freezed,
    Object? isLogedIn = freezed,
  }) {
    return _then(_$_UserData(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      isSubscribed:
          freezed == isSubscribed ? _value.isSubscribed! : isSubscribed,
      isLogedIn: freezed == isLogedIn ? _value.isLogedIn! : isLogedIn,
    ));
  }
}

/// @nodoc

class _$_UserData implements _UserData {
  _$_UserData(
      {this.id, this.email, this.isSubscribed = false, this.isLogedIn = false});

  @override
  final String? id;
  @override
  final String? email;
  @override
  @JsonKey()
  final dynamic isSubscribed;
  @override
  @JsonKey()
  final dynamic isLogedIn;

  @override
  String toString() {
    return 'UserData(id: $id, email: $email, isSubscribed: $isSubscribed, isLogedIn: $isLogedIn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality()
                .equals(other.isSubscribed, isSubscribed) &&
            const DeepCollectionEquality().equals(other.isLogedIn, isLogedIn));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      const DeepCollectionEquality().hash(isSubscribed),
      const DeepCollectionEquality().hash(isLogedIn));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserDataCopyWith<_$_UserData> get copyWith =>
      __$$_UserDataCopyWithImpl<_$_UserData>(this, _$identity);
}

abstract class _UserData implements UserData {
  factory _UserData(
      {final String? id,
      final String? email,
      final dynamic isSubscribed,
      final dynamic isLogedIn}) = _$_UserData;

  @override
  String? get id;
  @override
  String? get email;
  @override
  dynamic get isSubscribed;
  @override
  dynamic get isLogedIn;
  @override
  @JsonKey(ignore: true)
  _$$_UserDataCopyWith<_$_UserData> get copyWith =>
      throw _privateConstructorUsedError;
}
