import 'package:flutter/material.dart';
import 'package:ozen_app/extensions.dart';

class PlayButton extends StatelessWidget {
  final bool small;
  final VoidCallback onTap;
  final bool isPlaying;

  const PlayButton({
    Key key,
    this.small,
    this.isPlaying,
    this.onTap,
  }) : super(key: key);

  Widget _buildIcon() {
    if (isPlaying) {
      return Icon(
        Icons.pause,
        size: 64.0,
      );
    } else {
      return Icon(
        Icons.play_arrow,
        size: 64.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final diameter = small ? 48.0 : 144.0;
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.theme.cardColor,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(diameter / 2.0),
          child: _buildIcon(),
        ),
      ),
    );
  }
}
