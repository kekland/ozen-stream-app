import 'package:flutter/material.dart';
import 'package:ozen_app/components/play_button_widget.dart';
import 'package:ozen_app/components/song_name_widget.dart';

class ChatCurrentTrackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SongNameWidget(
          author: 'Daft Punk',
          title: 'Around the world',
        ),
        Spacer(),
        PlayButton(
          isPlaying: false,
          onTap: () {},
          small: true,
        ),
      ],
    );
  }
}