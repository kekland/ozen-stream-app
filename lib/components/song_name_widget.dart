import 'package:flutter/material.dart';
import 'package:ozen_app/extensions.dart';

class SongNameWidget extends StatelessWidget {
  final String author;
  final String title;

  const SongNameWidget({Key key, this.author, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.black,
          padding: const EdgeInsets.all(4.0),
          child: Text(
            author,
            style: TextStyle(
              color: context.textTheme.caption.color,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          color: Colors.black,
          padding: const EdgeInsets.all(4.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
