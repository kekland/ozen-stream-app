import 'package:flutter/material.dart';
import 'package:ozen_app/extensions.dart';

class MainPageButtonBar extends StatelessWidget {
  final VoidCallback onTapHeart;
  final VoidCallback onTapHistory;
  final VoidCallback onTapShare;
  final VoidCallback onTapComment;

  const MainPageButtonBar({
    Key key,
    this.onTapHeart,
    this.onTapHistory,
    this.onTapShare,
    this.onTapComment,
  }) : super(key: key);

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
            splashColor: context.theme.primaryColor.withOpacity(0.25),
            highlightColor: context.theme.primaryColor.withOpacity(0.25),
            onPressed: onTapHeart,
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.history,
              size: 28.0,
            ),
            onPressed: onTapHistory,
          ),
          SizedBox(width: 8.0),
          IconButton(
            icon: Icon(
              Icons.share,
              size: 28.0,
            ),
            onPressed: onTapShare,
          ),
          SizedBox(width: 8.0),
          IconButton(
            icon: Icon(
              Icons.comment,
              size: 28.0,
            ),
            onPressed: onTapComment,
          ),
        ],
      ),
    );
  }
}
