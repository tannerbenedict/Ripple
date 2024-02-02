import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ripple/models/database_models/cheat_game_model.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/database_models/gin_rummy_game_model.dart';
import 'package:ripple/models/database_models/hearts_game_model.dart';
import 'package:ripple/models/database_models/lobby_model.dart';
import 'package:ripple/models/database_models/scum_game_model.dart';
import 'package:ripple/models/game_invite.dart';
import 'package:ripple/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

class DatabaseRepository {
  static const String _userCollectionName = "users";
  static const String _ginRummyCollectionName = "gin_rummy_games";
  static const String _heartsCollectionName = "hearts_games";
  static const String _cheatCollectionName = "cheat_games";
  static const String _scumCollectionName = "scum_games";
  static const String _lobbyCollectionName = "lobbies";
  static const String _gameInviteCollectionName = "game_invites";

  FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseRepository._();

  Future<User?> getUser(String userId) async =>
      await _userCollection().doc(userId).get().then((value) => value.data());

  Future<void> updateUser(User user) async =>
      await _userCollection().doc(user.firebaseId).set(user);

  Future<GinRummyGameModel?> getGinRummyGame(String lobbyCode) async =>
      await _getGinDocRef(lobbyCode).get().then((value) => value.data());

  Future<HeartsGameModel?> getHeartsGame(String lobbyCode) async =>
      await _getHeartsDocRef(lobbyCode).get().then((value) => value.data());

  Future<CheatGameModel?> getCheatGame(String lobbyCode) async =>
      await _getCheatDocRef(lobbyCode).get().then((value) => value.data());

  Future<ScumGameModel?> getScumGame(String lobbyCode) async =>
      await _getScumDocRef(lobbyCode).get().then((value) => value.data());

  Future<LobbyModel?> getLobby(String lobbyCode) async =>
      await _getLobbyDocRef(lobbyCode).get().then((value) => value.data());

  Future<void> updateGinRummyGame(GinRummyGameModel model) async =>
      await _getGinDocRef(model.lobbyCode).set(model);

  Future<GinRummyGameModel> updateGinRummyLobby(
      String lobbyCode, User user, UpdateType update) async {
    await updateLobbyAtomically(
        _ginRummyCollectionName, lobbyCode, update, user);
    return (await _getGinDocRef(lobbyCode).get()).data()!;
  }

  Future<HeartsGameModel> updateHeartsLobby(
      String lobbyCode, User user, UpdateType update) async {
    await updateLobbyAtomically(_heartsCollectionName, lobbyCode, update, user);
    return (await _getHeartsDocRef(lobbyCode).get()).data()!;
  }

  Future<ScumGameModel> updateScumLobby(
      String lobbyCode, User user, UpdateType update) async {
    await updateLobbyAtomically(_scumCollectionName, lobbyCode, update, user);
    return (await _getScumDocRef(lobbyCode).get()).data()!;
  }

  Future<CheatGameModel> updateCheatLobby(
      String lobbyCode, User user, UpdateType update) async {
    await updateLobbyAtomically(_cheatCollectionName, lobbyCode, update, user);
    return (await _getCheatDocRef(lobbyCode).get()).data()!;
  }

  Future<void> updateLobbyAtomically(String collectionName, String lobbyCode,
      UpdateType update, User user) async {
    final docRef = _db.collection(collectionName).doc(lobbyCode);

    if (update == UpdateType.notPlaying) {
      await docRef.update({
        "playersNotPlaying": FieldValue.arrayUnion([user.toJson()]),
        "players": FieldValue.arrayRemove([user.toJson()]),
        "playersPlaying": FieldValue.arrayRemove([user.toJson()]),
      });
    }

    if (update == UpdateType.newPlayer) {
      await docRef.update({
        "players": FieldValue.arrayUnion([user.toJson()]),
        "playersPlaying": FieldValue.arrayUnion([user.toJson()]),
        "playersNotPlaying": FieldValue.arrayRemove([user.toJson()]),
        "gameStatus": GameStatus.inLobby.toJson(),
      });
    }

    if (update == UpdateType.replaying) {
      await docRef.update({
        "playersPlaying": FieldValue.arrayUnion([user.toJson()]),
        "gameStatus": GameStatus.inLobby.toJson(),
        "host": user.toJson()
      });
    }

    if (update == UpdateType.updateHost) {
      await docRef.update({
        "host": user.toJson(),
      });
    }
  }

  Future<void> updateHeartsGame(HeartsGameModel model) async =>
      _db.runTransaction((transaction) async {
        transaction.set(_getHeartsDocRef(model.lobbyCode), model);
      });

  Future<void> updateCheatGame(CheatGameModel model) async =>
      _db.runTransaction((transaction) async {
        transaction.set(_getCheatDocRef(model.lobbyCode), model);
      });

  Future<void> updateScumGame(ScumGameModel model) async =>
      _db.runTransaction((transaction) async {
        transaction.set(_getScumDocRef(model.lobbyCode), model);
      });

  Future<void> updateLobby(LobbyModel model) async =>
      _db.runTransaction((transaction) async {
        transaction.set(_getLobbyDocRef(model.lobbyCode), model);
      });

  Future<void> updateGameInvite(GameInvite invite) async =>
      await _getGameInvitesCollection(invite.toPlayer.firebaseId)
          .doc(invite.inviteId)
          .set(invite);

  Stream<GinRummyGameModel?> watchGinRummyGame(String lobbyCode) =>
      _getGinDocRef(lobbyCode).snapshots().map((event) => event.data());

  Stream<HeartsGameModel?> watchHeartsGame(String lobbyCode) =>
      _getHeartsDocRef(lobbyCode).snapshots().map((element) => element.data());

  Stream<CheatGameModel?> watchCheatGame(String lobbyCode) =>
      _getCheatDocRef(lobbyCode).snapshots().map((element) => element.data());

  Stream<ScumGameModel?> watchScumGame(String lobbyCode) =>
      _getScumDocRef(lobbyCode).snapshots().map((element) => element.data());

  Stream<LobbyModel?> watchLobby(String lobbyCode) =>
      _getLobbyDocRef(lobbyCode).snapshots().map((element) => element.data());

  Stream<List<GameInvite>> watchGameInvites(FirebaseID userId) async* {
    try {
      await for (var snapshot in _getGameInvitesCollection(userId)
          .orderBy("timeStamp", descending: true)
          .where("status", isEqualTo: "pending")
          .snapshots()) {
        final pendingInvites = <GameInvite>[];

        for (final docSnapshot in snapshot.docs) {
          final invite = docSnapshot.data()!;
          if (invite.status == InviteStatus.pending) {
            if (DateTime.now().difference(invite.timeStamp).inMinutes > 10) {
              // TODO: Batch this write
              await _getGameInvitesCollection(userId)
                  .doc(docSnapshot.id)
                  .update({'status': 'expired'});
            } else {
              pendingInvites.add(invite);
            }
          }
        }

        yield pendingInvites;
      }
    } catch (err) {
      print("Error occurred in game invite provider: $err");
    }
  }

  CollectionReference<GameInvite?> _getGameInvitesCollection(
          FirebaseID userId) =>
      _db
          .collection(_gameInviteCollectionName)
          .withConverter(
              fromFirestore: (snapshot, _) =>
                  GameInvite.fromJson(snapshot.data()!),
              toFirestore: (invite, _) => invite.toJson())
          .doc(userId)
          .collection("incoming")
          .withConverter(
              fromFirestore: (snapshot, _) =>
                  GameInvite.fromJson(snapshot.data()!),
              toFirestore: (invite, _) => invite!.toJson());

  DocumentReference<HeartsGameModel> _getHeartsDocRef(String lobbyCode) =>
      _db.collection(_heartsCollectionName).doc(lobbyCode).withConverter(
            fromFirestore: (snapshot, options) =>
                HeartsGameModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );

  DocumentReference<CheatGameModel> _getCheatDocRef(String lobbyCode) =>
      _db.collection(_cheatCollectionName).doc(lobbyCode).withConverter(
            fromFirestore: (snapshot, options) =>
                CheatGameModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );

  DocumentReference<ScumGameModel> _getScumDocRef(String lobbyCode) =>
      _db.collection(_scumCollectionName).doc(lobbyCode).withConverter(
            fromFirestore: (snapshot, options) =>
                ScumGameModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );

  DocumentReference<LobbyModel> _getLobbyDocRef(String lobbyCode) =>
      _db.collection(_lobbyCollectionName).doc(lobbyCode).withConverter(
            fromFirestore: (snapshot, options) =>
                LobbyModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );

  DocumentReference<GinRummyGameModel> _getGinDocRef(String lobbyCode) =>
      _db.collection(_ginRummyCollectionName).doc(lobbyCode).withConverter(
            fromFirestore: (snapshot, options) =>
                GinRummyGameModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );

  Future<void> winSolitare(User user, int moves) async {
    await _userCollection().doc(user.firebaseId).update({
      "coins": FieldValue.increment(1),
      "gamesPlayed": FieldValue.increment(1),
      "gamesWon": FieldValue.increment(1),
      "solitaireGamesPlayed": FieldValue.increment(1),
      "solitaireGamesWon": FieldValue.increment(1),
      "solitaireBestMoves": moves
    });
  }

  Future<void> winGin(User user) async {
    await _userCollection().doc(user.firebaseId).update({
      "coins": FieldValue.increment(1),
      "gamesPlayed": FieldValue.increment(1),
      "gamesWon": FieldValue.increment(1),
      "ginRummyGamesPlayed": FieldValue.increment(1),
      "ginRummyGamesWon": FieldValue.increment(1),
    });
  }

  Future<void> winHearts(User user) async {
    await _userCollection().doc(user.firebaseId).update({
      "coins": FieldValue.increment(1),
      "gamesPlayed": FieldValue.increment(1),
      "gamesWon": FieldValue.increment(1),
      "heartsGamesPlayed": FieldValue.increment(1),
      "heartsGamesWon": FieldValue.increment(1),
    });
  }

  Future<void> winScum(User user) async {
    await _userCollection().doc(user.firebaseId).update({
      "coins": FieldValue.increment(1),
      "gamesPlayed": FieldValue.increment(1),
      "gamesWon": FieldValue.increment(1),
      "scumGamesPlayed": FieldValue.increment(1),
      "scumGamesWon": FieldValue.increment(1),
    });
  }

  Future<void> winCheat(User user) async {
    await _userCollection().doc(user.firebaseId).update({
      "coins": FieldValue.increment(1),
      "gamesPlayed": FieldValue.increment(1),
      "gamesWon": FieldValue.increment(1),
      "cheatGamesPlayed": FieldValue.increment(1),
      "cheatGamesWon": FieldValue.increment(1),
    });
  }

  Future<void> purchaseCardBacks(User user, String cardBack) async {
    await _userCollection().doc(user.firebaseId).update({
      "cardBacks": FieldValue.arrayUnion([cardBack]),
      "coins": FieldValue.increment(-10),
      "selectedCardBack": cardBack,
    });
  }

  Future<void> setCardBack(User user, String cardBack) async {
    await _userCollection().doc(user.firebaseId).update({
      "selectedCardBack": cardBack,
    });
  }

  Future<void> loseSolitaire(User user) async {
    await _userCollection().doc(user.firebaseId).update({
      "gamesPlayed": FieldValue.increment(1),
      "solitaireGamesPlayed": FieldValue.increment(1),
    });
  }

  Future<void> loseGin(User user) async {
    await _userCollection().doc(user.firebaseId).update({
      "gamesPlayed": FieldValue.increment(1),
      "ginGamesPlayed": FieldValue.increment(1),
    });
  }

  Future<void> loseHearts(User user) async {
    await _userCollection().doc(user.firebaseId).update({
      "gamesPlayed": FieldValue.increment(1),
      "heartsGamesPlayed": FieldValue.increment(1),
    });
  }

  Future<void> loseScum(User user) async {
    await _userCollection().doc(user.firebaseId).update({
      "gamesPlayed": FieldValue.increment(1),
      "scumGamesPlayed": FieldValue.increment(1),
    });
  }

  Future<void> loseCheat(User user) async {
    await _userCollection().doc(user.firebaseId).update({
      "gamesPlayed": FieldValue.increment(1),
      "cheatGamesPlayed": FieldValue.increment(1),
    });
  }

  CollectionReference<User> _userCollection() {
    return _db.collection(_userCollectionName).withConverter(
          fromFirestore: (snapshot, options) => User.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }
}

@Riverpod(keepAlive: true)
DatabaseRepository databaseRepository(DatabaseRepositoryRef ref) {
  return DatabaseRepository._();
}
