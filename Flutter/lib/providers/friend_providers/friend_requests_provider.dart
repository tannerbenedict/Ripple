import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ripple/models/friend.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friend_requests_provider.g.dart';
part 'friend_requests_provider.freezed.dart';

@freezed
class FriendRequestForView with _$FriendRequestForView {
  factory FriendRequestForView(
      {required String userId,
      required String displayName,
      String? authorProfileUrl}) = _FriendRequestForView;
}

@riverpod
class FriendRequests extends _$FriendRequests {
  late FirebaseFirestore _db;

  @override
  Stream<List<FriendRequestForView>> build(
      String userId) async* {
    _db = FirebaseFirestore.instance;

    try {
      var docRef = _db
          .collection("friend_requests")
          .doc(userId)
          .collection("incoming")
          .snapshots();
      await for (final snapshot in docRef) {
        var friendRequests =
            snapshot.docs.map((e) => Friend(userId: e.id)).toList();

        var friendIds = friendRequests.map((e) => e.userId);

        List<User> users = [];
        if (friendIds.isNotEmpty) {
          users = (await _db
                  .collection("users")
                  .where("firebaseId", whereIn: friendIds)
                  .get())
              .docs
              .map((e) => User.fromJson(e.data()))
              .toList();
        }

        yield friendRequests
            .map((e) => FriendRequestForView(
                userId: e.userId,
                displayName: users
                        .firstWhere(
                          (element) => e.userId == element.firebaseId,
                        )
                        .displayName ??
                    "Unnamed"))
            .toList();
      }
    } catch (err) {
      print("Error occurred in friend requests provider: $err");
    }
  }

  Future<void> sendRequest(String friendId) async {
    try {
      var docRef = _db
          .collection("friend_requests")
          .doc(userId)
          .collection("outgoing")
          .doc(friendId);

      await docRef.set(Friend(userId: friendId).toJson());

      var friendDocRef = _db
          .collection("friend_requests")
          .doc(friendId)
          .collection("incoming")
          .doc(userId);

      await friendDocRef.set(Friend(userId: userId).toJson());
    } catch (err) {
      print("Error occurred sending friend request: $err");
    }
  }

  Future<int> sendRequestByEmail(String friendEmail) async {
    var users = (await _db
            .collection("users")
            .where("email", isEqualTo: friendEmail)
            .get())
        .docs
        .map((e) => User.fromJson(e.data()))
        .toList();

    if (users.isEmpty) {
      return 1;
    } else {
      var friend = users.first;

      // check to see if it not the user's own email
      var user = ref.read(loginInfoProvider).user;
      if (friend.email == user!.email) {
        return 1;
      }

      // check to see if they're already friends
      var checkFriendsDocRef = _db
          .collection("friend_list")
          .doc(userId)
          .collection("friends")
          .doc(friend.firebaseId);

      var checkFriendsDocSnapshot = await checkFriendsDocRef.get();

      // already friends
      if (checkFriendsDocSnapshot.exists) {
        return 2;
      }

      var docRef = _db
          .collection("friend_requests")
          .doc(userId)
          .collection("outgoing")
          .doc(friend.firebaseId);

      await docRef.set(Friend(userId: friend.firebaseId).toJson());

      var friendDocRef = _db
          .collection("friend_requests")
          .doc(friend.firebaseId)
          .collection("incoming")
          .doc(userId);

      await friendDocRef.set(Friend(userId: userId).toJson());

      return 0;
    }
  }

  Future<void> cancelRequest(String friendId) async {
    var docRef = _db
        .collection("friend_requests")
        .doc(userId)
        .collection("outgoing")
        .doc(friendId);

    await docRef.delete();

    var friendDocRef = _db
        .collection("friend_list")
        .doc(friendId)
        .collection("incoming")
        .doc(userId);

    await friendDocRef.delete();
  }

  Future<void> ignoreRequest(String friendId) async {
    var docRef = _db
        .collection("friend_requests")
        .doc(userId)
        .collection("incoming")
        .doc(friendId);

    await docRef.delete();

    var friendDocRef = _db
        .collection("friend_requests")
        .doc(friendId)
        .collection("outgoing")
        .doc(userId);

    await friendDocRef.delete();
  }
}
