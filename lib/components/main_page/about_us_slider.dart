import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ozen_app/extensions.dart';

class AboutUsSlider extends StatefulWidget {
  @override
  _AboutUsSliderState createState() => _AboutUsSliderState();
}

List<Widget Function()> pages = [
  () => Text(
        'Добро пожаловать на õzen stream. Казахстанская музыка, авторские передачи, топ-чарты - все в одном приложении.',
      ),
  () => Text(
        'Слушай нас в машине, по пути на работу и во время отдыха.',
      ),
  () => Text(
        'Премьера свежих песен, а также эксклюзивные новости только на õzen stream.',
      )
];

class _AboutUsSliderState extends State<AboutUsSlider>
    with SingleTickerProviderStateMixin {
  int currentPage = 0;
  AnimationController controller;
  Animation<double> animation;

  int get nextPage {
    if (currentPage == pages.length - 1) return 0;
    return currentPage + 1;
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        currentPage = nextPage;
        controller.value = 0.0;
      }
      setState(() {});
    });

    Timer.periodic(Duration(seconds: 3), (_) {
      controller.forward(from: 0.0);
    });

    super.initState();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'о нас',
            style: TextStyle(
              color: context.textTheme.caption.color,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.0),
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
            child: Stack(
              children: [
                Transform.translate(
                  offset: Offset(-200.0 * (animation.value), 0.0),
                  child: Opacity(
                    opacity: 1.0 - animation.value,
                    child: pages[currentPage](),
                  ),
                ),
                Transform.translate(
                  offset: Offset(200.0 * (1.0 - animation.value), 0.0),
                  child: Opacity(
                    opacity: animation.value,
                    child: pages[nextPage](),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
