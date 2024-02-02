// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_invite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameInvite _$GameInviteFromJson(Map<String, dynamic> json) {
  return _GameInvite.fromJson(json);
}

/// @nodoc
mixin _$GameInvite {
  String get inviteId => throw _privateConstructorUsedError;
  User get fromPlayer => throw _privateConstructorUsedError;
  User get toPlayer => throw _privateConstructorUsedError;
  String get lobbyCode => throw _privateConstructorUsedError;
  DateTime get timeStamp => throw _privateConstructorUsedError;
  InviteStatus get status => throw _privateConstructorUsedError;
  GameType get gameType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameInviteCopyWith<GameInvite> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameInviteCopyWith<$Res> {
  factory $GameInviteCopyWith(
          GameInvite value, $Res Function(GameInvite) then) =
      _$GameInviteCopyWithImpl<$Res, GameInvite>;
  @useResult
  $Res call(
      {String inviteId,
      User fromPlayer,
      User toPlayer,
      String lobbyCode,
      DateTime timeStamp,
      InviteStatus status,
      GameType gameType});

  $UserCopyWith<$Res> get fromPlayer;
  $UserCopyWith<$Res> get toPlayer;
}

/// @nodoc
class _$GameInviteCopyWithImpl<$Res, $Val extends GameInvite>
    implements $GameInviteCopyWith<$Res> {
  _$GameInviteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inviteId = null,
    Object? fromPlayer = null,
    Object? toPlayer = null,
    Object? lobbyCode = null,
    Object? timeStamp = null,
    Object? status = null,
    Object? gameType = null,
  }) {
    return _then(_value.copyWith(
      inviteId: null == inviteId
          ? _value.inviteId
          : inviteId // ignore: cast_nullable_to_non_nullable
              as String,
      fromPlayer: null == fromPlayer
          ? _value.fromPlayer
          : fromPlayer // ignore: cast_nullable_to_non_nullable
              as User,
      toPlayer: null == toPlayer
          ? _value.toPlayer
          : toPlayer // ignore: cast_nullable_to_non_nullable
              as User,
      lobbyCode: null == lobbyCode
          ? _value.lobbyCode
          : lobbyCode // ignore: cast_nullable_to_non_nullable
              as String,
      timeStamp: null == timeStamp
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InviteStatus,
      gameType: null == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as GameType,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get fromPlayer {
    return $UserCopyWith<$Res>(_value.fromPlayer, (value) {
      return _then(_value.copyWith(fromPlayer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get toPlayer {
    return $UserCopyWith<$Res>(_value.toPlayer, (value) {
      return _then(_value.copyWith(toPlayer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameInviteImplCopyWith<$Res>
    implements $GameInviteCopyWith<$Res> {
  factory _$$GameInviteImplCopyWith(
          _$GameInviteImpl value, $Res Function(_$GameInviteImpl) then) =
      __$$GameInviteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String inviteId,
      User fromPlayer,
      User toPlayer,
      String lobbyCode,
      DateTime timeStamp,
      InviteStatus status,
      GameType gameType});

  @override
  $UserCopyWith<$Res> get fromPlayer;
  @override
  $UserCopyWith<$Res> get toPlayer;
}

/// @nodoc
class __$$GameInviteImplCopyWithImpl<$Res>
    extends _$GameInviteCopyWithImpl<$Res, _$GameInviteImpl>
    implements _$$GameInviteImplCopyWith<$Res> {
  __$$GameInviteImplCopyWithImpl(
      _$GameInviteImpl _value, $Res Function(_$GameInviteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inviteId = null,
    Object? fromPlayer = null,
    Object? toPlayer = null,
    Object? lobbyCode = null,
    Object? timeStamp = null,
    Object? status = null,
    Object? gameType = null,
  }) {
    return _then(_$GameInviteImpl(
      inviteId: null == inviteId
          ? _value.inviteId
          : inviteId // ignore: cast_nullable_to_non_nullable
              as String,
      fromPlayer: null == fromPlayer
          ? _value.fromPlayer
          : fromPlayer // ignore: cast_nullable_to_non_nullable
              as User,
      toPlayer: null == toPlayer
          ? _value.toPlayer
          : toPlayer // ignore: cast_nullable_to_non_nullable
              as User,
      lobbyCode: null == lobbyCode
          ? _value.lobbyCode
          : lobbyCode // ignore: cast_nullable_to_non_nullable
              as String,
      timeStamp: null == timeStamp
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InviteStatus,
      gameType: null == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as GameType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameInviteImpl extends _GameInvite {
  const _$GameInviteImpl(
      {required this.inviteId,
      required this.fromPlayer,
      required this.toPlayer,
      required this.lobbyCode,
      required this.timeStamp,
      required this.status,
      required this.gameType})
      : super._();

  factory _$GameInviteImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameInviteImplFromJson(json);

  @override
  final String inviteId;
  @override
  final User fromPlayer;
  @override
  final User toPlayer;
  @override
  final String lobbyCode;
  @override
  final DateTime timeStamp;
  @override
  final InviteStatus status;
  @override
  final GameType gameType;

  @override
  String toString() {
    return 'GameInvite(inviteId: $inviteId, fromPlayer: $fromPlayer, toPlayer: $toPlayer, lobbyCode: $lobbyCode, timeStamp: $timeStamp, status: $status, gameType: $gameType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameInviteImpl &&
            (identical(other.inviteId, inviteId) ||
                other.inviteId == inviteId) &&
            (identical(other.fromPlayer, fromPlayer) ||
                other.fromPlayer == fromPlayer) &&
            (identical(other.toPlayer, toPlayer) ||
                other.toPlayer == toPlayer) &&
            (identical(other.lobbyCode, lobbyCode) ||
                other.lobbyCode == lobbyCode) &&
            (identical(other.timeStamp, timeStamp) ||
                other.timeStamp == timeStamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.gameType, gameType) ||
                other.gameType == gameType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, inviteId, fromPlayer, toPlayer,
      lobbyCode, timeStamp, status, gameType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameInviteImplCopyWith<_$GameInviteImpl> get copyWith =>
      __$$GameInviteImplCopyWithImpl<_$GameInviteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameInviteImplToJson(
      this,
    );
  }
}

abstract class _GameInvite extends GameInvite {
  const factory _GameInvite(
      {required final String inviteId,
      required final User fromPlayer,
      required final User toPlayer,
      required final String lobbyCode,
      required final DateTime timeStamp,
      required final InviteStatus status,
      required final GameType gameType}) = _$GameInviteImpl;
  const _GameInvite._() : super._();

  factory _GameInvite.fromJson(Map<String, dynamic> json) =
      _$GameInviteImpl.fromJson;

  @override
  String get inviteId;
  @override
  User get fromPlayer;
  @override
  User get toPlayer;
  @override
  String get lobbyCode;
  @override
  DateTime get timeStamp;
  @override
  InviteStatus get status;
  @override
  GameType get gameType;
  @override
  @JsonKey(ignore: true)
  _$$GameInviteImplCopyWith<_$GameInviteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
