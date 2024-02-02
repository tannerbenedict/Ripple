import 'package:ripple/providers/database_provider.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user.dart' as user_model;

part 'login_info_provider.freezed.dart';
part 'login_info_provider.g.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState({required User? user}) = _AppState;
}

@Riverpod(keepAlive: true)
class LoginInfo extends _$LoginInfo {
  @override
  LoginState build() {
    FirebaseAuth.instance.userChanges().listen((user) => setUser(user));
    return LoginState(user: FirebaseAuth.instance.currentUser);
  }

  void setUser(User? user) {
    state = state.copyWith(user: user);
  }

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> updateUsername(String username) async {
    if (state.user == null) {
      throw UserRequiredError();
    }
    await state.user!.updateDisplayName(username);
    await ref.read(databaseRepositoryProvider).updateUser(
        user_model.User.fromFirebaseUser(state.user!)
            .copyWith(displayName: username));
  }

  Future<void> signUp(String email, String password) async {
    final creds = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await creds.user!.updateDisplayName(email);
    await ref.read(databaseRepositoryProvider).updateUser(
        user_model.User.fromFirebaseUser(state.user!).copyWith(
            displayName: email,
            coins: 10,
            cardBacks: ["images/cardBack.png"],
            selectedCardBack: "images/cardBack.png",
            gamesPlayed: 0,
            gamesWon: 0,
            solitaireGamesPlayed: 0,
            solitaireGamesWon: 0,
            ginRummyGamesPlayed: 0,
            ginRummyGamesWon: 0,
            heartsGamesPlayed: 0,
            heartsGamesWon: 0,
            scumGamesPlayed: 0,
            scumGamesWon: 0,
            cheatGamesPlayed: 0,
            cheatGamesWon: 0,
            solitaireBestMoves: 0));
  }
}
