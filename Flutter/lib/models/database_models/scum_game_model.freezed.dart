// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scum_game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CardPlayEntry _$CardPlayEntryFromJson(Map<String, dynamic> json) {
  return _CardPlayEntry.fromJson(json);
}

/// @nodoc
mixin _$CardPlayEntry {
  String get playerID => throw _privateConstructorUsedError;
  List<Card> get cards => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CardPlayEntryCopyWith<CardPlayEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardPlayEntryCopyWith<$Res> {
  factory $CardPlayEntryCopyWith(
          CardPlayEntry value, $Res Function(CardPlayEntry) then) =
      _$CardPlayEntryCopyWithImpl<$Res, CardPlayEntry>;
  @useResult
  $Res call({String playerID, List<Card> cards});
}

/// @nodoc
class _$CardPlayEntryCopyWithImpl<$Res, $Val extends CardPlayEntry>
    implements $CardPlayEntryCopyWith<$Res> {
  _$CardPlayEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerID = null,
    Object? cards = null,
  }) {
    return _then(_value.copyWith(
      playerID: null == playerID
          ? _value.playerID
          : playerID // ignore: cast_nullable_to_non_nullable
              as String,
      cards: null == cards
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<Card>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CardPlayEntryImplCopyWith<$Res>
    implements $CardPlayEntryCopyWith<$Res> {
  factory _$$CardPlayEntryImplCopyWith(
          _$CardPlayEntryImpl value, $Res Function(_$CardPlayEntryImpl) then) =
      __$$CardPlayEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String playerID, List<Card> cards});
}

/// @nodoc
class __$$CardPlayEntryImplCopyWithImpl<$Res>
    extends _$CardPlayEntryCopyWithImpl<$Res, _$CardPlayEntryImpl>
    implements _$$CardPlayEntryImplCopyWith<$Res> {
  __$$CardPlayEntryImplCopyWithImpl(
      _$CardPlayEntryImpl _value, $Res Function(_$CardPlayEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerID = null,
    Object? cards = null,
  }) {
    return _then(_$CardPlayEntryImpl(
      playerID: null == playerID
          ? _value.playerID
          : playerID // ignore: cast_nullable_to_non_nullable
              as String,
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<Card>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CardPlayEntryImpl implements _CardPlayEntry {
  _$CardPlayEntryImpl({required this.playerID, required final List<Card> cards})
      : _cards = cards;

  factory _$CardPlayEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CardPlayEntryImplFromJson(json);

  @override
  final String playerID;
  final List<Card> _cards;
  @override
  List<Card> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  String toString() {
    return 'CardPlayEntry(playerID: $playerID, cards: $cards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardPlayEntryImpl &&
            (identical(other.playerID, playerID) ||
                other.playerID == playerID) &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, playerID, const DeepCollectionEquality().hash(_cards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CardPlayEntryImplCopyWith<_$CardPlayEntryImpl> get copyWith =>
      __$$CardPlayEntryImplCopyWithImpl<_$CardPlayEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CardPlayEntryImplToJson(
      this,
    );
  }
}

abstract class _CardPlayEntry implements CardPlayEntry {
  factory _CardPlayEntry(
      {required final String playerID,
      required final List<Card> cards}) = _$CardPlayEntryImpl;

  factory _CardPlayEntry.fromJson(Map<String, dynamic> json) =
      _$CardPlayEntryImpl.fromJson;

  @override
  String get playerID;
  @override
  List<Card> get cards;
  @override
  @JsonKey(ignore: true)
  _$$CardPlayEntryImplCopyWith<_$CardPlayEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScumGameModel _$ScumGameModelFromJson(Map<String, dynamic> json) {
  return _ScumGameModel.fromJson(json);
}

/// @nodoc
mixin _$ScumGameModel {
  Map<String, List<Card>> get playerHands => throw _privateConstructorUsedError;
  Map<String, bool> get playerPassed => throw _privateConstructorUsedError;
  List<CardPlayEntry> get cardsPlayed => throw _privateConstructorUsedError;
  List<User> get turnOrder => throw _privateConstructorUsedError;
  Map<String, int> get playerScores => throw _privateConstructorUsedError;
  String get lobbyCode => throw _privateConstructorUsedError;
  User? get firstPlayer => throw _privateConstructorUsedError;
  User? get roundWinner => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  List<User> get players => throw _privateConstructorUsedError;
  List<User> get playersNotPlaying => throw _privateConstructorUsedError;
  List<User> get playersPlaying => throw _privateConstructorUsedError;
  GameStatus get gameStatus => throw _privateConstructorUsedError;
  User get host => throw _privateConstructorUsedError;
  bool get isRoundEnd => throw _privateConstructorUsedError;
  bool get isTrickEnd => throw _privateConstructorUsedError;
  User? get trickWinner => throw _privateConstructorUsedError;
  List<User> get finishedOrder => throw _privateConstructorUsedError;
  int get roundNumber => throw _privateConstructorUsedError;
  Map<String, PlayerPosition> get positions =>
      throw _privateConstructorUsedError;
  List<User> get lastPlayed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScumGameModelCopyWith<ScumGameModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScumGameModelCopyWith<$Res> {
  factory $ScumGameModelCopyWith(
          ScumGameModel value, $Res Function(ScumGameModel) then) =
      _$ScumGameModelCopyWithImpl<$Res, ScumGameModel>;
  @useResult
  $Res call(
      {Map<String, List<Card>> playerHands,
      Map<String, bool> playerPassed,
      List<CardPlayEntry> cardsPlayed,
      List<User> turnOrder,
      Map<String, int> playerScores,
      String lobbyCode,
      User? firstPlayer,
      User? roundWinner,
      int currentIndex,
      List<User> players,
      List<User> playersNotPlaying,
      List<User> playersPlaying,
      GameStatus gameStatus,
      User host,
      bool isRoundEnd,
      bool isTrickEnd,
      User? trickWinner,
      List<User> finishedOrder,
      int roundNumber,
      Map<String, PlayerPosition> positions,
      List<User> lastPlayed});

  $UserCopyWith<$Res>? get firstPlayer;
  $UserCopyWith<$Res>? get roundWinner;
  $UserCopyWith<$Res> get host;
  $UserCopyWith<$Res>? get trickWinner;
}

/// @nodoc
class _$ScumGameModelCopyWithImpl<$Res, $Val extends ScumGameModel>
    implements $ScumGameModelCopyWith<$Res> {
  _$ScumGameModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerHands = null,
    Object? playerPassed = null,
    Object? cardsPlayed = null,
    Object? turnOrder = null,
    Object? playerScores = null,
    Object? lobbyCode = null,
    Object? firstPlayer = freezed,
    Object? roundWinner = freezed,
    Object? currentIndex = null,
    Object? players = null,
    Object? playersNotPlaying = null,
    Object? playersPlaying = null,
    Object? gameStatus = null,
    Object? host = null,
    Object? isRoundEnd = null,
    Object? isTrickEnd = null,
    Object? trickWinner = freezed,
    Object? finishedOrder = null,
    Object? roundNumber = null,
    Object? positions = null,
    Object? lastPlayed = null,
  }) {
    return _then(_value.copyWith(
      playerHands: null == playerHands
          ? _value.playerHands
          : playerHands // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Card>>,
      playerPassed: null == playerPassed
          ? _value.playerPassed
          : playerPassed // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      cardsPlayed: null == cardsPlayed
          ? _value.cardsPlayed
          : cardsPlayed // ignore: cast_nullable_to_non_nullable
              as List<CardPlayEntry>,
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
      roundWinner: freezed == roundWinner
          ? _value.roundWinner
          : roundWinner // ignore: cast_nullable_to_non_nullable
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
      isRoundEnd: null == isRoundEnd
          ? _value.isRoundEnd
          : isRoundEnd // ignore: cast_nullable_to_non_nullable
              as bool,
      isTrickEnd: null == isTrickEnd
          ? _value.isTrickEnd
          : isTrickEnd // ignore: cast_nullable_to_non_nullable
              as bool,
      trickWinner: freezed == trickWinner
          ? _value.trickWinner
          : trickWinner // ignore: cast_nullable_to_non_nullable
              as User?,
      finishedOrder: null == finishedOrder
          ? _value.finishedOrder
          : finishedOrder // ignore: cast_nullable_to_non_nullable
              as List<User>,
      roundNumber: null == roundNumber
          ? _value.roundNumber
          : roundNumber // ignore: cast_nullable_to_non_nullable
              as int,
      positions: null == positions
          ? _value.positions
          : positions // ignore: cast_nullable_to_non_nullable
              as Map<String, PlayerPosition>,
      lastPlayed: null == lastPlayed
          ? _value.lastPlayed
          : lastPlayed // ignore: cast_nullable_to_non_nullable
              as List<User>,
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
  $UserCopyWith<$Res>? get roundWinner {
    if (_value.roundWinner == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.roundWinner!, (value) {
      return _then(_value.copyWith(roundWinner: value) as $Val);
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
  $UserCopyWith<$Res>? get trickWinner {
    if (_value.trickWinner == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.trickWinner!, (value) {
      return _then(_value.copyWith(trickWinner: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScumGameModelImplCopyWith<$Res>
    implements $ScumGameModelCopyWith<$Res> {
  factory _$$ScumGameModelImplCopyWith(
          _$ScumGameModelImpl value, $Res Function(_$ScumGameModelImpl) then) =
      __$$ScumGameModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, List<Card>> playerHands,
      Map<String, bool> playerPassed,
      List<CardPlayEntry> cardsPlayed,
      List<User> turnOrder,
      Map<String, int> playerScores,
      String lobbyCode,
      User? firstPlayer,
      User? roundWinner,
      int currentIndex,
      List<User> players,
      List<User> playersNotPlaying,
      List<User> playersPlaying,
      GameStatus gameStatus,
      User host,
      bool isRoundEnd,
      bool isTrickEnd,
      User? trickWinner,
      List<User> finishedOrder,
      int roundNumber,
      Map<String, PlayerPosition> positions,
      List<User> lastPlayed});

  @override
  $UserCopyWith<$Res>? get firstPlayer;
  @override
  $UserCopyWith<$Res>? get roundWinner;
  @override
  $UserCopyWith<$Res> get host;
  @override
  $UserCopyWith<$Res>? get trickWinner;
}

/// @nodoc
class __$$ScumGameModelImplCopyWithImpl<$Res>
    extends _$ScumGameModelCopyWithImpl<$Res, _$ScumGameModelImpl>
    implements _$$ScumGameModelImplCopyWith<$Res> {
  __$$ScumGameModelImplCopyWithImpl(
      _$ScumGameModelImpl _value, $Res Function(_$ScumGameModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerHands = null,
    Object? playerPassed = null,
    Object? cardsPlayed = null,
    Object? turnOrder = null,
    Object? playerScores = null,
    Object? lobbyCode = null,
    Object? firstPlayer = freezed,
    Object? roundWinner = freezed,
    Object? currentIndex = null,
    Object? players = null,
    Object? playersNotPlaying = null,
    Object? playersPlaying = null,
    Object? gameStatus = null,
    Object? host = null,
    Object? isRoundEnd = null,
    Object? isTrickEnd = null,
    Object? trickWinner = freezed,
    Object? finishedOrder = null,
    Object? roundNumber = null,
    Object? positions = null,
    Object? lastPlayed = null,
  }) {
    return _then(_$ScumGameModelImpl(
      playerHands: null == playerHands
          ? _value._playerHands
          : playerHands // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Card>>,
      playerPassed: null == playerPassed
          ? _value._playerPassed
          : playerPassed // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      cardsPlayed: null == cardsPlayed
          ? _value._cardsPlayed
          : cardsPlayed // ignore: cast_nullable_to_non_nullable
              as List<CardPlayEntry>,
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
      roundWinner: freezed == roundWinner
          ? _value.roundWinner
          : roundWinner // ignore: cast_nullable_to_non_nullable
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
      isRoundEnd: null == isRoundEnd
          ? _value.isRoundEnd
          : isRoundEnd // ignore: cast_nullable_to_non_nullable
              as bool,
      isTrickEnd: null == isTrickEnd
          ? _value.isTrickEnd
          : isTrickEnd // ignore: cast_nullable_to_non_nullable
              as bool,
      trickWinner: freezed == trickWinner
          ? _value.trickWinner
          : trickWinner // ignore: cast_nullable_to_non_nullable
              as User?,
      finishedOrder: null == finishedOrder
          ? _value._finishedOrder
          : finishedOrder // ignore: cast_nullable_to_non_nullable
              as List<User>,
      roundNumber: null == roundNumber
          ? _value.roundNumber
          : roundNumber // ignore: cast_nullable_to_non_nullable
              as int,
      positions: null == positions
          ? _value._positions
          : positions // ignore: cast_nullable_to_non_nullable
              as Map<String, PlayerPosition>,
      lastPlayed: null == lastPlayed
          ? _value._lastPlayed
          : lastPlayed // ignore: cast_nullable_to_non_nullable
              as List<User>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScumGameModelImpl extends _ScumGameModel {
  _$ScumGameModelImpl(
      {required final Map<String, List<Card>> playerHands,
      required final Map<String, bool> playerPassed,
      required final List<CardPlayEntry> cardsPlayed,
      required final List<User> turnOrder,
      required final Map<String, int> playerScores,
      required this.lobbyCode,
      required this.firstPlayer,
      required this.roundWinner,
      required this.currentIndex,
      required final List<User> players,
      required final List<User> playersNotPlaying,
      required final List<User> playersPlaying,
      required this.gameStatus,
      required this.host,
      required this.isRoundEnd,
      required this.isTrickEnd,
      required this.trickWinner,
      required final List<User> finishedOrder,
      required this.roundNumber,
      required final Map<String, PlayerPosition> positions,
      required final List<User> lastPlayed})
      : _playerHands = playerHands,
        _playerPassed = playerPassed,
        _cardsPlayed = cardsPlayed,
        _turnOrder = turnOrder,
        _playerScores = playerScores,
        _players = players,
        _playersNotPlaying = playersNotPlaying,
        _playersPlaying = playersPlaying,
        _finishedOrder = finishedOrder,
        _positions = positions,
        _lastPlayed = lastPlayed,
        super._();

  factory _$ScumGameModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScumGameModelImplFromJson(json);

  final Map<String, List<Card>> _playerHands;
  @override
  Map<String, List<Card>> get playerHands {
    if (_playerHands is EqualUnmodifiableMapView) return _playerHands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerHands);
  }

  final Map<String, bool> _playerPassed;
  @override
  Map<String, bool> get playerPassed {
    if (_playerPassed is EqualUnmodifiableMapView) return _playerPassed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerPassed);
  }

  final List<CardPlayEntry> _cardsPlayed;
  @override
  List<CardPlayEntry> get cardsPlayed {
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
  final User? roundWinner;
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
  final bool isRoundEnd;
  @override
  final bool isTrickEnd;
  @override
  final User? trickWinner;
  final List<User> _finishedOrder;
  @override
  List<User> get finishedOrder {
    if (_finishedOrder is EqualUnmodifiableListView) return _finishedOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_finishedOrder);
  }

  @override
  final int roundNumber;
  final Map<String, PlayerPosition> _positions;
  @override
  Map<String, PlayerPosition> get positions {
    if (_positions is EqualUnmodifiableMapView) return _positions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_positions);
  }

  final List<User> _lastPlayed;
  @override
  List<User> get lastPlayed {
    if (_lastPlayed is EqualUnmodifiableListView) return _lastPlayed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lastPlayed);
  }

  @override
  String toString() {
    return 'ScumGameModel(playerHands: $playerHands, playerPassed: $playerPassed, cardsPlayed: $cardsPlayed, turnOrder: $turnOrder, playerScores: $playerScores, lobbyCode: $lobbyCode, firstPlayer: $firstPlayer, roundWinner: $roundWinner, currentIndex: $currentIndex, players: $players, playersNotPlaying: $playersNotPlaying, playersPlaying: $playersPlaying, gameStatus: $gameStatus, host: $host, isRoundEnd: $isRoundEnd, isTrickEnd: $isTrickEnd, trickWinner: $trickWinner, finishedOrder: $finishedOrder, roundNumber: $roundNumber, positions: $positions, lastPlayed: $lastPlayed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScumGameModelImpl &&
            const DeepCollectionEquality()
                .equals(other._playerHands, _playerHands) &&
            const DeepCollectionEquality()
                .equals(other._playerPassed, _playerPassed) &&
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
            (identical(other.roundWinner, roundWinner) ||
                other.roundWinner == roundWinner) &&
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
            (identical(other.isRoundEnd, isRoundEnd) ||
                other.isRoundEnd == isRoundEnd) &&
            (identical(other.isTrickEnd, isTrickEnd) ||
                other.isTrickEnd == isTrickEnd) &&
            (identical(other.trickWinner, trickWinner) ||
                other.trickWinner == trickWinner) &&
            const DeepCollectionEquality()
                .equals(other._finishedOrder, _finishedOrder) &&
            (identical(other.roundNumber, roundNumber) ||
                other.roundNumber == roundNumber) &&
            const DeepCollectionEquality()
                .equals(other._positions, _positions) &&
            const DeepCollectionEquality()
                .equals(other._lastPlayed, _lastPlayed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(_playerHands),
        const DeepCollectionEquality().hash(_playerPassed),
        const DeepCollectionEquality().hash(_cardsPlayed),
        const DeepCollectionEquality().hash(_turnOrder),
        const DeepCollectionEquality().hash(_playerScores),
        lobbyCode,
        firstPlayer,
        roundWinner,
        currentIndex,
        const DeepCollectionEquality().hash(_players),
        const DeepCollectionEquality().hash(_playersNotPlaying),
        const DeepCollectionEquality().hash(_playersPlaying),
        gameStatus,
        host,
        isRoundEnd,
        isTrickEnd,
        trickWinner,
        const DeepCollectionEquality().hash(_finishedOrder),
        roundNumber,
        const DeepCollectionEquality().hash(_positions),
        const DeepCollectionEquality().hash(_lastPlayed)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScumGameModelImplCopyWith<_$ScumGameModelImpl> get copyWith =>
      __$$ScumGameModelImplCopyWithImpl<_$ScumGameModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScumGameModelImplToJson(
      this,
    );
  }
}

abstract class _ScumGameModel extends ScumGameModel {
  factory _ScumGameModel(
      {required final Map<String, List<Card>> playerHands,
      required final Map<String, bool> playerPassed,
      required final List<CardPlayEntry> cardsPlayed,
      required final List<User> turnOrder,
      required final Map<String, int> playerScores,
      required final String lobbyCode,
      required final User? firstPlayer,
      required final User? roundWinner,
      required final int currentIndex,
      required final List<User> players,
      required final List<User> playersNotPlaying,
      required final List<User> playersPlaying,
      required final GameStatus gameStatus,
      required final User host,
      required final bool isRoundEnd,
      required final bool isTrickEnd,
      required final User? trickWinner,
      required final List<User> finishedOrder,
      required final int roundNumber,
      required final Map<String, PlayerPosition> positions,
      required final List<User> lastPlayed}) = _$ScumGameModelImpl;
  _ScumGameModel._() : super._();

  factory _ScumGameModel.fromJson(Map<String, dynamic> json) =
      _$ScumGameModelImpl.fromJson;

  @override
  Map<String, List<Card>> get playerHands;
  @override
  Map<String, bool> get playerPassed;
  @override
  List<CardPlayEntry> get cardsPlayed;
  @override
  List<User> get turnOrder;
  @override
  Map<String, int> get playerScores;
  @override
  String get lobbyCode;
  @override
  User? get firstPlayer;
  @override
  User? get roundWinner;
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
  bool get isRoundEnd;
  @override
  bool get isTrickEnd;
  @override
  User? get trickWinner;
  @override
  List<User> get finishedOrder;
  @override
  int get roundNumber;
  @override
  Map<String, PlayerPosition> get positions;
  @override
  List<User> get lastPlayed;
  @override
  @JsonKey(ignore: true)
  _$$ScumGameModelImplCopyWith<_$ScumGameModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
