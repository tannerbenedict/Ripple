import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ripple/models/friend.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user.dart';

part 'friends_provider.g.dart';
part 'friends_provider.freezed.dart';

@freezed
class FriendForView with _$FriendForView {
  factory FriendForView(
      {required String userId,
      required String displayName,
      String? authorProfileUrl}) = _FriendForView;
}

@riverpod
class Friends extends _$Friends {
  late FirebaseFirestore _db;

  @override
  Stream<List<FriendForView>> build(String userId) async* {
    _db = FirebaseFirestore.instance;

    try {
      var docRef = _db
          .collection("friend_list")
          .doc(userId)
          .collection("friends")
          .snapshots();

      await for (final snapshot in docRef) {
        var friends = snapshot.docs
            .map((e) => Friend(
                userId: e.id)) // friend's user ID is the document ID
            .toList();

        var friendIds = friends.map((e) => e.userId);

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

          yield friends
          .map((e) => FriendForView(
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
      print("Error occurred in friends provider: $err");
    }
  }

  Future<void> addFriend(String friendId) async {

    // initializing here in case a friend request is accepted before this 'build' method is called for the friends list
     _db = FirebaseFirestore.instance;

    var docRef = _db
        .collection("friend_list")
        .doc(userId)
        .collection("friends")
        .doc(friendId);

    await docRef.set(Friend(userId: friendId).toJson());

    var friendDocRef = _db
        .collection("friend_list")
        .doc(friendId)
        .collection("friends")
        .doc(userId);

    await friendDocRef.set(Friend(userId: userId).toJson());
  }

  Future<void> removeFriend(String friendId) async {

    var docRef = _db
        .collection("friend_list")
        .doc(userId)
        .collection("friends")
        .doc(friendId);

    await docRef.delete();

    var friendDocRef = _db
        .collection("friend_list")
        .doc(friendId)
        .collection("friends")
        .doc(userId);

    await friendDocRef.delete();
  }
}
