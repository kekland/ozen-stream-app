import 'package:flutter/material.dart';
import 'package:ozen_app/components/clickable_panel_widget.dart';
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
          SizedBox(height: 16.0),
          _HistorySong(),
          SizedBox(height: 16.0),
          _HistorySong(),
          SizedBox(height: 16.0),
          _HistorySong(),
          SizedBox(height: 16.0),
          _HistorySong(),
          SizedBox(height: 16.0),
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
    return ClickablePanelWidget(
      child: Row(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'kekland',
                style: TextStyle(
                  color: context.textTheme.caption.color,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Lost in space',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
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
