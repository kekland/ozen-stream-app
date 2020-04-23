import 'package:flutter/material.dart';
import 'package:ozen_app/components/main_page/audio_tunes_bar.dart';
import 'package:ozen_app/components/main_page/button_bar.dart';
import 'package:ozen_app/components/play_button_widget.dart';
import 'package:ozen_app/components/song_name_widget.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          AudioTunesBar(),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              top: 32.0,
            ),
            child: SongNameWidget(
              author: 'Mag Family',
              title: 'Evening Luck',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              bottom: 32.0,
              top: 32.0,
            ),
            child: MainPageButtonBar(),
          ),
        ],
      ),
    );
  }
}
