import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:ozen_app/api/audio_service.dart';
import 'package:ozen_app/components/play_button_widget.dart';
import 'package:ozen_app/components/song_name_widget.dart';
import 'package:ozen_app/state/binding.dart';
import 'package:ozen_app/state/state.dart';

class ChatCurrentTrackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = ModelBinding.of<AppState>(context);
    return Row(
      children: [
        SongNameWidget(
          track: state.currentTrack,
        ),
        Spacer(),
        PlayButton(
          isPlaying: false,
          onTap: () {
            if (state.isPlaying)
              AudioService.pause();
            else
              playAudioService();
          },
          small: true,
        ),
      ],
    );
  }
}
