import 'package:flutter/material.dart';
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
            ModelBinding.update(
              context,
              AppState(
                currentTrack: state.currentTrack,
                history: state.history,
                isLoading: state.isLoading,
                isPlaying: !state.isPlaying,
              ),
            );
          },
          small: true,
        ),
      ],
    );
  }
}
