import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ozen_app/api/track.dart';

class SharePanelButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color iconColor;

  const SharePanelButton({
    Key key,
    this.icon,
    this.text,
    this.onTap,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FlatButton(
        onPressed: onTap,
        padding: EdgeInsets.only(
          top: 12.0,
          right: 12.0,
          bottom: 12.0,
          left: 0.0,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            SizedBox(width: 18.0),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SharePanel extends StatefulWidget {
  @override
  _SharePanelState createState() => _SharePanelState();
}

class _SharePanelState extends State<SharePanel> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
      child: Column(
        children: [
          SharePanelButton(
            onTap: () {},
            icon: FontAwesomeIcons.yandex,
            text: 'Яндекс.Музыка',
            iconColor: Colors.red,
          ),
          SharePanelButton(
            onTap: () {},
            icon: FontAwesomeIcons.spotify,
            text: 'Spotify',
            iconColor: Colors.green,
          ),
          SharePanelButton(
            onTap: () {},
            icon: FontAwesomeIcons.apple,
            text: 'Apple Music',
            iconColor: Colors.white.withOpacity(0.75),
          ),
        ],
      ),
    );
  }
}

class SharePanelSong extends StatelessWidget {
  final Track track;
  const SharePanelSong({
    Key key,
    this.track,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 160.0,
          height: 160.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              12.0,
            ),
            child: Image.network(
              track.albumCoverUrl,
              width: 160.0,
              height: 160.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          color: Colors.black,
          padding: const EdgeInsets.all(4.0),
          child: Text(
            track.title,
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (track.author.isNotEmpty)
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(4.0),
            child: Text(
              track.author,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
