import 'package:flutter/material.dart';
import 'package:ozen_app/components/clickable_panel_widget.dart';
import 'package:ozen_app/components/playing_animated_icon.dart';
import 'package:ozen_app/components/song_name_widget.dart';
import 'package:ozen_app/extensions.dart';

class HistoryPanel extends StatefulWidget {
  final ScrollController scrollController;

  const HistoryPanel({Key key, this.scrollController}) : super(key: key);
  @override
  _HistoryPanelState createState() => _HistoryPanelState();
}

class _HistoryPanelState extends State<HistoryPanel> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
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
          ]
        ],
      ),
    );
  }
}
