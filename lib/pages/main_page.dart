import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ozen_app/components/app_logo.dart';
import 'package:ozen_app/components/main_page/about_us_slider.dart';
import 'package:ozen_app/components/main_page/audio_tunes_bar.dart';
import 'package:ozen_app/components/main_page/button_bar.dart';
import 'package:ozen_app/components/main_page/hearts_animator_bar.dart';
import 'package:ozen_app/components/sliding_panel.dart';
import 'package:ozen_app/components/song_name_widget.dart';
import 'package:ozen_app/pages/chat_panel.dart';
import 'package:ozen_app/pages/history_panel.dart';
import 'package:ozen_app/pages/settings_panel.dart';
import 'package:ozen_app/pages/share_panel.dart';
import 'package:ozen_app/utils.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  HeartsController heartsController;

  initState() {
    heartsController = HeartsController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Image.network(
              'https://i.pinimg.com/originals/ec/86/02/ec86020d19e2a36711ff12c4190d6cdb.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, 1.0),
                end: Alignment(0.0, -1.0),
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Material(
              type: MaterialType.transparency,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        /* Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: AboutUsSlider(),
                          ),
                        ), */
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.settings),
                                  onPressed: () {},
                                ),
                                Spacer(),
                                AppLogo(),
                              ],
                            ),
                          ),
                        ),
                        HeartsAnimatorBar(
                          controller: heartsController,
                        ),
                      ],
                    ),
                  ),
                  AudioTunesBar(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 32.0,
                      right: 32.0,
                      top: 32.0,
                    ),
                    child: SongNameWidget(
                      author: 'Daft Punk',
                      title: 'Around the world',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 32.0,
                      right: 32.0,
                      bottom: 32.0,
                      top: 32.0,
                    ),
                    child: MainPageButtonBar(
                      onTapHeart: () => heartsController.addHeart(),
                      onTapComment: () => showCustomChatPageModalSheet(
                        context: context,
                      ),
                      onTapHistory: () => showCustomBottomSheet(
                        context: context,
                        builder: (_, scrollController) => SlidingPanel(
                          title: 'История',
                          child:
                              HistoryPanel(scrollController: scrollController),
                        ),
                      ),
                      onTapShare: () => showCustomSharePageModalSheet(
                        context: context,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
