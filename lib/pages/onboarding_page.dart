import 'package:flutter/material.dart';
import 'package:ozen_app/components/app_logo.dart';
import 'package:ozen_app/pages/main_page.dart';
import 'package:ozen_app/pages/sign_in_page.dart';
import 'package:ozen_app/utils.dart';
import 'package:snaplist/snaplist.dart';
import 'package:ozen_app/extensions.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

List<Widget Function(BuildContext, VoidCallback, VoidCallback)>
    onboardingPages = [
  (context, onTapPrev, onTapNext) => _OnboardingPageWrapper(
        onTapNext: onTapNext,
        onTapPrev: onTapPrev,
        icon: Icons.music_note,
        title: 'Слушайте музыку онлайн',
        text:
            'Казахстанская музыка, авторские передачи, топ-чарты - все в одном приложении.',
      ),
  (context, onTapPrev, onTapNext) => _OnboardingPageWrapper(
        onTapNext: onTapNext,
        onTapPrev: onTapPrev,
        icon: Icons.directions_car,
        title: 'Где угодно, когда угодно',
        text: 'Слушай нас в машине, по пути на работу и во время отдыха.',
      ),
  (context, onTapPrev, onTapNext) => _OnboardingPageWrapper(
        onTapNext: onTapNext,
        onTapPrev: onTapPrev,
        icon: Icons.new_releases,
        title: 'Премьеры песен',
        text:
            'Премьера свежих песен, а также эксклюзивные новости только на õzen stream.',
      ),
  (context, onTapPrev, onTapNext) => _OnboardingPageWrapper(
        onTapNext: onTapNext,
        onTapPrev: onTapPrev,
        icon: Icons.radio,
        title: 'Подключайся и будь на связи',
        widget: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text('Зарегистрироваться'),
                  onPressed: () {
                    pushAnimatedRoute(
                      context: context,
                      builder: (_) => SignInPage(),
                    );
                  },
                  color: context.theme.primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'или',
                style: context.textTheme.caption,
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  child: Text('Слушать музыку прямо сейчас'),
                  onPressed: () {
                    pushAnimatedRoute(
                      context: context,
                      builder: (_) => MainPage(),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
];

class _OnboardingPageState extends State<OnboardingPage> {
  SnaplistController controller;

  @override
  void initState() {
    controller = SnaplistController(initialPosition: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
                left: 32.0,
              ),
              child: AppLogo(),
            ),
            Expanded(
              child: SnapList(
                snaplistController: controller,
                sizeProvider: (index, data) => Size(
                  MediaQuery.of(context).size.width,
                  double.infinity,
                ),
                snipCurve: Curves.fastLinearToSlowEaseIn,
                builder: (context, i, data) => onboardingPages[i](
                  context,
                  i != 0 ? () => controller.setPosition(i - 1) : null,
                  i != onboardingPages.length - 1
                      ? () => controller.setPosition(i + 1)
                      : null,
                ),
                count: onboardingPages.length,
                separatorProvider: (i, data) => Size(0.0, 0.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPageWrapper extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final Widget widget;
  final VoidCallback onTapPrev;
  final VoidCallback onTapNext;

  const _OnboardingPageWrapper({
    Key key,
    this.icon,
    this.title,
    this.text,
    this.widget,
    this.onTapPrev,
    this.onTapNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment(0.0, -0.1),
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 64.0, color: context.theme.primaryColor),
                SizedBox(height: 16.0),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.0),
                widget != null
                    ? widget
                    : Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.textTheme.caption.color,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                if (onTapPrev != null)
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: onTapPrev,
                  ),
                Spacer(),
                if (onTapNext != null)
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: onTapNext,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
