// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gin_rummy_game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GinRummyGameModel _$GinRummyGameModelFromJson(Map<String, dynamic> json) {
  return _GinRummyGameState.fromJson(json);
}

/// @nodoc
mixin _$GinRummyGameModel {
  User? get currentPlayer => throw _privateConstructorUsedError;
  bool get firstPlayerPassed => throw _privateConstructorUsedError;
  bool get isFirstTurn => throw _privateConstructorUsedError;
  bool get isSecondTurn => throw _privateConstructorUsedError;
  bool get bothPass => throw _privateConstructorUsedError;
  List<Card> get drawPile => throw _privateConstructorUsedError;
  List<Card> get discardPile => throw _privateConstructorUsedError;
  Map<String, List<Card>> get playerHands => throw _privateConstructorUsedError;
  Card? get drawnCard => throw _privateConstructorUsedError;
  Map<String, int> get playerScores => throw _privateConstructorUsedError;
  User? get playerKnocking => throw _privateConstructorUsedError;
  User? get playerGinning => throw _privateConstructorUsedError;
  String get lobbyCode => throw _privateConstructorUsedError;
  List<User> get players => throw _privateConstructorUsedError;
  List<User> get playersNotPlaying => throw _privateConstructorUsedError;
  List<User> get playersPlaying => throw _privateConstructorUsedError;
  GameStatus get gameStatus => throw _privateConstructorUsedError;
  User get host => throw _privateConstructorUsedError;
  User? get winner => throw _privateConstructorUsedError;
  User? get roundWinner => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GinRummyGameModelCopyWith<GinRummyGameModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GinRummyGameModelCopyWith<$Res> {
  factory $GinRummyGameModelCopyWith(
          GinRummyGameModel value, $Res Function(GinRummyGameModel) then) =
      _$GinRummyGameModelCopyWithImpl<$Res, GinRummyGameModel>;
  @useResult
  $Res call(
      {User? currentPlayer,
      bool firstPlayerPassed,
      bool isFirstTurn,
      bool isSecondTurn,
      bool bothPass,
      List<Card> drawPile,
      List<Card> discardPile,
      Map<String, List<Card>> playerHands,
      Card? drawnCard,
      Map<String, int> playerScores,
      User? playerKnocking,
      User? playerGinning,
      String lobbyCode,
      List<User> players,
      List<User> playersNotPlaying,
      List<User> playersPlaying,
      GameStatus gameStatus,
      User host,
      User? winner,
      User? roundWinner});

  $UserCopyWith<$Res>? get currentPlayer;
  $CardCopyWith<$Res>? get drawnCard;
  $UserCopyWith<$Res>? get playerKnocking;
  $UserCopyWith<$Res>? get playerGinning;
  $UserCopyWith<$Res> get host;
  $UserCopyWith<$Res>? get winner;
  $UserCopyWith<$Res>? get roundWinner;
}

/// @nodoc
class _$GinRummyGameModelCopyWithImpl<$Res, $Val extends GinRummyGameModel>
    implements $GinRummyGameModelCopyWith<$Res> {
  _$GinRummyGameModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPlayer = freezed,
    Object? firstPlayerPassed = null,
    Object? isFirstTurn = null,
    Object? isSecondTurn = null,
    Object? bothPass = null,
    Object? drawPile = null,
    Object? discardPile = null,
    Object? playerHands = null,
    Object? drawnCard = freezed,
    Object? playerScores = null,
    Object? playerKnocking = freezed,
    Object? playerGinning = freezed,
    Object? lobbyCode = null,
    Object? players = null,
    Object? playersNotPlaying = null,
    Object? playersPlaying = null,
    Object? gameStatus = null,
    Object? host = null,
    Object? winner = freezed,
    Object? roundWinner = freezed,
  }) {
    return _then(_value.copyWith(
      currentPlayer: freezed == currentPlayer
          ? _value.currentPlayer
          : currentPlayer // ignore: cast_nullable_to_non_nullable
              as User?,
      firstPlayerPassed: null == firstPlayerPassed
          ? _value.firstPlayerPassed
          : firstPlayerPassed // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstTurn: null == isFirstTurn
          ? _value.isFirstTurn
          : isFirstTurn // ignore: cast_nullable_to_non_nullable
              as bool,
      isSecondTurn: null == isSecondTurn
          ? _value.isSecondTurn
          : isSecondTurn // ignore: cast_nullable_to_non_nullable
              as bool,
      bothPass: null == bothPass
          ? _value.bothPass
          : bothPass // ignore: cast_nullable_to_non_nullable
              as bool,
      drawPile: null == drawPile
          ? _value.drawPile
          : drawPile // ignore: cast_nullable_to_non_nullable
              as List<Card>,
      discardPile: null == discardPile
          ? _value.discardPile
          : discardPile // ignore: cast_nullable_to_non_nullable
              as List<Card>,
      playerHands: null == playerHands
          ? _value.playerHands
          : playerHands // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Card>>,
      drawnCard: freezed == drawnCard
          ? _value.drawnCard
          : drawnCard // ignore: cast_nullable_to_non_nullable
              as Card?,
      playerScores: null == playerScores
          ? _value.playerScores
          : playerScores // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      playerKnocking: freezed == playerKnocking
          ? _value.playerKnocking
          : playerKnocking // ignore: cast_nullable_to_non_nullable
              as User?,
      playerGinning: freezed == playerGinning
          ? _value.playerGinning
          : playerGinning // ignore: cast_nullable_to_non_nullable
              as User?,
      lobbyCode: null == lobbyCode
          ? _value.lobbyCode
          : lobbyCode // ignore: cast_nullable_to_non_nullable
              as String,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<User>,
      playersNotPlaying: null == playersNotPlaying
          ? _value.playersNotPlaying
          : playersNotPlaying // ignore: cast_nullable_to_non_nullable
              as List<User>,
      playersPlaying: null == playersPlaying
          ? _value.playersPlaying
          : playersPlaying // ignore: cast_nullable_to_non_nullable
              as List<User>,
      gameStatus: null == gameStatus
          ? _value.gameStatus
          : gameStatus // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as User,
      winner: freezed == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as User?,
      roundWinner: freezed == roundWinner
          ? _value.roundWinner
          : roundWinner // ignore: cast_nullable_to_non_nullable
              as User?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get currentPlayer {
    if (_value.currentPlayer == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.currentPlayer!, (value) {
      return _then(_value.copyWith(currentPlayer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CardCopyWith<$Res>? get drawnCard {
    if (_value.drawnCard == null) {
      return null;
    }

    return $CardCopyWith<$Res>(_value.drawnCard!, (value) {
      return _then(_value.copyWith(drawnCard: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get playerKnocking {
    if (_value.playerKnocking == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.playerKnocking!, (value) {
      return _then(_value.copyWith(playerKnocking: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get playerGinning {
    if (_value.playerGinning == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.playerGinning!, (value) {
      return _then(_value.copyWith(playerGinning: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get host {
    return $UserCopyWith<$Res>(_value.host, (value) {
      return _then(_value.copyWith(host: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get winner {
    if (_value.winner == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.winner!, (value) {
      return _then(_value.copyWith(winner: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get roundWinner {
    if (_value.roundWinner == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.roundWinner!, (value) {
      return _then(_value.copyWith(roundWinner: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GinRummyGameStateImplCopyWith<$Res>
    implements $GinRummyGameModelCopyWith<$Res> {
  factory _$$GinRummyGameStateImplCopyWith(_$GinRummyGameStateImpl value,
          $Res Function(_$GinRummyGameStateImpl) then) =
      __$$GinRummyGameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {User? currentPlayer,
      bool firstPlayerPassed,
      bool isFirstTurn,
      bool isSecondTurn,
      bool bothPass,
      List<Card> drawPile,
      List<Card> discardPile,
      Map<String, List<Card>> playerHands,
      Card? drawnCard,
      Map<String, int> playerScores,
      User? playerKnocking,
      User? playerGinning,
      String lobbyCode,
      List<User> players,
      List<User> playersNotPlaying,
      List<User> playersPlaying,
      GameStatus gameStatus,
      User host,
      User? winner,
      User? roundWinner});

  @override
  $UserCopyWith<$Res>? get currentPlayer;
  @override
  $CardCopyWith<$Res>? get drawnCard;
  @override
  $UserCopyWith<$Res>? get playerKnocking;
  @override
  $UserCopyWith<$Res>? get playerGinning;
  @override
  $UserCopyWith<$Res> get host;
  @override
  $UserCopyWith<$Res>? get winner;
  @override
  $UserCopyWith<$Res>? get roundWinner;
}

/// @nodoc
class __$$GinRummyGameStateImplCopyWithImpl<$Res>
    extends _$GinRummyGameModelCopyWithImpl<$Res, _$GinRummyGameStateImpl>
    implements _$$GinRummyGameStateImplCopyWith<$Res> {
  __$$GinRummyGameStateImplCopyWithImpl(_$GinRummyGameStateImpl _value,
      $Res Function(_$GinRummyGameStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPlayer = freezed,
    Object? firstPlayerPassed = null,
    Object? isFirstTurn = null,
    Object? isSecondTurn = null,
    Object? bothPass = null,
    Object? drawPile = null,
    Object? discardPile = null,
    Object? playerHands = null,
    Object? drawnCard = freezed,
    Object? playerScores = null,
    Object? playerKnocking = freezed,
    Object? playerGinning = freezed,
    Object? lobbyCode = null,
    Object? players = null,
    Object? playersNotPlaying = null,
    Object? playersPlaying = null,
    Object? gameStatus = null,
    Object? host = null,
    Object? winner = freezed,
    Object? roundWinner = freezed,
  }) {
    return _then(_$GinRummyGameStateImpl(
      currentPlayer: freezed == currentPlayer
          ? _value.currentPlayer
          : currentPlayer // ignore: cast_nullable_to_non_nullable
              as User?,
      firstPlayerPassed: null == firstPlayerPassed
          ? _value.firstPlayerPassed
          : firstPlayerPassed // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstTurn: null == isFirstTurn
          ? _value.isFirstTurn
          : isFirstTurn // ignore: cast_nullable_to_non_nullable
              as bool,
      isSecondTurn: null == isSecondTurn
          ? _value.isSecondTurn
          : isSecondTurn // ignore: cast_nullable_to_non_nullable
              as bool,
      bothPass: null == bothPass
          ? _value.bothPass
          : bothPass // ignore: cast_nullable_to_non_nullable
              as bool,
      drawPile: null == drawPile
          ? _value._drawPile
          : drawPile // ignore: cast_nullable_to_non_nullable
              as List<Card>,
      discardPile: null == discardPile
          ? _value._discardPile
          : discardPile // ignore: cast_nullable_to_non_nullable
              as List<Card>,
      playerHands: null == playerHands
          ? _value._playerHands
          : playerHands // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Card>>,
      drawnCard: freezed == drawnCard
          ? _value.drawnCard
          : drawnCard // ignore: cast_nullable_to_non_nullable
              as Card?,
      playerScores: null == playerScores
          ? _value._playerScores
          : playerScores // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      playerKnocking: freezed == playerKnocking
          ? _value.playerKnocking
          : playerKnocking // ignore: cast_nullable_to_non_nullable
              as User?,
      playerGinning: freezed == playerGinning
          ? _value.playerGinning
          : playerGinning // ignore: cast_nullable_to_non_nullable
              as User?,
      lobbyCode: null == lobbyCode
          ? _value.lobbyCode
          : lobbyCode // ignore: cast_nullable_to_non_nullable
              as String,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<User>,
      playersNotPlaying: null == playersNotPlaying
          ? _value._playersNotPlaying
          : playersNotPlaying // ignore: cast_nullable_to_non_nullable
              as List<User>,
      playersPlaying: null == playersPlaying
          ? _value._playersPlaying
          : playersPlaying // ignore: cast_nullable_to_non_nullable
              as List<User>,
      gameStatus: null == gameStatus
          ? _value.gameStatus
          : gameStatus // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as User,
      winner: freezed == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as User?,
      roundWinner: freezed == roundWinner
          ? _value.roundWinner
          : roundWinner // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GinRummyGameStateImpl extends _GinRummyGameState {
  _$GinRummyGameStateImpl(
      {required this.currentPlayer,
      required this.firstPlayerPassed,
      required this.isFirstTurn,
      required this.isSecondTurn,
      required this.bothPass,
      required final List<Card> drawPile,
      required final List<Card> discardPile,
      required final Map<String, List<Card>> playerHands,
      required this.drawnCard,
      required final Map<String, int> playerScores,
      required this.playerKnocking,
      required this.playerGinning,
      required this.lobbyCode,
      required final List<User> players,
      required final List<User> playersNotPlaying,
      required final List<User> playersPlaying,
      required this.gameStatus,
      required this.host,
      required this.winner,
      required this.roundWinner})
      : _drawPile = drawPile,
        _discardPile = discardPile,
        _playerHands = playerHands,
        _playerScores = playerScores,
        _players = players,
        _playersNotPlaying = playersNotPlaying,
        _playersPlaying = playersPlaying,
        super._();

  factory _$GinRummyGameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GinRummyGameStateImplFromJson(json);

  @override
  final User? currentPlayer;
  @override
  final bool firstPlayerPassed;
  @override
  final bool isFirstTurn;
  @override
  final bool isSecondTurn;
  @override
  final bool bothPass;
  final List<Card> _drawPile;
  @override
  List<Card> get drawPile {
    if (_drawPile is EqualUnmodifiableListView) return _drawPile;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_drawPile);
  }

  final List<Card> _discardPile;
  @override
  List<Card> get discardPile {
    if (_discardPile is EqualUnmodifiableListView) return _discardPile;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_discardPile);
  }

  final Map<String, List<Card>> _playerHands;
  @override
  Map<String, List<Card>> get playerHands {
    if (_playerHands is EqualUnmodifiableMapView) return _playerHands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerHands);
  }

  @override
  final Card? drawnCard;
  final Map<String, int> _playerScores;
  @override
  Map<String, int> get playerScores {
    if (_playerScores is EqualUnmodifiableMapView) return _playerScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerScores);
  }

  @override
  final User? playerKnocking;
  @override
  final User? playerGinning;
  @override
  final String lobbyCode;
  final List<User> _players;
  @override
  List<User> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  final List<User> _playersNotPlaying;
  @override
  List<User> get playersNotPlaying {
    if (_playersNotPlaying is EqualUnmodifiableListView)
      return _playersNotPlaying;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playersNotPlaying);
  }

  final List<User> _playersPlaying;
  @override
  List<User> get playersPlaying {
    if (_playersPlaying is EqualUnmodifiableListView) return _playersPlaying;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playersPlaying);
  }

  @override
  final GameStatus gameStatus;
  @override
  final User host;
  @override
  final User? winner;
  @override
  final User? roundWinner;

  @override
  String toString() {
    return 'GinRummyGameModel(currentPlayer: $currentPlayer, firstPlayerPassed: $firstPlayerPassed, isFirstTurn: $isFirstTurn, isSecondTurn: $isSecondTurn, bothPass: $bothPass, drawPile: $drawPile, discardPile: $discardPile, playerHands: $playerHands, drawnCard: $drawnCard, playerScores: $playerScores, playerKnocking: $playerKnocking, playerGinning: $playerGinning, lobbyCode: $lobbyCode, players: $players, playersNotPlaying: $playersNotPlaying, playersPlaying: $playersPlaying, gameStatus: $gameStatus, host: $host, winner: $winner, roundWinner: $roundWinner)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GinRummyGameStateImpl &&
            (identical(other.currentPlayer, currentPlayer) ||
                other.currentPlayer == currentPlayer) &&
            (identical(other.firstPlayerPassed, firstPlayerPassed) ||
                other.firstPlayerPassed == firstPlayerPassed) &&
            (identical(other.isFirstTurn, isFirstTurn) ||
                other.isFirstTurn == isFirstTurn) &&
            (identical(other.isSecondTurn, isSecondTurn) ||
                other.isSecondTurn == isSecondTurn) &&
            (identical(other.bothPass, bothPass) ||
                other.bothPass == bothPass) &&
            const DeepCollectionEquality().equals(other._drawPile, _drawPile) &&
            const DeepCollectionEquality()
                .equals(other._discardPile, _discardPile) &&
            const DeepCollectionEquality()
                .equals(other._playerHands, _playerHands) &&
            (identical(other.drawnCard, drawnCard) ||
                other.drawnCard == drawnCard) &&
            const DeepCollectionEquality()
                .equals(other._playerScores, _playerScores) &&
            (identical(other.playerKnocking, playerKnocking) ||
                other.playerKnocking == playerKnocking) &&
            (identical(other.playerGinning, playerGinning) ||
                other.playerGinning == playerGinning) &&
            (identical(other.lobbyCode, lobbyCode) ||
                other.lobbyCode == lobbyCode) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality()
                .equals(other._playersNotPlaying, _playersNotPlaying) &&
            const DeepCollectionEquality()
                .equals(other._playersPlaying, _playersPlaying) &&
            (identical(other.gameStatus, gameStatus) ||
                other.gameStatus == gameStatus) &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.winner, winner) || other.winner == winner) &&
            (identical(other.roundWinner, roundWinner) ||
                other.roundWinner == roundWinner));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        currentPlayer,
        firstPlayerPassed,
        isFirstTurn,
        isSecondTurn,
        bothPass,
        const DeepCollectionEquality().hash(_drawPile),
        const DeepCollectionEquality().hash(_discardPile),
        const DeepCollectionEquality().hash(_playerHands),
        drawnCard,
        const DeepCollectionEquality().hash(_playerScores),
        playerKnocking,
        playerGinning,
        lobbyCode,
        const DeepCollectionEquality().hash(_players),
        const DeepCollectionEquality().hash(_playersNotPlaying),
        const DeepCollectionEquality().hash(_playersPlaying),
        gameStatus,
        host,
        winner,
        roundWinner
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GinRummyGameStateImplCopyWith<_$GinRummyGameStateImpl> get copyWith =>
      __$$GinRummyGameStateImplCopyWithImpl<_$GinRummyGameStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GinRummyGameStateImplToJson(
      this,
    );
  }
}

abstract class _GinRummyGameState extends GinRummyGameModel {
  factory _GinRummyGameState(
      {required final User? currentPlayer,
      required final bool firstPlayerPassed,
      required final bool isFirstTurn,
      required final bool isSecondTurn,
      required final bool bothPass,
      required final List<Card> drawPile,
      required final List<Card> discardPile,
      required final Map<String, List<Card>> playerHands,
      required final Card? drawnCard,
      required final Map<String, int> playerScores,
      required final User? playerKnocking,
      required final User? playerGinning,
      required final String lobbyCode,
      required final List<User> players,
      required final List<User> playersNotPlaying,
      required final List<User> playersPlaying,
      required final GameStatus gameStatus,
      required final User host,
      required final User? winner,
      required final User? roundWinner}) = _$GinRummyGameStateImpl;
  _GinRummyGameState._() : super._();

  factory _GinRummyGameState.fromJson(Map<String, dynamic> json) =
      _$GinRummyGameStateImpl.fromJson;

  @override
  User? get currentPlayer;
  @override
  bool get firstPlayerPassed;
  @override
  bool get isFirstTurn;
  @override
  bool get isSecondTurn;
  @override
  bool get bothPass;
  @override
  List<Card> get drawPile;
  @override
  List<Card> get discardPile;
  @override
  Map<String, List<Card>> get playerHands;
  @override
  Card? get drawnCard;
  @override
  Map<String, int> get playerScores;
  @override
  User? get playerKnocking;
  @override
  User? get playerGinning;
  @override
  String get lobbyCode;
  @override
  List<User> get players;
  @override
  List<User> get playersNotPlaying;
  @override
  List<User> get playersPlaying;
  @override
  GameStatus get gameStatus;
  @override
  User get host;
  @override
  User? get winner;
  @override
  User? get roundWinner;
  @override
  @JsonKey(ignore: true)
  _$$GinRummyGameStateImplCopyWith<_$GinRummyGameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
