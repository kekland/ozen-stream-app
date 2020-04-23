import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ozen_app/components/main_page/audio_tunes_bar.dart';
import 'package:ozen_app/extensions.dart';

class SoundwaveWidget extends StatelessWidget {
  final List<double> bars;
  final double height;

  const SoundwaveWidget({
    Key key,
    this.height,
    this.bars,
  }) : super(key: key);

  Widget _buildBar({
    BuildContext context,
    double intensity,
    bool isPrimary = false,
  }) {
    return Container(
      width: 4.0,
      margin: EdgeInsets.only(
        right: 6.0,
      ),
      height: height * intensity,
      decoration: BoxDecoration(
        color: isPrimary ? context.theme.primaryColor : Colors.white,
      ),
    );
  }

  List<Widget> buildBars({
    BuildContext context,
    double intensityMultiplier = 1.0,
  }) {
    List<Widget> list = bars
        .map(
          (v) => _buildBar(
            context: context,
            intensity: v * intensityMultiplier,
            isPrimary: false,
          ),
        )
        .cast<Widget>()
        .toList();

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      maxWidth: double.infinity,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: buildBars(context: context),
          ),
          Opacity(
            opacity: 0.25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: buildBars(
                context: context,
                intensityMultiplier: 0.33,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlwaysScrollingSoundwaveWidget extends StatefulWidget {
  final double Function(int) intensityGenerator;
  final double height;

  const AlwaysScrollingSoundwaveWidget({
    Key key,
    this.intensityGenerator,
    this.height,
  }) : super(key: key);

  @override
  _AlwaysScrollingSoundwaveWidgetState createState() =>
      _AlwaysScrollingSoundwaveWidgetState();
}

class _AlwaysScrollingSoundwaveWidgetState
    extends State<AlwaysScrollingSoundwaveWidget>
    with SingleTickerProviderStateMixin {
  AnimationController scrollAnimation;
  List<double> bars;
  double width;
  final Duration scrollDuration = Duration(seconds: 1);
  final double barWidth = 10.0;

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    initializeBars();
    super.didChangeDependencies();
  }

  initState() {
    super.initState();
    scrollAnimation =
        AnimationController(vsync: this, duration: scrollDuration);
    scrollAnimation.addListener(() {
      if (scrollAnimation.status == AnimationStatus.completed) {
        scrollAnimation.forward(from: 0.0);
        addAnotherBar();
      }
      setState(() {});
    });
  }

  dispose() {
    scrollAnimation.dispose();
    super.dispose();
  }

  initializeBars() {
    bars = [];

    final int numberBars = (width / barWidth).ceil();

    for (int i = 0; i < numberBars; i++) {
      bars.add(widget.intensityGenerator(i));
    }

    setState(() {});
  }

  addAnotherBar() {
    if (bars == null) return;
    bars.removeAt(0);
    bars.add(widget.intensityGenerator(bars.length + 1));
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-scrollAnimation.value * barWidth, 0.0),
      child: SoundwaveWidget(
        bars: bars ?? [],
        height: widget.height,
      ),
    );
  }
}
