import 'package:ripple/globals.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:random_name_generator/random_name_generator.dart';

part 'user.g.dart';
part 'user.freezed.dart';

extension Truncation on String {
  String truncate({int maxLength = 15}) =>
      length > maxLength ? '${substring(0, maxLength)}...' : this;
}

@Freezed(equal: false)
class User with _$User {
  User._();

  factory User({
    required String firebaseId,
    String? displayName,
    String? email,
    String? profileUrl,
    required int coins,
    required List<String> cardBacks,
    required String selectedCardBack,
    required int gamesPlayed,
    required int gamesWon,
    required int twoPlayerGamesPlayed,
    required int twoPlayerGamesWon,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromFirebaseUser(firebase_auth.User user) {
    return User(
        firebaseId: user.uid,
        displayName: user.displayName,
        email: user.email,
        profileUrl: user.photoURL,
        coins: coins,
        cardBacks: purchased,
        selectedCardBack: cardBack,
        gamesPlayed: gp,
        gamesWon: gw,
        twoPlayerGamesPlayed: twogp,
        twoPlayerGamesWon: twogw,);
  }

  factory User.defaultPlayer() {
    return User(
        firebaseId: "player",
        displayName: "You",
        email: "",
        profileUrl: "",
        coins: 0,
        cardBacks: [],
        selectedCardBack: "",
        gamesPlayed: 0,
        gamesWon: 0,
        twoPlayerGamesPlayed: 0,
        twoPlayerGamesWon: 0,);
  }

  factory User.getRealOrDefaultUser(firebase_auth.User? user) {
    return user == null ? User.defaultPlayer() : User.fromFirebaseUser(user);
  }

  factory User.defaultBot(int num) {
    var randomNames = RandomNames(Zone.us);
    var nameList = [
      randomNames.name(),
      randomNames.name(),
      randomNames.name(),
      randomNames.name(),
      randomNames.name(),
      randomNames.name(),
      randomNames.name()
    ];
    return User(
        firebaseId: "bot$num",
        displayName: nameList[num],
        email: "",
        profileUrl: "",
        coins: 0,
        cardBacks: [],
        selectedCardBack: "",
        gamesPlayed: 0,
        gamesWon: 0,
        twoPlayerGamesPlayed: 0,
        twoPlayerGamesWon: 0,);
  }

  bool get isBot => firebaseId.contains("bot");

  @override
  operator ==(Object other) {
    if (other is User) {
      return other.firebaseId == firebaseId;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => firebaseId.hashCode;
}
