// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_created_words.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreatedWords {
  Set<Word> get words => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreatedWordsCopyWith<CreatedWords> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatedWordsCopyWith<$Res> {
  factory $CreatedWordsCopyWith(
          CreatedWords value, $Res Function(CreatedWords) then) =
      _$CreatedWordsCopyWithImpl<$Res, CreatedWords>;
  @useResult
  $Res call({Set<Word> words});
}

/// @nodoc
class _$CreatedWordsCopyWithImpl<$Res, $Val extends CreatedWords>
    implements $CreatedWordsCopyWith<$Res> {
  _$CreatedWordsCopyWithImpl(this._value, this._then);

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
abstract class _$$_CreatedWordsCopyWith<$Res>
    implements $CreatedWordsCopyWith<$Res> {
  factory _$$_CreatedWordsCopyWith(
          _$_CreatedWords value, $Res Function(_$_CreatedWords) then) =
      __$$_CreatedWordsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Set<Word> words});
}

/// @nodoc
class __$$_CreatedWordsCopyWithImpl<$Res>
    extends _$CreatedWordsCopyWithImpl<$Res, _$_CreatedWords>
    implements _$$_CreatedWordsCopyWith<$Res> {
  __$$_CreatedWordsCopyWithImpl(
      _$_CreatedWords _value, $Res Function(_$_CreatedWords) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? words = null,
  }) {
    return _then(_$_CreatedWords(
      words: null == words
          ? _value._words
          : words // ignore: cast_nullable_to_non_nullable
              as Set<Word>,
    ));
  }
}

/// @nodoc

class _$_CreatedWords implements _CreatedWords {
  _$_CreatedWords({final Set<Word> words = const {}}) : _words = words;

  final Set<Word> _words;
  @override
  @JsonKey()
  Set<Word> get words {
    if (_words is EqualUnmodifiableSetView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_words);
  }

  @override
  String toString() {
    return 'CreatedWords(words: $words)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreatedWords &&
            const DeepCollectionEquality().equals(other._words, _words));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_words));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreatedWordsCopyWith<_$_CreatedWords> get copyWith =>
      __$$_CreatedWordsCopyWithImpl<_$_CreatedWords>(this, _$identity);
}

abstract class _CreatedWords implements CreatedWords {
  factory _CreatedWords({final Set<Word> words}) = _$_CreatedWords;

  @override
  Set<Word> get words;
  @override
  @JsonKey(ignore: true)
  _$$_CreatedWordsCopyWith<_$_CreatedWords> get copyWith =>
      throw _privateConstructorUsedError;
}
