import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ripple/models/database_models/two_player_game_model.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/database_models/lobby_model.dart';
import 'package:ripple/models/game_invite.dart';
import 'package:ripple/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

class DatabaseRepository {
  static const String _userCollectionName = "users";
  static const String _twoPlayerCollectionName = "two_player_games";
  static const String _lobbyCollectionName = "lobbies";
  static const String _gameInviteCollectionName = "game_invites";

  FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseRepository._();

  Future<User?> getUser(String userId) async =>
      await _userCollection().doc(userId).get().then((value) => value.data());

  Future<void> updateUser(User user) async =>
      await _userCollection().doc(user.firebaseId).set(user);

  Future<TwoPlayerGameModel?> getTwoPlayerGame(String lobbyCode) async =>
      await _getTwoPlayerDocRef(lobbyCode).get().then((value) => value.data());

  Future<LobbyModel?> getLobby(String lobbyCode) async =>
      await _getLobbyDocRef(lobbyCode).get().then((value) => value.data());

  Future<void> updateTwoPlayerGame(TwoPlayerGameModel model) async =>
      await _getTwoPlayerDocRef(model.lobbyCode).set(model);

  Future<TwoPlayerGameModel> updateTwoPlayerLobby(
      String lobbyCode, User user, UpdateType update) async {
    await updateLobbyAtomically(
        _twoPlayerCollectionName, lobbyCode, update, user);
    return (await _getTwoPlayerDocRef(lobbyCode).get()).data()!;
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

  Future<void> updateLobby(LobbyModel model) async =>
      _db.runTransaction((transaction) async {
        transaction.set(_getLobbyDocRef(model.lobbyCode), model);
      });

  Future<void> updateGameInvite(GameInvite invite) async =>
      await _getGameInvitesCollection(invite.toPlayer.firebaseId)
          .doc(invite.inviteId)
          .set(invite);

  Stream<TwoPlayerGameModel?> watchTwoPlayerGame(String lobbyCode) =>
      _getTwoPlayerDocRef(lobbyCode).snapshots().map((event) => event.data());

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

  DocumentReference<LobbyModel> _getLobbyDocRef(String lobbyCode) =>
      _db.collection(_lobbyCollectionName).doc(lobbyCode).withConverter(
            fromFirestore: (snapshot, options) =>
                LobbyModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );

  DocumentReference<TwoPlayerGameModel> _getTwoPlayerDocRef(String lobbyCode) =>
      _db.collection(_twoPlayerCollectionName).doc(lobbyCode).withConverter(
            fromFirestore: (snapshot, options) =>
                TwoPlayerGameModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );

  

  Future<void> winTwoPlayer(User user) async {
    await _userCollection().doc(user.firebaseId).update({
      "coins": FieldValue.increment(1),
      "gamesPlayed": FieldValue.increment(1),
      "gamesWon": FieldValue.increment(1),
      "twoPlayerGamesPlayed": FieldValue.increment(1),
      "twoPlayerGamesWon": FieldValue.increment(1),
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


  Future<void> loseTwoPlayer(User user) async {
    await _userCollection().doc(user.firebaseId).update({
      "gamesPlayed": FieldValue.increment(1),
      "TwoPlayerGamesPlayed": FieldValue.increment(1),
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
