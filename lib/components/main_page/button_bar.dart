import 'package:flutter/material.dart';
import 'package:ozen_app/extensions.dart';

class MainPageButtonBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              size: 28.0,
              color: context.theme.primaryColor,
            ),
            onPressed: () {},
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.history,
              size: 28.0,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 8.0),
          IconButton(
            icon: Icon(
              Icons.share,
              size: 28.0,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 8.0),
          IconButton(
            icon: Icon(
              Icons.comment,
              size: 28.0,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
