import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ozen_app/components/soundwave_widget.dart';

Random random = Random();

class AudioTunesBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 144.0,
      child: ClipRect(
        child: AlwaysScrollingSoundwaveWidget(
          height: 60.0,
          intensityGenerator: (i) => random.nextDouble(),
        ),
      ),
    );
  }
}
