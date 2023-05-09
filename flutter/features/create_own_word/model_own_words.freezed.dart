// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_own_words.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ModelOwnWords {
  Set<String> get wordsParts => throw _privateConstructorUsedError;
  Set<EmptyWord> get emptyWords => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModelOwnWordsCopyWith<ModelOwnWords> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelOwnWordsCopyWith<$Res> {
  factory $ModelOwnWordsCopyWith(
          ModelOwnWords value, $Res Function(ModelOwnWords) then) =
      _$ModelOwnWordsCopyWithImpl<$Res, ModelOwnWords>;
  @useResult
  $Res call({Set<String> wordsParts, Set<EmptyWord> emptyWords});
}

/// @nodoc
class _$ModelOwnWordsCopyWithImpl<$Res, $Val extends ModelOwnWords>
    implements $ModelOwnWordsCopyWith<$Res> {
  _$ModelOwnWordsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordsParts = null,
    Object? emptyWords = null,
  }) {
    return _then(_value.copyWith(
      wordsParts: null == wordsParts
          ? _value.wordsParts
          : wordsParts // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      emptyWords: null == emptyWords
          ? _value.emptyWords
          : emptyWords // ignore: cast_nullable_to_non_nullable
              as Set<EmptyWord>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ModelOwnWordsCopyWith<$Res>
    implements $ModelOwnWordsCopyWith<$Res> {
  factory _$$_ModelOwnWordsCopyWith(
          _$_ModelOwnWords value, $Res Function(_$_ModelOwnWords) then) =
      __$$_ModelOwnWordsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Set<String> wordsParts, Set<EmptyWord> emptyWords});
}

/// @nodoc
class __$$_ModelOwnWordsCopyWithImpl<$Res>
    extends _$ModelOwnWordsCopyWithImpl<$Res, _$_ModelOwnWords>
    implements _$$_ModelOwnWordsCopyWith<$Res> {
  __$$_ModelOwnWordsCopyWithImpl(
      _$_ModelOwnWords _value, $Res Function(_$_ModelOwnWords) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordsParts = null,
    Object? emptyWords = null,
  }) {
    return _then(_$_ModelOwnWords(
      wordsParts: null == wordsParts
          ? _value._wordsParts
          : wordsParts // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      emptyWords: null == emptyWords
          ? _value._emptyWords
          : emptyWords // ignore: cast_nullable_to_non_nullable
              as Set<EmptyWord>,
    ));
  }
}

/// @nodoc

class _$_ModelOwnWords implements _ModelOwnWords {
  _$_ModelOwnWords(
      {final Set<String> wordsParts = const {"initialData"},
      final Set<EmptyWord> emptyWords = const {}})
      : _wordsParts = wordsParts,
        _emptyWords = emptyWords;

  final Set<String> _wordsParts;
  @override
  @JsonKey()
  Set<String> get wordsParts {
    if (_wordsParts is EqualUnmodifiableSetView) return _wordsParts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_wordsParts);
  }

  final Set<EmptyWord> _emptyWords;
  @override
  @JsonKey()
  Set<EmptyWord> get emptyWords {
    if (_emptyWords is EqualUnmodifiableSetView) return _emptyWords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_emptyWords);
  }

  @override
  String toString() {
    return 'ModelOwnWords(wordsParts: $wordsParts, emptyWords: $emptyWords)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ModelOwnWords &&
            const DeepCollectionEquality()
                .equals(other._wordsParts, _wordsParts) &&
            const DeepCollectionEquality()
                .equals(other._emptyWords, _emptyWords));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_wordsParts),
      const DeepCollectionEquality().hash(_emptyWords));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ModelOwnWordsCopyWith<_$_ModelOwnWords> get copyWith =>
      __$$_ModelOwnWordsCopyWithImpl<_$_ModelOwnWords>(this, _$identity);
}

abstract class _ModelOwnWords implements ModelOwnWords {
  factory _ModelOwnWords(
      {final Set<String> wordsParts,
      final Set<EmptyWord> emptyWords}) = _$_ModelOwnWords;

  @override
  Set<String> get wordsParts;
  @override
  Set<EmptyWord> get emptyWords;
  @override
  @JsonKey(ignore: true)
  _$$_ModelOwnWordsCopyWith<_$_ModelOwnWords> get copyWith =>
      throw _privateConstructorUsedError;
}
