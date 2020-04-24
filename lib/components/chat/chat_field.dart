import 'package:flutter/material.dart';
import 'package:ozen_app/extensions.dart';

class ChatField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.tag_faces),
          onPressed: () {},
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Ваше сообщение',
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.send,
            color: context.theme.primaryColor,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
