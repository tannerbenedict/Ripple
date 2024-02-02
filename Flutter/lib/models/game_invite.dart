import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_invite.freezed.dart';
part 'game_invite.g.dart';

enum InviteStatus {
  pending,
  accepted,
  expired,
  declined,
}

@freezed
class GameInvite with _$GameInvite {
  const factory GameInvite({
    required String inviteId,
    required User fromPlayer,
    required User toPlayer,
    required String lobbyCode,
    required DateTime timeStamp,
    required InviteStatus status,
    required GameType gameType,
  }) = _GameInvite;

  factory GameInvite.fromJson(Map<String, dynamic> json) =>
      _$GameInviteFromJson(json);

  const GameInvite._();
}
