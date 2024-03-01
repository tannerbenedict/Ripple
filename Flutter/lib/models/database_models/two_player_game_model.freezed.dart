// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'two_player_game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TwoPlayerGameModel _$TwoPlayerGameModelFromJson(Map<String, dynamic> json) {
  return _TwoPlayerGameState.fromJson(json);
}

/// @nodoc
mixin _$TwoPlayerGameModel {
  User? get currentPlayer => throw _privateConstructorUsedError;
  bool get isFirstTurn => throw _privateConstructorUsedError;
  bool get isSecondTurn => throw _privateConstructorUsedError;
  bool get canRipple => throw _privateConstructorUsedError;
  bool get firstPlay => throw _privateConstructorUsedError;
  List<Card> get drawPile => throw _privateConstructorUsedError;
  List<Card> get discardPile => throw _privateConstructorUsedError;
  List<Card> get activePile => throw _privateConstructorUsedError;
  int get cardsFlipped => throw _privateConstructorUsedError;
  Map<String, List<Card>> get playerHands => throw _privateConstructorUsedError;
  Card? get drawnCard => throw _privateConstructorUsedError;
  Map<String, int> get playerScores => throw _privateConstructorUsedError;
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
  $TwoPlayerGameModelCopyWith<TwoPlayerGameModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TwoPlayerGameModelCopyWith<$Res> {
  factory $TwoPlayerGameModelCopyWith(
          TwoPlayerGameModel value, $Res Function(TwoPlayerGameModel) then) =
      _$TwoPlayerGameModelCopyWithImpl<$Res, TwoPlayerGameModel>;
  @useResult
  $Res call(
      {User? currentPlayer,
      bool isFirstTurn,
      bool isSecondTurn,
      bool canRipple,
      bool firstPlay,
      List<Card> drawPile,
      List<Card> discardPile,
      List<Card> activePile,
      int cardsFlipped,
      Map<String, List<Card>> playerHands,
      Card? drawnCard,
      Map<String, int> playerScores,
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
  $UserCopyWith<$Res> get host;
  $UserCopyWith<$Res>? get winner;
  $UserCopyWith<$Res>? get roundWinner;
}

/// @nodoc
class _$TwoPlayerGameModelCopyWithImpl<$Res, $Val extends TwoPlayerGameModel>
    implements $TwoPlayerGameModelCopyWith<$Res> {
  _$TwoPlayerGameModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPlayer = freezed,
    Object? isFirstTurn = null,
    Object? isSecondTurn = null,
    Object? canRipple = null,
    Object? firstPlay = null,
    Object? drawPile = null,
    Object? discardPile = null,
    Object? activePile = null,
    Object? cardsFlipped = null,
    Object? playerHands = null,
    Object? drawnCard = freezed,
    Object? playerScores = null,
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
      isFirstTurn: null == isFirstTurn
          ? _value.isFirstTurn
          : isFirstTurn // ignore: cast_nullable_to_non_nullable
              as bool,
      isSecondTurn: null == isSecondTurn
          ? _value.isSecondTurn
          : isSecondTurn // ignore: cast_nullable_to_non_nullable
              as bool,
      canRipple: null == canRipple
          ? _value.canRipple
          : canRipple // ignore: cast_nullable_to_non_nullable
              as bool,
      firstPlay: null == firstPlay
          ? _value.firstPlay
          : firstPlay // ignore: cast_nullable_to_non_nullable
              as bool,
      drawPile: null == drawPile
          ? _value.drawPile
          : drawPile // ignore: cast_nullable_to_non_nullable
              as List<Card>,
      discardPile: null == discardPile
          ? _value.discardPile
          : discardPile // ignore: cast_nullable_to_non_nullable
              as List<Card>,
      activePile: null == activePile
          ? _value.activePile
          : activePile // ignore: cast_nullable_to_non_nullable
              as List<Card>,
      cardsFlipped: null == cardsFlipped
          ? _value.cardsFlipped
          : cardsFlipped // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$TwoPlayerGameStateImplCopyWith<$Res>
    implements $TwoPlayerGameModelCopyWith<$Res> {
  factory _$$TwoPlayerGameStateImplCopyWith(_$TwoPlayerGameStateImpl value,
          $Res Function(_$TwoPlayerGameStateImpl) then) =
      __$$TwoPlayerGameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {User? currentPlayer,
      bool isFirstTurn,
      bool isSecondTurn,
      bool canRipple,
      bool firstPlay,
      List<Card> drawPile,
      List<Card> discardPile,
      List<Card> activePile,
      int cardsFlipped,
      Map<String, List<Card>> playerHands,
      Card? drawnCard,
      Map<String, int> playerScores,
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
  $UserCopyWith<$Res> get host;
  @override
  $UserCopyWith<$Res>? get winner;
  @override
  $UserCopyWith<$Res>? get roundWinner;
}

/// @nodoc
class __$$TwoPlayerGameStateImplCopyWithImpl<$Res>
    extends _$TwoPlayerGameModelCopyWithImpl<$Res, _$TwoPlayerGameStateImpl>
    implements _$$TwoPlayerGameStateImplCopyWith<$Res> {
  __$$TwoPlayerGameStateImplCopyWithImpl(_$TwoPlayerGameStateImpl _value,
      $Res Function(_$TwoPlayerGameStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPlayer = freezed,
    Object? isFirstTurn = null,
    Object? isSecondTurn = null,
    Object? canRipple = null,
    Object? firstPlay = null,
    Object? drawPile = null,
    Object? discardPile = null,
    Object? activePile = null,
    Object? cardsFlipped = null,
    Object? playerHands = null,
    Object? drawnCard = freezed,
    Object? playerScores = null,
    Object? lobbyCode = null,
    Object? players = null,
    Object? playersNotPlaying = null,
    Object? playersPlaying = null,
    Object? gameStatus = null,
    Object? host = null,
    Object? winner = freezed,
    Object? roundWinner = freezed,
  }) {
    return _then(_$TwoPlayerGameStateImpl(
      currentPlayer: freezed == currentPlayer
          ? _value.currentPlayer
          : currentPlayer // ignore: cast_nullable_to_non_nullable
              as User?,
      isFirstTurn: null == isFirstTurn
          ? _value.isFirstTurn
          : isFirstTurn // ignore: cast_nullable_to_non_nullable
              as bool,
      isSecondTurn: null == isSecondTurn
          ? _value.isSecondTurn
          : isSecondTurn // ignore: cast_nullable_to_non_nullable
              as bool,
      canRipple: null == canRipple
          ? _value.canRipple
          : canRipple // ignore: cast_nullable_to_non_nullable
              as bool,
      firstPlay: null == firstPlay
          ? _value.firstPlay
          : firstPlay // ignore: cast_nullable_to_non_nullable
              as bool,
      drawPile: null == drawPile
          ? _value._drawPile
          : drawPile // ignore: cast_nullable_to_non_nullable
              as List<Card>,
      discardPile: null == discardPile
          ? _value._discardPile
          : discardPile // ignore: cast_nullable_to_non_nullable
              as List<Card>,
      activePile: null == activePile
          ? _value._activePile
          : activePile // ignore: cast_nullable_to_non_nullable
              as List<Card>,
      cardsFlipped: null == cardsFlipped
          ? _value.cardsFlipped
          : cardsFlipped // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$TwoPlayerGameStateImpl extends _TwoPlayerGameState {
  _$TwoPlayerGameStateImpl(
      {required this.currentPlayer,
      required this.isFirstTurn,
      required this.isSecondTurn,
      required this.canRipple,
      required this.firstPlay,
      required final List<Card> drawPile,
      required final List<Card> discardPile,
      required final List<Card> activePile,
      required this.cardsFlipped,
      required final Map<String, List<Card>> playerHands,
      required this.drawnCard,
      required final Map<String, int> playerScores,
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
        _activePile = activePile,
        _playerHands = playerHands,
        _playerScores = playerScores,
        _players = players,
        _playersNotPlaying = playersNotPlaying,
        _playersPlaying = playersPlaying,
        super._();

  factory _$TwoPlayerGameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TwoPlayerGameStateImplFromJson(json);

  @override
  final User? currentPlayer;
  @override
  final bool isFirstTurn;
  @override
  final bool isSecondTurn;
  @override
  final bool canRipple;
  @override
  final bool firstPlay;
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

  final List<Card> _activePile;
  @override
  List<Card> get activePile {
    if (_activePile is EqualUnmodifiableListView) return _activePile;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activePile);
  }

  @override
  final int cardsFlipped;
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
    return 'TwoPlayerGameModel(currentPlayer: $currentPlayer, isFirstTurn: $isFirstTurn, isSecondTurn: $isSecondTurn, canRipple: $canRipple, firstPlay: $firstPlay, drawPile: $drawPile, discardPile: $discardPile, activePile: $activePile, cardsFlipped: $cardsFlipped, playerHands: $playerHands, drawnCard: $drawnCard, playerScores: $playerScores, lobbyCode: $lobbyCode, players: $players, playersNotPlaying: $playersNotPlaying, playersPlaying: $playersPlaying, gameStatus: $gameStatus, host: $host, winner: $winner, roundWinner: $roundWinner)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TwoPlayerGameStateImpl &&
            (identical(other.currentPlayer, currentPlayer) ||
                other.currentPlayer == currentPlayer) &&
            (identical(other.isFirstTurn, isFirstTurn) ||
                other.isFirstTurn == isFirstTurn) &&
            (identical(other.isSecondTurn, isSecondTurn) ||
                other.isSecondTurn == isSecondTurn) &&
            (identical(other.canRipple, canRipple) ||
                other.canRipple == canRipple) &&
            (identical(other.firstPlay, firstPlay) ||
                other.firstPlay == firstPlay) &&
            const DeepCollectionEquality().equals(other._drawPile, _drawPile) &&
            const DeepCollectionEquality()
                .equals(other._discardPile, _discardPile) &&
            const DeepCollectionEquality()
                .equals(other._activePile, _activePile) &&
            (identical(other.cardsFlipped, cardsFlipped) ||
                other.cardsFlipped == cardsFlipped) &&
            const DeepCollectionEquality()
                .equals(other._playerHands, _playerHands) &&
            (identical(other.drawnCard, drawnCard) ||
                other.drawnCard == drawnCard) &&
            const DeepCollectionEquality()
                .equals(other._playerScores, _playerScores) &&
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
        isFirstTurn,
        isSecondTurn,
        canRipple,
        firstPlay,
        const DeepCollectionEquality().hash(_drawPile),
        const DeepCollectionEquality().hash(_discardPile),
        const DeepCollectionEquality().hash(_activePile),
        cardsFlipped,
        const DeepCollectionEquality().hash(_playerHands),
        drawnCard,
        const DeepCollectionEquality().hash(_playerScores),
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
  _$$TwoPlayerGameStateImplCopyWith<_$TwoPlayerGameStateImpl> get copyWith =>
      __$$TwoPlayerGameStateImplCopyWithImpl<_$TwoPlayerGameStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TwoPlayerGameStateImplToJson(
      this,
    );
  }
}

abstract class _TwoPlayerGameState extends TwoPlayerGameModel {
  factory _TwoPlayerGameState(
      {required final User? currentPlayer,
      required final bool isFirstTurn,
      required final bool isSecondTurn,
      required final bool canRipple,
      required final bool firstPlay,
      required final List<Card> drawPile,
      required final List<Card> discardPile,
      required final List<Card> activePile,
      required final int cardsFlipped,
      required final Map<String, List<Card>> playerHands,
      required final Card? drawnCard,
      required final Map<String, int> playerScores,
      required final String lobbyCode,
      required final List<User> players,
      required final List<User> playersNotPlaying,
      required final List<User> playersPlaying,
      required final GameStatus gameStatus,
      required final User host,
      required final User? winner,
      required final User? roundWinner}) = _$TwoPlayerGameStateImpl;
  _TwoPlayerGameState._() : super._();

  factory _TwoPlayerGameState.fromJson(Map<String, dynamic> json) =
      _$TwoPlayerGameStateImpl.fromJson;

  @override
  User? get currentPlayer;
  @override
  bool get isFirstTurn;
  @override
  bool get isSecondTurn;
  @override
  bool get canRipple;
  @override
  bool get firstPlay;
  @override
  List<Card> get drawPile;
  @override
  List<Card> get discardPile;
  @override
  List<Card> get activePile;
  @override
  int get cardsFlipped;
  @override
  Map<String, List<Card>> get playerHands;
  @override
  Card? get drawnCard;
  @override
  Map<String, int> get playerScores;
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
  _$$TwoPlayerGameStateImplCopyWith<_$TwoPlayerGameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
