import 'package:flutter/material.dart';
import 'package:ozen_app/extensions.dart';

class PlayButton extends StatefulWidget {
  final bool small;
  final VoidCallback onTap;
  final bool isPlaying;

  const PlayButton({
    Key key,
    this.small,
    this.isPlaying,
    this.onTap,
  }) : super(key: key);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton>
    with SingleTickerProviderStateMixin {
  AnimationController iconAnimation;

  @override
  void initState() {
    iconAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    super.initState();
  }

  didUpdateWidget(oldWidget) {
    if (widget.isPlaying)
      iconAnimation.forward();
    else
      iconAnimation.reverse();

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final diameter = widget.small ? 64.0 : 144.0;
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
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(diameter / 2.0),
          child: Center(
            child: AnimatedIcon(
              size: widget.small? 32.0 : 48.0,
              progress: iconAnimation,
              icon: AnimatedIcons.play_pause,
            ),
          ),
        ),
      ),
    );
  }
}
