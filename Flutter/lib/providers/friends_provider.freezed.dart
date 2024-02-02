// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friends_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FriendForView {
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get authorProfileUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FriendForViewCopyWith<FriendForView> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendForViewCopyWith<$Res> {
  factory $FriendForViewCopyWith(
          FriendForView value, $Res Function(FriendForView) then) =
      _$FriendForViewCopyWithImpl<$Res, FriendForView>;
  @useResult
  $Res call({String userId, String displayName, String? authorProfileUrl});
}

/// @nodoc
class _$FriendForViewCopyWithImpl<$Res, $Val extends FriendForView>
    implements $FriendForViewCopyWith<$Res> {
  _$FriendForViewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? authorProfileUrl = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      authorProfileUrl: freezed == authorProfileUrl
          ? _value.authorProfileUrl
          : authorProfileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendForViewImplCopyWith<$Res>
    implements $FriendForViewCopyWith<$Res> {
  factory _$$FriendForViewImplCopyWith(
          _$FriendForViewImpl value, $Res Function(_$FriendForViewImpl) then) =
      __$$FriendForViewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String displayName, String? authorProfileUrl});
}

/// @nodoc
class __$$FriendForViewImplCopyWithImpl<$Res>
    extends _$FriendForViewCopyWithImpl<$Res, _$FriendForViewImpl>
    implements _$$FriendForViewImplCopyWith<$Res> {
  __$$FriendForViewImplCopyWithImpl(
      _$FriendForViewImpl _value, $Res Function(_$FriendForViewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? authorProfileUrl = freezed,
  }) {
    return _then(_$FriendForViewImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      authorProfileUrl: freezed == authorProfileUrl
          ? _value.authorProfileUrl
          : authorProfileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FriendForViewImpl implements _FriendForView {
  _$FriendForViewImpl(
      {required this.userId, required this.displayName, this.authorProfileUrl});

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String? authorProfileUrl;

  @override
  String toString() {
    return 'FriendForView(userId: $userId, displayName: $displayName, authorProfileUrl: $authorProfileUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendForViewImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.authorProfileUrl, authorProfileUrl) ||
                other.authorProfileUrl == authorProfileUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, displayName, authorProfileUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendForViewImplCopyWith<_$FriendForViewImpl> get copyWith =>
      __$$FriendForViewImplCopyWithImpl<_$FriendForViewImpl>(this, _$identity);
}

abstract class _FriendForView implements FriendForView {
  factory _FriendForView(
      {required final String userId,
      required final String displayName,
      final String? authorProfileUrl}) = _$FriendForViewImpl;

  @override
  String get userId;
  @override
  String get displayName;
  @override
  String? get authorProfileUrl;
  @override
  @JsonKey(ignore: true)
  _$$FriendForViewImplCopyWith<_$FriendForViewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
