// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cheat_game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CheatGameModel _$CheatGameModelFromJson(Map<String, dynamic> json) {
  return _CheatGameModel.fromJson(json);
}

/// @nodoc
mixin _$CheatGameModel {
  Map<String, List<Card>> get playerHands => throw _privateConstructorUsedError;
  List<Card> get cardsPlayed => throw _privateConstructorUsedError;
  List<User> get turnOrder => throw _privateConstructorUsedError;
  Map<String, int> get playerScores => throw _privateConstructorUsedError;
  String get lobbyCode => throw _privateConstructorUsedError;
  User? get firstPlayer => throw _privateConstructorUsedError;
  User? get handWinner => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  List<User> get players => throw _privateConstructorUsedError;
  List<User> get playersNotPlaying => throw _privateConstructorUsedError;
  List<User> get playersPlaying => throw _privateConstructorUsedError;
  GameStatus get gameStatus => throw _privateConstructorUsedError;
  User get host => throw _privateConstructorUsedError;
  User? get playerWhoPlayed => throw _privateConstructorUsedError;
  User? get potentialWinner => throw _privateConstructorUsedError;
  User? get playerWhoCalledCheat => throw _privateConstructorUsedError;
  User? get playerWhoGotCards => throw _privateConstructorUsedError;
  bool get calledCheat => throw _privateConstructorUsedError;
  int get numPlayedPrevious => throw _privateConstructorUsedError;
  int get currentFaceValue => throw _privateConstructorUsedError;
  bool get isRoundEnd => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheatGameModelCopyWith<CheatGameModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheatGameModelCopyWith<$Res> {
  factory $CheatGameModelCopyWith(
          CheatGameModel value, $Res Function(CheatGameModel) then) =
      _$CheatGameModelCopyWithImpl<$Res, CheatGameModel>;
  @useResult
  $Res call(
      {Map<String, List<Card>> playerHands,
      List<Card> cardsPlayed,
      List<User> turnOrder,
      Map<String, int> playerScores,
      String lobbyCode,
      User? firstPlayer,
      User? handWinner,
      int currentIndex,
      List<User> players,
      List<User> playersNotPlaying,
      List<User> playersPlaying,
      GameStatus gameStatus,
      User host,
      User? playerWhoPlayed,
      User? potentialWinner,
      User? playerWhoCalledCheat,
      User? playerWhoGotCards,
      bool calledCheat,
      int numPlayedPrevious,
      int currentFaceValue,
      bool isRoundEnd});

  $UserCopyWith<$Res>? get firstPlayer;
  $UserCopyWith<$Res>? get handWinner;
  $UserCopyWith<$Res> get host;
  $UserCopyWith<$Res>? get playerWhoPlayed;
  $UserCopyWith<$Res>? get potentialWinner;
  $UserCopyWith<$Res>? get playerWhoCalledCheat;
  $UserCopyWith<$Res>? get playerWhoGotCards;
}

/// @nodoc
class _$CheatGameModelCopyWithImpl<$Res, $Val extends CheatGameModel>
    implements $CheatGameModelCopyWith<$Res> {
  _$CheatGameModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerHands = null,
    Object? cardsPlayed = null,
    Object? turnOrder = null,
    Object? playerScores = null,
    Object? lobbyCode = null,
    Object? firstPlayer = freezed,
    Object? handWinner = freezed,
    Object? currentIndex = null,
    Object? players = null,
    Object? playersNotPlaying = null,
    Object? playersPlaying = null,
    Object? gameStatus = null,
    Object? host = null,
    Object? playerWhoPlayed = freezed,
    Object? potentialWinner = freezed,
    Object? playerWhoCalledCheat = freezed,
    Object? playerWhoGotCards = freezed,
    Object? calledCheat = null,
    Object? numPlayedPrevious = null,
    Object? currentFaceValue = null,
    Object? isRoundEnd = null,
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
      turnOrder: null == turnOrder
          ? _value.turnOrder
          : turnOrder // ignore: cast_nullable_to_non_nullable
              as List<User>,
      playerScores: null == playerScores
          ? _value.playerScores
          : playerScores // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
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
      playerWhoPlayed: freezed == playerWhoPlayed
          ? _value.playerWhoPlayed
          : playerWhoPlayed // ignore: cast_nullable_to_non_nullable
              as User?,
      potentialWinner: freezed == potentialWinner
          ? _value.potentialWinner
          : potentialWinner // ignore: cast_nullable_to_non_nullable
              as User?,
      playerWhoCalledCheat: freezed == playerWhoCalledCheat
          ? _value.playerWhoCalledCheat
          : playerWhoCalledCheat // ignore: cast_nullable_to_non_nullable
              as User?,
      playerWhoGotCards: freezed == playerWhoGotCards
          ? _value.playerWhoGotCards
          : playerWhoGotCards // ignore: cast_nullable_to_non_nullable
              as User?,
      calledCheat: null == calledCheat
          ? _value.calledCheat
          : calledCheat // ignore: cast_nullable_to_non_nullable
              as bool,
      numPlayedPrevious: null == numPlayedPrevious
          ? _value.numPlayedPrevious
          : numPlayedPrevious // ignore: cast_nullable_to_non_nullable
              as int,
      currentFaceValue: null == currentFaceValue
          ? _value.currentFaceValue
          : currentFaceValue // ignore: cast_nullable_to_non_nullable
              as int,
      isRoundEnd: null == isRoundEnd
          ? _value.isRoundEnd
          : isRoundEnd // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
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
  $UserCopyWith<$Res>? get playerWhoPlayed {
    if (_value.playerWhoPlayed == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.playerWhoPlayed!, (value) {
      return _then(_value.copyWith(playerWhoPlayed: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get potentialWinner {
    if (_value.potentialWinner == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.potentialWinner!, (value) {
      return _then(_value.copyWith(potentialWinner: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get playerWhoCalledCheat {
    if (_value.playerWhoCalledCheat == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.playerWhoCalledCheat!, (value) {
      return _then(_value.copyWith(playerWhoCalledCheat: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get playerWhoGotCards {
    if (_value.playerWhoGotCards == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.playerWhoGotCards!, (value) {
      return _then(_value.copyWith(playerWhoGotCards: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CheatGameModelImplCopyWith<$Res>
    implements $CheatGameModelCopyWith<$Res> {
  factory _$$CheatGameModelImplCopyWith(_$CheatGameModelImpl value,
          $Res Function(_$CheatGameModelImpl) then) =
      __$$CheatGameModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, List<Card>> playerHands,
      List<Card> cardsPlayed,
      List<User> turnOrder,
      Map<String, int> playerScores,
      String lobbyCode,
      User? firstPlayer,
      User? handWinner,
      int currentIndex,
      List<User> players,
      List<User> playersNotPlaying,
      List<User> playersPlaying,
      GameStatus gameStatus,
      User host,
      User? playerWhoPlayed,
      User? potentialWinner,
      User? playerWhoCalledCheat,
      User? playerWhoGotCards,
      bool calledCheat,
      int numPlayedPrevious,
      int currentFaceValue,
      bool isRoundEnd});

  @override
  $UserCopyWith<$Res>? get firstPlayer;
  @override
  $UserCopyWith<$Res>? get handWinner;
  @override
  $UserCopyWith<$Res> get host;
  @override
  $UserCopyWith<$Res>? get playerWhoPlayed;
  @override
  $UserCopyWith<$Res>? get potentialWinner;
  @override
  $UserCopyWith<$Res>? get playerWhoCalledCheat;
  @override
  $UserCopyWith<$Res>? get playerWhoGotCards;
}

/// @nodoc
class __$$CheatGameModelImplCopyWithImpl<$Res>
    extends _$CheatGameModelCopyWithImpl<$Res, _$CheatGameModelImpl>
    implements _$$CheatGameModelImplCopyWith<$Res> {
  __$$CheatGameModelImplCopyWithImpl(
      _$CheatGameModelImpl _value, $Res Function(_$CheatGameModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerHands = null,
    Object? cardsPlayed = null,
    Object? turnOrder = null,
    Object? playerScores = null,
    Object? lobbyCode = null,
    Object? firstPlayer = freezed,
    Object? handWinner = freezed,
    Object? currentIndex = null,
    Object? players = null,
    Object? playersNotPlaying = null,
    Object? playersPlaying = null,
    Object? gameStatus = null,
    Object? host = null,
    Object? playerWhoPlayed = freezed,
    Object? potentialWinner = freezed,
    Object? playerWhoCalledCheat = freezed,
    Object? playerWhoGotCards = freezed,
    Object? calledCheat = null,
    Object? numPlayedPrevious = null,
    Object? currentFaceValue = null,
    Object? isRoundEnd = null,
  }) {
    return _then(_$CheatGameModelImpl(
      playerHands: null == playerHands
          ? _value._playerHands
          : playerHands // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Card>>,
      cardsPlayed: null == cardsPlayed
          ? _value._cardsPlayed
          : cardsPlayed // ignore: cast_nullable_to_non_nullable
              as List<Card>,
      turnOrder: null == turnOrder
          ? _value._turnOrder
          : turnOrder // ignore: cast_nullable_to_non_nullable
              as List<User>,
      playerScores: null == playerScores
          ? _value._playerScores
          : playerScores // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
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
      playerWhoPlayed: freezed == playerWhoPlayed
          ? _value.playerWhoPlayed
          : playerWhoPlayed // ignore: cast_nullable_to_non_nullable
              as User?,
      potentialWinner: freezed == potentialWinner
          ? _value.potentialWinner
          : potentialWinner // ignore: cast_nullable_to_non_nullable
              as User?,
      playerWhoCalledCheat: freezed == playerWhoCalledCheat
          ? _value.playerWhoCalledCheat
          : playerWhoCalledCheat // ignore: cast_nullable_to_non_nullable
              as User?,
      playerWhoGotCards: freezed == playerWhoGotCards
          ? _value.playerWhoGotCards
          : playerWhoGotCards // ignore: cast_nullable_to_non_nullable
              as User?,
      calledCheat: null == calledCheat
          ? _value.calledCheat
          : calledCheat // ignore: cast_nullable_to_non_nullable
              as bool,
      numPlayedPrevious: null == numPlayedPrevious
          ? _value.numPlayedPrevious
          : numPlayedPrevious // ignore: cast_nullable_to_non_nullable
              as int,
      currentFaceValue: null == currentFaceValue
          ? _value.currentFaceValue
          : currentFaceValue // ignore: cast_nullable_to_non_nullable
              as int,
      isRoundEnd: null == isRoundEnd
          ? _value.isRoundEnd
          : isRoundEnd // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheatGameModelImpl extends _CheatGameModel {
  _$CheatGameModelImpl(
      {required final Map<String, List<Card>> playerHands,
      required final List<Card> cardsPlayed,
      required final List<User> turnOrder,
      required final Map<String, int> playerScores,
      required this.lobbyCode,
      required this.firstPlayer,
      required this.handWinner,
      required this.currentIndex,
      required final List<User> players,
      required final List<User> playersNotPlaying,
      required final List<User> playersPlaying,
      required this.gameStatus,
      required this.host,
      required this.playerWhoPlayed,
      required this.potentialWinner,
      required this.playerWhoCalledCheat,
      this.playerWhoGotCards = null,
      required this.calledCheat,
      required this.numPlayedPrevious,
      required this.currentFaceValue,
      required this.isRoundEnd})
      : _playerHands = playerHands,
        _cardsPlayed = cardsPlayed,
        _turnOrder = turnOrder,
        _playerScores = playerScores,
        _players = players,
        _playersNotPlaying = playersNotPlaying,
        _playersPlaying = playersPlaying,
        super._();

  factory _$CheatGameModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheatGameModelImplFromJson(json);

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

  @override
  final String lobbyCode;
  @override
  final User? firstPlayer;
  @override
  final User? handWinner;
  @override
  final int currentIndex;
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
  final User? playerWhoPlayed;
  @override
  final User? potentialWinner;
  @override
  final User? playerWhoCalledCheat;
  @override
  @JsonKey()
  final User? playerWhoGotCards;
  @override
  final bool calledCheat;
  @override
  final int numPlayedPrevious;
  @override
  final int currentFaceValue;
  @override
  final bool isRoundEnd;

  @override
  String toString() {
    return 'CheatGameModel(playerHands: $playerHands, cardsPlayed: $cardsPlayed, turnOrder: $turnOrder, playerScores: $playerScores, lobbyCode: $lobbyCode, firstPlayer: $firstPlayer, handWinner: $handWinner, currentIndex: $currentIndex, players: $players, playersNotPlaying: $playersNotPlaying, playersPlaying: $playersPlaying, gameStatus: $gameStatus, host: $host, playerWhoPlayed: $playerWhoPlayed, potentialWinner: $potentialWinner, playerWhoCalledCheat: $playerWhoCalledCheat, playerWhoGotCards: $playerWhoGotCards, calledCheat: $calledCheat, numPlayedPrevious: $numPlayedPrevious, currentFaceValue: $currentFaceValue, isRoundEnd: $isRoundEnd)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheatGameModelImpl &&
            const DeepCollectionEquality()
                .equals(other._playerHands, _playerHands) &&
            const DeepCollectionEquality()
                .equals(other._cardsPlayed, _cardsPlayed) &&
            const DeepCollectionEquality()
                .equals(other._turnOrder, _turnOrder) &&
            const DeepCollectionEquality()
                .equals(other._playerScores, _playerScores) &&
            (identical(other.lobbyCode, lobbyCode) ||
                other.lobbyCode == lobbyCode) &&
            (identical(other.firstPlayer, firstPlayer) ||
                other.firstPlayer == firstPlayer) &&
            (identical(other.handWinner, handWinner) ||
                other.handWinner == handWinner) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality()
                .equals(other._playersNotPlaying, _playersNotPlaying) &&
            const DeepCollectionEquality()
                .equals(other._playersPlaying, _playersPlaying) &&
            (identical(other.gameStatus, gameStatus) ||
                other.gameStatus == gameStatus) &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.playerWhoPlayed, playerWhoPlayed) ||
                other.playerWhoPlayed == playerWhoPlayed) &&
            (identical(other.potentialWinner, potentialWinner) ||
                other.potentialWinner == potentialWinner) &&
            (identical(other.playerWhoCalledCheat, playerWhoCalledCheat) ||
                other.playerWhoCalledCheat == playerWhoCalledCheat) &&
            (identical(other.playerWhoGotCards, playerWhoGotCards) ||
                other.playerWhoGotCards == playerWhoGotCards) &&
            (identical(other.calledCheat, calledCheat) ||
                other.calledCheat == calledCheat) &&
            (identical(other.numPlayedPrevious, numPlayedPrevious) ||
                other.numPlayedPrevious == numPlayedPrevious) &&
            (identical(other.currentFaceValue, currentFaceValue) ||
                other.currentFaceValue == currentFaceValue) &&
            (identical(other.isRoundEnd, isRoundEnd) ||
                other.isRoundEnd == isRoundEnd));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(_playerHands),
        const DeepCollectionEquality().hash(_cardsPlayed),
        const DeepCollectionEquality().hash(_turnOrder),
        const DeepCollectionEquality().hash(_playerScores),
        lobbyCode,
        firstPlayer,
        handWinner,
        currentIndex,
        const DeepCollectionEquality().hash(_players),
        const DeepCollectionEquality().hash(_playersNotPlaying),
        const DeepCollectionEquality().hash(_playersPlaying),
        gameStatus,
        host,
        playerWhoPlayed,
        potentialWinner,
        playerWhoCalledCheat,
        playerWhoGotCards,
        calledCheat,
        numPlayedPrevious,
        currentFaceValue,
        isRoundEnd
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheatGameModelImplCopyWith<_$CheatGameModelImpl> get copyWith =>
      __$$CheatGameModelImplCopyWithImpl<_$CheatGameModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheatGameModelImplToJson(
      this,
    );
  }
}

abstract class _CheatGameModel extends CheatGameModel {
  factory _CheatGameModel(
      {required final Map<String, List<Card>> playerHands,
      required final List<Card> cardsPlayed,
      required final List<User> turnOrder,
      required final Map<String, int> playerScores,
      required final String lobbyCode,
      required final User? firstPlayer,
      required final User? handWinner,
      required final int currentIndex,
      required final List<User> players,
      required final List<User> playersNotPlaying,
      required final List<User> playersPlaying,
      required final GameStatus gameStatus,
      required final User host,
      required final User? playerWhoPlayed,
      required final User? potentialWinner,
      required final User? playerWhoCalledCheat,
      final User? playerWhoGotCards,
      required final bool calledCheat,
      required final int numPlayedPrevious,
      required final int currentFaceValue,
      required final bool isRoundEnd}) = _$CheatGameModelImpl;
  _CheatGameModel._() : super._();

  factory _CheatGameModel.fromJson(Map<String, dynamic> json) =
      _$CheatGameModelImpl.fromJson;

  @override
  Map<String, List<Card>> get playerHands;
  @override
  List<Card> get cardsPlayed;
  @override
  List<User> get turnOrder;
  @override
  Map<String, int> get playerScores;
  @override
  String get lobbyCode;
  @override
  User? get firstPlayer;
  @override
  User? get handWinner;
  @override
  int get currentIndex;
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
  User? get playerWhoPlayed;
  @override
  User? get potentialWinner;
  @override
  User? get playerWhoCalledCheat;
  @override
  User? get playerWhoGotCards;
  @override
  bool get calledCheat;
  @override
  int get numPlayedPrevious;
  @override
  int get currentFaceValue;
  @override
  bool get isRoundEnd;
  @override
  @JsonKey(ignore: true)
  _$$CheatGameModelImplCopyWith<_$CheatGameModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
