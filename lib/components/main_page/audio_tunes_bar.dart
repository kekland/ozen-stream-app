import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ozen_app/components/play_button_widget.dart';
import 'package:ozen_app/components/soundwave_widget.dart';

Random random = Random();

class AudioTunesBar extends StatefulWidget {
  @override
  _AudioTunesBarState createState() => _AudioTunesBarState();
}

class _AudioTunesBarState extends State<AudioTunesBar> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
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
                isPlaying: _isPlaying,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: PlayButton(
                  isPlaying: _isPlaying,
                  onTap: () {
                    setState(() => _isPlaying = !_isPlaying);
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
