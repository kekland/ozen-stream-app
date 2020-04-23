import 'package:flutter/material.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            PlayButton(
              isPlaying: false,
              small: false,
              onTap: () {},
            ),
            SizedBox(height: 32.0),
            SongNameWidget(
              author: 'Mag Family',
              title: 'Evening Luck',
            ),
            SizedBox(height: 32.0),
            MainPageButtonBar(),
          ],
        ),
      ),
    );
  }
}