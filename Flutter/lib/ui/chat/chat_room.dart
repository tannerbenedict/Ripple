import 'package:ripple/ui/chat/message_input.dart';
import 'package:ripple/ui/chat/message_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatRoom extends ConsumerWidget {
  static const routeName = "chatHub";
  static const lobbyCodeKey = "lobbyCode";

  final String _lobbyCode;
  final String _user;
  const ChatRoom(this._lobbyCode, this._user);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final availableHeight = screenHeight - keyboardHeight;

    return Dialog(
      insetPadding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back_ios_new),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Chat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ]),
          Expanded(
            child: SizedBox(
              height: availableHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: MessageList(_lobbyCode, _user),
                  ),
                  Flexible(
                    flex: 1,
                    child: MessageInput(_lobbyCode),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
