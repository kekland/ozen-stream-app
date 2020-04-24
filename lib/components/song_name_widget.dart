import 'package:flutter/material.dart';
import 'package:ozen_app/api/track.dart';

class SongNameWidget extends StatelessWidget {
  final Track track;

  const SongNameWidget({Key key, this.track}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (track?.author != null && track.author.isNotEmpty)
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(4.0),
            child: Text(
              track?.author ?? 'Загрузка',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        if (track?.title != null && track.title.isNotEmpty)
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(4.0),
            child: Text(
              track?.title ?? '',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
