// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lobby_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LobbyModel _$LobbyModelFromJson(Map<String, dynamic> json) {
  return _LobbyModel.fromJson(json);
}

/// @nodoc
mixin _$LobbyModel {
  GameType get gameType => throw _privateConstructorUsedError;
  String get lobbyCode => throw _privateConstructorUsedError;
  List<User> get players => throw _privateConstructorUsedError;
  GameStatus get gameStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LobbyModelCopyWith<LobbyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LobbyModelCopyWith<$Res> {
  factory $LobbyModelCopyWith(
          LobbyModel value, $Res Function(LobbyModel) then) =
      _$LobbyModelCopyWithImpl<$Res, LobbyModel>;
  @useResult
  $Res call(
      {GameType gameType,
      String lobbyCode,
      List<User> players,
      GameStatus gameStatus});
}

/// @nodoc
class _$LobbyModelCopyWithImpl<$Res, $Val extends LobbyModel>
    implements $LobbyModelCopyWith<$Res> {
  _$LobbyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameType = null,
    Object? lobbyCode = null,
    Object? players = null,
    Object? gameStatus = null,
  }) {
    return _then(_value.copyWith(
      gameType: null == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as GameType,
      lobbyCode: null == lobbyCode
          ? _value.lobbyCode
          : lobbyCode // ignore: cast_nullable_to_non_nullable
              as String,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<User>,
      gameStatus: null == gameStatus
          ? _value.gameStatus
          : gameStatus // ignore: cast_nullable_to_non_nullable
              as GameStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LobbyModelImplCopyWith<$Res>
    implements $LobbyModelCopyWith<$Res> {
  factory _$$LobbyModelImplCopyWith(
          _$LobbyModelImpl value, $Res Function(_$LobbyModelImpl) then) =
      __$$LobbyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GameType gameType,
      String lobbyCode,
      List<User> players,
      GameStatus gameStatus});
}

/// @nodoc
class __$$LobbyModelImplCopyWithImpl<$Res>
    extends _$LobbyModelCopyWithImpl<$Res, _$LobbyModelImpl>
    implements _$$LobbyModelImplCopyWith<$Res> {
  __$$LobbyModelImplCopyWithImpl(
      _$LobbyModelImpl _value, $Res Function(_$LobbyModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameType = null,
    Object? lobbyCode = null,
    Object? players = null,
    Object? gameStatus = null,
  }) {
    return _then(_$LobbyModelImpl(
      gameType: null == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as GameType,
      lobbyCode: null == lobbyCode
          ? _value.lobbyCode
          : lobbyCode // ignore: cast_nullable_to_non_nullable
              as String,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<User>,
      gameStatus: null == gameStatus
          ? _value.gameStatus
          : gameStatus // ignore: cast_nullable_to_non_nullable
              as GameStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LobbyModelImpl extends _LobbyModel {
  _$LobbyModelImpl(
      {required this.gameType,
      required this.lobbyCode,
      required final List<User> players,
      required this.gameStatus})
      : _players = players,
        super._();

  factory _$LobbyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LobbyModelImplFromJson(json);

  @override
  final GameType gameType;
  @override
  final String lobbyCode;
  final List<User> _players;
  @override
  List<User> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  final GameStatus gameStatus;

  @override
  String toString() {
    return 'LobbyModel(gameType: $gameType, lobbyCode: $lobbyCode, players: $players, gameStatus: $gameStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LobbyModelImpl &&
            (identical(other.gameType, gameType) ||
                other.gameType == gameType) &&
            (identical(other.lobbyCode, lobbyCode) ||
                other.lobbyCode == lobbyCode) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            (identical(other.gameStatus, gameStatus) ||
                other.gameStatus == gameStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, gameType, lobbyCode,
      const DeepCollectionEquality().hash(_players), gameStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LobbyModelImplCopyWith<_$LobbyModelImpl> get copyWith =>
      __$$LobbyModelImplCopyWithImpl<_$LobbyModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LobbyModelImplToJson(
      this,
    );
  }
}

abstract class _LobbyModel extends LobbyModel {
  factory _LobbyModel(
      {required final GameType gameType,
      required final String lobbyCode,
      required final List<User> players,
      required final GameStatus gameStatus}) = _$LobbyModelImpl;
  _LobbyModel._() : super._();

  factory _LobbyModel.fromJson(Map<String, dynamic> json) =
      _$LobbyModelImpl.fromJson;

  @override
  GameType get gameType;
  @override
  String get lobbyCode;
  @override
  List<User> get players;
  @override
  GameStatus get gameStatus;
  @override
  @JsonKey(ignore: true)
  _$$LobbyModelImplCopyWith<_$LobbyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
