import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:ozen_app/components/play_button_widget.dart';
import 'package:ozen_app/components/soundwave_widget.dart';
import 'package:ozen_app/state/binding.dart';
import 'package:ozen_app/state/state.dart';

Random random = Random();

class AudioTunesBar extends StatefulWidget {
  @override
  _AudioTunesBarState createState() => _AudioTunesBarState();
}

class _AudioTunesBarState extends State<AudioTunesBar> {
  @override
  Widget build(BuildContext context) {
    final state = ModelBinding.of<AppState>(context);

    return Container(
      width: double.infinity,
      height: 144.0,
      child: ClipRect(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: AlwaysScrollingSoundwaveWidget(
                height: 80.0,
                barsPaintedPrimary: 22,
                intensityGenerator: (i) => random.nextDouble(),
                isPlaying: state.isPlaying,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: PlayButton(
                  isPlaying: state.isPlaying,
                  onTap: () {
                    if (state.isPlaying) AudioService.pause();
                    else AudioService.play();
                  },
                  small: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
