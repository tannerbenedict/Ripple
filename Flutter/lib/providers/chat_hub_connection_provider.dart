import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/chat_message.dart';

part 'chat_hub_connection_provider.g.dart';
part 'chat_hub_connection_provider.freezed.dart';

@freezed
class ChatMessageForView with _$ChatMessageForView {
  factory ChatMessageForView(
      {required String message,
      required String authorName,
      required String authorId,
      String? authorProfileUrl}) = _ChatMessageForView;
}

@riverpod
class ChatHubConnection extends _$ChatHubConnection {
  late String _lobbyCode;
  late FirebaseFirestore _db;

  @override
  Stream<List<ChatMessageForView>> build(String lobbyCode) async* {
    _lobbyCode = lobbyCode;
    _db = FirebaseFirestore.instance;

    var docRef = _db
        .collection("chat_rooms")
        .doc(lobbyCode)
        .collection("messages")
        .orderBy("sentAt", descending: false)
        .limitToLast(30)
        .snapshots();
    await for (final snapshot in docRef) {
      var messages =
          snapshot.docs.map((e) => ChatMessage.fromJson(e.data())).toList();

      var authorIds = messages.map((e) => e.authorId);

      List<User> users = [];
      if (authorIds.isNotEmpty) {
        users = (await _db
                .collection("users")
                .where("firebaseId", whereIn: authorIds)
                .get())
            .docs
            .map((e) => User.fromJson(e.data()))
            .toList();
      }

      yield messages
          .map((e) => ChatMessageForView(
              message: e.message,
              authorId: e.authorId,
              authorName: users
                      .firstWhere(
                        (element) => e.authorId == element.firebaseId,
                      )
                      .displayName ??
                  "Unnamed"))
          .toList();
    }
  }

  Future<void> sendMessage(String message) async {
    var user = ref.read(loginInfoProvider).user;

    var docRef =
        _db.collection("chat_rooms").doc(_lobbyCode).collection("messages");
    await docRef.add(ChatMessage(
            message: message,
            authorId: user?.uid ?? "none",
            sentAt: DateTime.now())
        .toJson());
  }
}
