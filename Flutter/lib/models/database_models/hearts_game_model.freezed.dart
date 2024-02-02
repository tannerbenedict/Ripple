// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hearts_game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HeartsGameModel _$HeartsGameModelFromJson(Map<String, dynamic> json) {
  return _HeartsGameModel.fromJson(json);
}

/// @nodoc
mixin _$HeartsGameModel {
  Map<String, List<Card>> get playerHands => throw _privateConstructorUsedError;
  List<Card> get cardsPlayed => throw _privateConstructorUsedError;
  Map<String, Card?> get playerDiscards => throw _privateConstructorUsedError;
  Card? get cardLed => throw _privateConstructorUsedError;
  List<User> get turnOrder => throw _privateConstructorUsedError;
  Map<String, int> get playerScores => throw _privateConstructorUsedError;
  Map<String, List<Card>> get playerWins => throw _privateConstructorUsedError;
  String get lobbyCode => throw _privateConstructorUsedError;
  User? get firstPlayer => throw _privateConstructorUsedError;
  User? get handWinner => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  bool get roundEnded => throw _privateConstructorUsedError;
  bool get heartsBroken => throw _privateConstructorUsedError;
  List<User> get players => throw _privateConstructorUsedError;
  List<User> get playersNotPlaying => throw _privateConstructorUsedError;
  List<User> get playersPlaying => throw _privateConstructorUsedError;
  GameStatus get gameStatus => throw _privateConstructorUsedError;
  User get host => throw _privateConstructorUsedError;
  User? get winner => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HeartsGameModelCopyWith<HeartsGameModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HeartsGameModelCopyWith<$Res> {
  factory $HeartsGameModelCopyWith(
          HeartsGameModel value, $Res Function(HeartsGameModel) then) =
      _$HeartsGameModelCopyWithImpl<$Res, HeartsGameModel>;
  @useResult
  $Res call(
      {Map<String, List<Card>> playerHands,
      List<Card> cardsPlayed,
      Map<String, Card?> playerDiscards,
      Card? cardLed,
      List<User> turnOrder,
      Map<String, int> playerScores,
      Map<String, List<Card>> playerWins,
      String lobbyCode,
      User? firstPlayer,
      User? handWinner,
      int currentIndex,
      bool roundEnded,
      bool heartsBroken,
      List<User> players,
      List<User> playersNotPlaying,
      List<User> playersPlaying,
      GameStatus gameStatus,
      User host,
      User? winner});

  $CardCopyWith<$Res>? get cardLed;
  $UserCopyWith<$Res>? get firstPlayer;
  $UserCopyWith<$Res>? get handWinner;
  $UserCopyWith<$Res> get host;
  $UserCopyWith<$Res>? get winner;
}

/// @nodoc
class _$HeartsGameModelCopyWithImpl<$Res, $Val extends HeartsGameModel>
    implements $HeartsGameModelCopyWith<$Res> {
  _$HeartsGameModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerHands = null,
    Object? cardsPlayed = null,
    Object? playerDiscards = null,
    Object? cardLed = freezed,
    Object? turnOrder = null,
    Object? playerScores = null,
    Object? playerWins = null,
    Object? lobbyCode = null,
    Object? firstPlayer = freezed,
    Object? handWinner = freezed,
    Object? currentIndex = null,
    Object? roundEnded = null,
    Object? heartsBroken = null,
    Object? players = null,
    Object? playersNotPlaying = null,
    Object? playersPlaying = null,
    Object? gameStatus = null,
    Object? host = null,
    Object? winner = freezed,
  }) {
    return _then(_value.copyWith(
      playerHands: null == playerHands
          ? _value.playerHands
          : playerHands // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Card>>,
      cardsPlayed: null == cardsPlayed
          ? _value.cardsPlayed
          : cardsPlayed // ignore: cast_nullable_to_non_nullable
              as List<Card>,
      playerDiscards: null == playerDiscards
          ? _value.playerDiscards
          : playerDiscards // ignore: cast_nullable_to_non_nullable
              as Map<String, Card?>,
      cardLed: freezed == cardLed
          ? _value.cardLed
          : cardLed // ignore: cast_nullable_to_non_nullable
              as Card?,
      turnOrder: null == turnOrder
          ? _value.turnOrder
          : turnOrder // ignore: cast_nullable_to_non_nullable
              as List<User>,
      playerScores: null == playerScores
          ? _value.playerScores
          : playerScores // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      playerWins: null == playerWins
          ? _value.playerWins
          : playerWins // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Card>>,
      lobbyCode: null == lobbyCode
          ? _value.lobbyCode
          : lobbyCode // ignore: cast_nullable_to_non_nullable
              as String,
      firstPlayer: freezed == firstPlayer
          ? _value.firstPlayer
          : firstPlayer // ignore: cast_nullable_to_non_nullable
              as User?,
      handWinner: freezed == handWinner
          ? _value.handWinner
          : handWinner // ignore: cast_nullable_to_non_nullable
              as User?,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      roundEnded: null == roundEnded
          ? _value.roundEnded
          : roundEnded // ignore: cast_nullable_to_non_nullable
              as bool,
      heartsBroken: null == heartsBroken
          ? _value.heartsBroken
          : heartsBroken // ignore: cast_nullable_to_non_nullable
              as bool,
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
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CardCopyWith<$Res>? get cardLed {
    if (_value.cardLed == null) {
      return null;
    }

    return $CardCopyWith<$Res>(_value.cardLed!, (value) {
      return _then(_value.copyWith(cardLed: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get firstPlayer {
    if (_value.firstPlayer == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.firstPlayer!, (value) {
      return _then(_value.copyWith(firstPlayer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get handWinner {
    if (_value.handWinner == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.handWinner!, (value) {
      return _then(_value.copyWith(handWinner: value) as $Val);
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
}

/// @nodoc
abstract class _$$HeartsGameModelImplCopyWith<$Res>
    implements $HeartsGameModelCopyWith<$Res> {
  factory _$$HeartsGameModelImplCopyWith(_$HeartsGameModelImpl value,
          $Res Function(_$HeartsGameModelImpl) then) =
      __$$HeartsGameModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, List<Card>> playerHands,
      List<Card> cardsPlayed,
      Map<String, Card?> playerDiscards,
      Card? cardLed,
      List<User> turnOrder,
      Map<String, int> playerScores,
      Map<String, List<Card>> playerWins,
      String lobbyCode,
      User? firstPlayer,
      User? handWinner,
      int currentIndex,
      bool roundEnded,
      bool heartsBroken,
      List<User> players,
      List<User> playersNotPlaying,
      List<User> playersPlaying,
      GameStatus gameStatus,
      User host,
      User? winner});

  @override
  $CardCopyWith<$Res>? get cardLed;
  @override
  $UserCopyWith<$Res>? get firstPlayer;
  @override
  $UserCopyWith<$Res>? get handWinner;
  @override
  $UserCopyWith<$Res> get host;
  @override
  $UserCopyWith<$Res>? get winner;
}

/// @nodoc
class __$$HeartsGameModelImplCopyWithImpl<$Res>
    extends _$HeartsGameModelCopyWithImpl<$Res, _$HeartsGameModelImpl>
    implements _$$HeartsGameModelImplCopyWith<$Res> {
  __$$HeartsGameModelImplCopyWithImpl(
      _$HeartsGameModelImpl _value, $Res Function(_$HeartsGameModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerHands = null,
    Object? cardsPlayed = null,
    Object? playerDiscards = null,
    Object? cardLed = freezed,
    Object? turnOrder = null,
    Object? playerScores = null,
    Object? playerWins = null,
    Object? lobbyCode = null,
    Object? firstPlayer = freezed,
    Object? handWinner = freezed,
    Object? currentIndex = null,
    Object? roundEnded = null,
    Object? heartsBroken = null,
    Object? players = null,
    Object? playersNotPlaying = null,
    Object? playersPlaying = null,
    Object? gameStatus = null,
    Object? host = null,
    Object? winner = freezed,
  }) {
    return _then(_$HeartsGameModelImpl(
      playerHands: null == playerHands
          ? _value._playerHands
          : playerHands // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Card>>,
      cardsPlayed: null == cardsPlayed
          ? _value._cardsPlayed
          : cardsPlayed // ignore: cast_nullable_to_non_nullable
              as List<Card>,
      playerDiscards: null == playerDiscards
          ? _value._playerDiscards
          : playerDiscards // ignore: cast_nullable_to_non_nullable
              as Map<String, Card?>,
      cardLed: freezed == cardLed
          ? _value.cardLed
          : cardLed // ignore: cast_nullable_to_non_nullable
              as Card?,
      turnOrder: null == turnOrder
          ? _value._turnOrder
          : turnOrder // ignore: cast_nullable_to_non_nullable
              as List<User>,
      playerScores: null == playerScores
          ? _value._playerScores
          : playerScores // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      playerWins: null == playerWins
          ? _value._playerWins
          : playerWins // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Card>>,
      lobbyCode: null == lobbyCode
          ? _value.lobbyCode
          : lobbyCode // ignore: cast_nullable_to_non_nullable
              as String,
      firstPlayer: freezed == firstPlayer
          ? _value.firstPlayer
          : firstPlayer // ignore: cast_nullable_to_non_nullable
              as User?,
      handWinner: freezed == handWinner
          ? _value.handWinner
          : handWinner // ignore: cast_nullable_to_non_nullable
              as User?,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      roundEnded: null == roundEnded
          ? _value.roundEnded
          : roundEnded // ignore: cast_nullable_to_non_nullable
              as bool,
      heartsBroken: null == heartsBroken
          ? _value.heartsBroken
          : heartsBroken // ignore: cast_nullable_to_non_nullable
              as bool,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HeartsGameModelImpl extends _HeartsGameModel {
  _$HeartsGameModelImpl(
      {required final Map<String, List<Card>> playerHands,
      required final List<Card> cardsPlayed,
      required final Map<String, Card?> playerDiscards,
      required this.cardLed,
      required final List<User> turnOrder,
      required final Map<String, int> playerScores,
      required final Map<String, List<Card>> playerWins,
      required this.lobbyCode,
      required this.firstPlayer,
      required this.handWinner,
      required this.currentIndex,
      required this.roundEnded,
      required this.heartsBroken,
      required final List<User> players,
      required final List<User> playersNotPlaying,
      required final List<User> playersPlaying,
      required this.gameStatus,
      required this.host,
      required this.winner})
      : _playerHands = playerHands,
        _cardsPlayed = cardsPlayed,
        _playerDiscards = playerDiscards,
        _turnOrder = turnOrder,
        _playerScores = playerScores,
        _playerWins = playerWins,
        _players = players,
        _playersNotPlaying = playersNotPlaying,
        _playersPlaying = playersPlaying,
        super._();

  factory _$HeartsGameModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HeartsGameModelImplFromJson(json);

  final Map<String, List<Card>> _playerHands;
  @override
  Map<String, List<Card>> get playerHands {
    if (_playerHands is EqualUnmodifiableMapView) return _playerHands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerHands);
  }

  final List<Card> _cardsPlayed;
  @override
  List<Card> get cardsPlayed {
    if (_cardsPlayed is EqualUnmodifiableListView) return _cardsPlayed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cardsPlayed);
  }

  final Map<String, Card?> _playerDiscards;
  @override
  Map<String, Card?> get playerDiscards {
    if (_playerDiscards is EqualUnmodifiableMapView) return _playerDiscards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerDiscards);
  }

  @override
  final Card? cardLed;
  final List<User> _turnOrder;
  @override
  List<User> get turnOrder {
    if (_turnOrder is EqualUnmodifiableListView) return _turnOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_turnOrder);
  }

  final Map<String, int> _playerScores;
  @override
  Map<String, int> get playerScores {
    if (_playerScores is EqualUnmodifiableMapView) return _playerScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerScores);
  }

  final Map<String, List<Card>> _playerWins;
  @override
  Map<String, List<Card>> get playerWins {
    if (_playerWins is EqualUnmodifiableMapView) return _playerWins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerWins);
  }

  @override
  final String lobbyCode;
  @override
  final User? firstPlayer;
  @override
  final User? handWinner;
  @override
  final int currentIndex;
  @override
  final bool roundEnded;
  @override
  final bool heartsBroken;
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
  String toString() {
    return 'HeartsGameModel(playerHands: $playerHands, cardsPlayed: $cardsPlayed, playerDiscards: $playerDiscards, cardLed: $cardLed, turnOrder: $turnOrder, playerScores: $playerScores, playerWins: $playerWins, lobbyCode: $lobbyCode, firstPlayer: $firstPlayer, handWinner: $handWinner, currentIndex: $currentIndex, roundEnded: $roundEnded, heartsBroken: $heartsBroken, players: $players, playersNotPlaying: $playersNotPlaying, playersPlaying: $playersPlaying, gameStatus: $gameStatus, host: $host, winner: $winner)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HeartsGameModelImpl &&
            const DeepCollectionEquality()
                .equals(other._playerHands, _playerHands) &&
            const DeepCollectionEquality()
                .equals(other._cardsPlayed, _cardsPlayed) &&
            const DeepCollectionEquality()
                .equals(other._playerDiscards, _playerDiscards) &&
            (identical(other.cardLed, cardLed) || other.cardLed == cardLed) &&
            const DeepCollectionEquality()
                .equals(other._turnOrder, _turnOrder) &&
            const DeepCollectionEquality()
                .equals(other._playerScores, _playerScores) &&
            const DeepCollectionEquality()
                .equals(other._playerWins, _playerWins) &&
            (identical(other.lobbyCode, lobbyCode) ||
                other.lobbyCode == lobbyCode) &&
            (identical(other.firstPlayer, firstPlayer) ||
                other.firstPlayer == firstPlayer) &&
            (identical(other.handWinner, handWinner) ||
                other.handWinner == handWinner) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.roundEnded, roundEnded) ||
                other.roundEnded == roundEnded) &&
            (identical(other.heartsBroken, heartsBroken) ||
                other.heartsBroken == heartsBroken) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality()
                .equals(other._playersNotPlaying, _playersNotPlaying) &&
            const DeepCollectionEquality()
                .equals(other._playersPlaying, _playersPlaying) &&
            (identical(other.gameStatus, gameStatus) ||
                other.gameStatus == gameStatus) &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.winner, winner) || other.winner == winner));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(_playerHands),
        const DeepCollectionEquality().hash(_cardsPlayed),
        const DeepCollectionEquality().hash(_playerDiscards),
        cardLed,
        const DeepCollectionEquality().hash(_turnOrder),
        const DeepCollectionEquality().hash(_playerScores),
        const DeepCollectionEquality().hash(_playerWins),
        lobbyCode,
        firstPlayer,
        handWinner,
        currentIndex,
        roundEnded,
        heartsBroken,
        const DeepCollectionEquality().hash(_players),
        const DeepCollectionEquality().hash(_playersNotPlaying),
        const DeepCollectionEquality().hash(_playersPlaying),
        gameStatus,
        host,
        winner
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HeartsGameModelImplCopyWith<_$HeartsGameModelImpl> get copyWith =>
      __$$HeartsGameModelImplCopyWithImpl<_$HeartsGameModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HeartsGameModelImplToJson(
      this,
    );
  }
}

abstract class _HeartsGameModel extends HeartsGameModel {
  factory _HeartsGameModel(
      {required final Map<String, List<Card>> playerHands,
      required final List<Card> cardsPlayed,
      required final Map<String, Card?> playerDiscards,
      required final Card? cardLed,
      required final List<User> turnOrder,
      required final Map<String, int> playerScores,
      required final Map<String, List<Card>> playerWins,
      required final String lobbyCode,
      required final User? firstPlayer,
      required final User? handWinner,
      required final int currentIndex,
      required final bool roundEnded,
      required final bool heartsBroken,
      required final List<User> players,
      required final List<User> playersNotPlaying,
      required final List<User> playersPlaying,
      required final GameStatus gameStatus,
      required final User host,
      required final User? winner}) = _$HeartsGameModelImpl;
  _HeartsGameModel._() : super._();

  factory _HeartsGameModel.fromJson(Map<String, dynamic> json) =
      _$HeartsGameModelImpl.fromJson;

  @override
  Map<String, List<Card>> get playerHands;
  @override
  List<Card> get cardsPlayed;
  @override
  Map<String, Card?> get playerDiscards;
  @override
  Card? get cardLed;
  @override
  List<User> get turnOrder;
  @override
  Map<String, int> get playerScores;
  @override
  Map<String, List<Card>> get playerWins;
  @override
  String get lobbyCode;
  @override
  User? get firstPlayer;
  @override
  User? get handWinner;
  @override
  int get currentIndex;
  @override
  bool get roundEnded;
  @override
  bool get heartsBroken;
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
  @JsonKey(ignore: true)
  _$$HeartsGameModelImplCopyWith<_$HeartsGameModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
