import 'package:flutter/material.dart';
import 'package:ozen_app/components/playing_animated_icon.dart';
import 'package:ozen_app/components/song_name_widget.dart';
import 'package:ozen_app/extensions.dart';

class HistoryPanel extends StatefulWidget {
  @override
  _HistoryPanelState createState() => _HistoryPanelState();
}

class _HistoryPanelState extends State<HistoryPanel> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          _HistorySong(
            isPlayingNow: true,
          ),
          _HistorySong(),
          _HistorySong(),
          _HistorySong(),
        ],
      ),
    );
  }
}

class _HistorySong extends StatelessWidget {
  final bool isPlayingNow;

  const _HistorySong({Key key, this.isPlayingNow = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          SongNameWidget(
            author: 'kekland',
            title: 'Lost in space',
          ),
          Spacer(),
          if (isPlayingNow) ...[
            PlayingAnimatedIcon(
              color: context.theme.primaryColor,
            ),
            SizedBox(width: 8.0),
            Text(
              'сейчас играет',
              style: TextStyle(
                color: context.theme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ]
        ],
      ),
    );
  }
}
