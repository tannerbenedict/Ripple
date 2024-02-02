import 'package:ripple/providers/chat_hub_connection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageInput extends HookConsumerWidget {
  final String _lobbyCode;
  const MessageInput(this._lobbyCode);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final msg = useState("");
    useEffect(() {
      textController.addListener(() {
        msg.value = textController.text;
      });
      return null;
    }, [msg]);

    return Row(mainAxisSize: MainAxisSize.min, children: [
      Flexible(
        flex: 5,
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: "Enter a message",
          ),
          onSubmitted: (_) async =>
              await handleMessageSubmit(ref, textController, msg.value),
        ),
      ),
      Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child: IconButton(
            onPressed: msg.value.isEmpty
                ? null
                : () async {
                    await handleMessageSubmit(ref, textController, msg.value);
                  },
            icon: Icon(Icons.send_rounded)),
      ),
    ]);
  }

  Future<void> handleMessageSubmit(
      WidgetRef ref, TextEditingController textController, String msg) async {
    if (msg.isEmpty) return;
    await ref
        .read(chatHubConnectionProvider(_lobbyCode).notifier)
        .sendMessage(msg);
    textController.clear();
  }
}
