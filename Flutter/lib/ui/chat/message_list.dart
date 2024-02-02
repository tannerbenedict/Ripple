import 'package:ripple/providers/chat_hub_connection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageList extends HookConsumerWidget {
  final String _lobbyCode;
  final String _user;
  const MessageList(this._lobbyCode, this._user);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatHubConnection = ref.watch(chatHubConnectionProvider(_lobbyCode));
    final scrollController = useScrollController();
    useEffect(() {
      if (!scrollController.hasClients) return null;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 200), curve: Curves.easeOut));
      return null;
    }, [chatHubConnection.asData?.value]);

    return chatHubConnection.when(
      data: (messages) {
        return ListView.separated(
          controller: scrollController,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            bool isIncomingMessage = messages[index].authorId != _user;

            return ListTile(
              // message that appears in a chat bubble
              title: Align(
                alignment: isIncomingMessage
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: isIncomingMessage ? Colors.grey : Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                      bottomLeft: !isIncomingMessage
                          ? Radius.circular(16.0)
                          : Radius.circular(0.0),
                      bottomRight: isIncomingMessage
                          ? Radius.circular(16.0)
                          : Radius.circular(0.0),
                    ),
                  ),
                  child: Text(
                    messages[index].message,
                    style: TextStyle(
                      color: isIncomingMessage ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
              // author name that appears below message
              subtitle: Text(
                messages[index].authorName,
                textAlign: isIncomingMessage ? TextAlign.left : TextAlign.right,
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        return Card(
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            title: Icon(Icons.error),
            subtitle: Text(
              "Error loading messages!",
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
