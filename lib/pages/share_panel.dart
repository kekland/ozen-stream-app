import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SharePanel extends StatefulWidget {
  @override
  _SharePanelState createState() => _SharePanelState();
}

class _SharePanelState extends State<SharePanel> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: FlatButton.icon(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.yandex),
              label: Text('Яндекс.Музыка'),
              padding: const EdgeInsets.all(12.0),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FlatButton.icon(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.apple),
              label: Text('Apple Music'),
              padding: const EdgeInsets.all(12.0),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FlatButton.icon(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.spotify),
              label: Text('Spotify'),
              padding: const EdgeInsets.all(12.0),
            ),
          ),
        ],
      ),
    );
  }
}
