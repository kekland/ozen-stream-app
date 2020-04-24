import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:ozen_app/api/api.dart';
import 'package:ozen_app/api/audio_service.dart';
import 'package:ozen_app/components/app_logo.dart';
import 'package:ozen_app/components/main_page/audio_tunes_bar.dart';
import 'package:ozen_app/components/main_page/button_bar.dart';
import 'package:ozen_app/components/main_page/hearts_animator_bar.dart';
import 'package:ozen_app/components/sliding_panel.dart';
import 'package:ozen_app/components/song_name_widget.dart';
import 'package:ozen_app/pages/history_panel.dart';
import 'package:ozen_app/state/binding.dart';
import 'package:ozen_app/state/state.dart';
import 'package:ozen_app/utils.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  HeartsController heartsController;
  Timer timer;

  initState() {
    heartsController = HeartsController();
    super.initState();

    AudioService.start(backgroundTaskEntrypoint: ozenBackgroundTaskEntrypoint);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });

    timer = Timer.periodic(
      Duration(
        seconds: 10,
      ),
      (_) => loadData(),
    );
  }

  loadData() async {
    fetchState(context: context);
  }

  dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ModelBinding.of<AppState>(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: state?.currentTrack?.albumCoverUrl != null
                ? Image.network(
                    state?.currentTrack?.albumCoverUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : Container(),
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
                      track: state.currentTrack,
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
                      onTapShare: state.currentTrack != null
                          ? () => showCustomSharePageModalSheet(
                                context: context,
                                track: state.currentTrack,
                              )
                          : null,
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
