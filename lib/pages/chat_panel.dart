import 'package:flutter/material.dart';
import 'package:ozen_app/components/chat/chat_field.dart';
import 'package:ozen_app/components/chat/chat_message.dart';

class ChatPanel extends StatefulWidget {
  final ScrollController scrollController;

  const ChatPanel({Key key, this.scrollController}) : super(key: key);

  @override
  _ChatPanelState createState() => _ChatPanelState();
}

class _ChatPanelState extends State<ChatPanel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            controller: widget.scrollController,
            reverse: true,
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              bottom: 24.0,
            ),
            children: [
              ChatMessage(
                body: 'Hi!',
                username: 'kekland',
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 64.0,
          child: ChatField(),
        ),
      ],
    );
  }
}
