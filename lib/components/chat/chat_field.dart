import 'package:flutter/material.dart';
import 'package:ozen_app/api/api.dart';
import 'package:ozen_app/extensions.dart';

class ChatField extends StatefulWidget {
  @override
  _ChatFieldState createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  TextEditingController controller;

  initState() {
    controller = TextEditingController();

    controller.addListener(() => setState(() {}));
    super.initState();
  }

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
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Ваше сообщение',
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.send,
            color: controller.text.isNotEmpty
                ? context.theme.primaryColor
                : Colors.white24,
          ),
          onPressed: controller.text.isNotEmpty
              ? () {
                  sendMessage(context: context, body: controller.text);
                  controller.text = '';
                }
              : null,
        )
      ],
    );
  }
}
