import 'package:flutter/material.dart';
import 'package:ozen_app/extensions.dart';

class ChatMessage extends StatelessWidget {
  final String username;
  final DateTime time;
  final String body;

  const ChatMessage({
    Key key,
    this.username,
    this.time,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              username,
              style: TextStyle(
                color: context.theme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          body,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
