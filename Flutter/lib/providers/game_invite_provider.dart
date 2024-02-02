import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/game_invite.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/database_provider.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'game_invite_provider.g.dart';

@riverpod
class GameInvites extends _$GameInvites {
  @override
  Stream<List<GameInvite>> build(String userId) {
    return ref.watch(databaseRepositoryProvider).watchGameInvites(userId);
  }

  Future<void> sendInvite(
      String friendId, String lobbyCode, GameType type) async {
    try {
      // add to friend's incoming list
      final db = ref.read(databaseRepositoryProvider);

      final currentUser = ref.read(loginInfoProvider).user;
      assert(
          currentUser != null, "You must be logged in to send a game invite!");
      final from = User.fromFirebaseUser(currentUser!);
      final to = await db.getUser(friendId);
      assert(to != null, "Friend not found!");

      await db.updateGameInvite(GameInvite(
          inviteId: Uuid().v4(),
          fromPlayer: from,
          toPlayer: to!,
          lobbyCode: lobbyCode,
          timeStamp: DateTime.now(),
          status: InviteStatus.pending,
          gameType: type));
    } catch (err) {
      print("Error occurred sending game invite: $err");
    }
  }

  Future<void> acceptInvite(GameInvite invite) async {
    try {
      await ref
          .read(databaseRepositoryProvider)
          .updateGameInvite(invite.copyWith(status: InviteStatus.accepted));
    } catch (err) {
      print("Error accepting invite: $err");
    }
  }

  Future<void> declineInvite(GameInvite invite) async {
    try {
      await ref
          .read(databaseRepositoryProvider)
          .updateGameInvite(invite.copyWith(status: InviteStatus.declined));
    } catch (err) {
      print("Error accepting invite: $err");
    }
  }
}
