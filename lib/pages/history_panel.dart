import 'package:flutter/material.dart';
import 'package:ozen_app/api/track.dart';
import 'package:ozen_app/components/clickable_panel_widget.dart';
import 'package:ozen_app/components/playing_animated_icon.dart';
import 'package:ozen_app/components/song_name_widget.dart';
import 'package:ozen_app/extensions.dart';
import 'package:ozen_app/state/binding.dart';
import 'package:ozen_app/state/state.dart';

class HistoryPanel extends StatefulWidget {
  final ScrollController scrollController;

  const HistoryPanel({Key key, this.scrollController}) : super(key: key);
  @override
  _HistoryPanelState createState() => _HistoryPanelState();
}

class _HistoryPanelState extends State<HistoryPanel> {
  @override
  Widget build(BuildContext context) {
    final state = ModelBinding.of<AppState>(context);

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
          ...state.history.map(
            (track) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _HistorySong(
                track: track,
                isPlayingNow: state.history.indexOf(track) == 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistorySong extends StatelessWidget {
  final bool isPlayingNow;
  final Track track;

  const _HistorySong({
    Key key,
    this.isPlayingNow = false,
    this.track,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickablePanelWidget(
      child: Row(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (track.author.isNotEmpty)
                Text(
                  track.author,
                  style: TextStyle(
                    color: context.textTheme.caption.color,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              Text(
                track.title,
                style: TextStyle(
                  fontSize: 20.0,
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
