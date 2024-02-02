// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_hub_connection_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatMessageForView {
  String get message => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String? get authorProfileUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatMessageForViewCopyWith<ChatMessageForView> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageForViewCopyWith<$Res> {
  factory $ChatMessageForViewCopyWith(
          ChatMessageForView value, $Res Function(ChatMessageForView) then) =
      _$ChatMessageForViewCopyWithImpl<$Res, ChatMessageForView>;
  @useResult
  $Res call(
      {String message,
      String authorName,
      String authorId,
      String? authorProfileUrl});
}

/// @nodoc
class _$ChatMessageForViewCopyWithImpl<$Res, $Val extends ChatMessageForView>
    implements $ChatMessageForViewCopyWith<$Res> {
  _$ChatMessageForViewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? authorName = null,
    Object? authorId = null,
    Object? authorProfileUrl = freezed,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorProfileUrl: freezed == authorProfileUrl
          ? _value.authorProfileUrl
          : authorProfileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatMessageForViewImplCopyWith<$Res>
    implements $ChatMessageForViewCopyWith<$Res> {
  factory _$$ChatMessageForViewImplCopyWith(_$ChatMessageForViewImpl value,
          $Res Function(_$ChatMessageForViewImpl) then) =
      __$$ChatMessageForViewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message,
      String authorName,
      String authorId,
      String? authorProfileUrl});
}

/// @nodoc
class __$$ChatMessageForViewImplCopyWithImpl<$Res>
    extends _$ChatMessageForViewCopyWithImpl<$Res, _$ChatMessageForViewImpl>
    implements _$$ChatMessageForViewImplCopyWith<$Res> {
  __$$ChatMessageForViewImplCopyWithImpl(_$ChatMessageForViewImpl _value,
      $Res Function(_$ChatMessageForViewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? authorName = null,
    Object? authorId = null,
    Object? authorProfileUrl = freezed,
  }) {
    return _then(_$ChatMessageForViewImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorProfileUrl: freezed == authorProfileUrl
          ? _value.authorProfileUrl
          : authorProfileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ChatMessageForViewImpl implements _ChatMessageForView {
  _$ChatMessageForViewImpl(
      {required this.message,
      required this.authorName,
      required this.authorId,
      this.authorProfileUrl});

  @override
  final String message;
  @override
  final String authorName;
  @override
  final String authorId;
  @override
  final String? authorProfileUrl;

  @override
  String toString() {
    return 'ChatMessageForView(message: $message, authorName: $authorName, authorId: $authorId, authorProfileUrl: $authorProfileUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageForViewImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorProfileUrl, authorProfileUrl) ||
                other.authorProfileUrl == authorProfileUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, authorName, authorId, authorProfileUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageForViewImplCopyWith<_$ChatMessageForViewImpl> get copyWith =>
      __$$ChatMessageForViewImplCopyWithImpl<_$ChatMessageForViewImpl>(
          this, _$identity);
}

abstract class _ChatMessageForView implements ChatMessageForView {
  factory _ChatMessageForView(
      {required final String message,
      required final String authorName,
      required final String authorId,
      final String? authorProfileUrl}) = _$ChatMessageForViewImpl;

  @override
  String get message;
  @override
  String get authorName;
  @override
  String get authorId;
  @override
  String? get authorProfileUrl;
  @override
  @JsonKey(ignore: true)
  _$$ChatMessageForViewImplCopyWith<_$ChatMessageForViewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
