import 'dart:async';
import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ozen_app/api/api.dart';

final playControl = MediaControl(
  androidIcon: 'drawable/ic_play_arrow',
  label: 'Play',
  action: MediaAction.play,
);

final pauseControl = MediaControl(
  androidIcon: 'drawable/ic_pause',
  label: 'Pause',
  action: MediaAction.pause,
);

final stopControl = MediaControl(
  androidIcon: 'drawable/ic_stop',
  label: 'Stop',
  action: MediaAction.stop,
);

void playAudioService() async {
  if (!AudioService.running) {
    await AudioService.start(
        backgroundTaskEntrypoint: ozenBackgroundTaskEntrypoint);
  } else {
    AudioService.play();
  }
}

void ozenBackgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => MyBackgroundTask());
}

class MyBackgroundTask extends BackgroundAudioTask {
  final player = AudioPlayer();
  Timer timer;
  Random random = Random.secure();
  Completer completer = Completer();

  @override
  Future<void> onStart() async {
    await player.setUrl('http://streaming.radio.co/scc370f2b2/listen');
    await AudioServiceBackground.androidForceEnableMediaButtons();
    player.play();

    AudioServiceBackground.setState(
      controls: [pauseControl, stopControl],
      basicState: BasicPlaybackState.playing,
    );
    
    await getCurrentMediaItem();
    timer = Timer.periodic(Duration(seconds: 10), getCurrentMediaItem);

    await completer.future;

    player.dispose();
    AudioServiceBackground.setState(
      controls: [],
      basicState: BasicPlaybackState.playing,
    );
  }

  getCurrentMediaItem([dynamic _]) async {
    final currentTrack = await getCurrentTrack();

    AudioServiceBackground.setMediaItem(
      MediaItem(
        id: '${random.nextInt(32768)}',
        title: currentTrack.title,
        artist: currentTrack.author,
        artUri: currentTrack.albumCoverUrl,
        album: 'Ozen',
      ),
    );
  }

  @override
  void onStop() {
    player.stop();
    completer.complete();
  }

  @override
  void onPlay() {
    player.play();
    AudioServiceBackground.setState(
      controls: [pauseControl, stopControl],
      basicState: BasicPlaybackState.playing,
    );
  }

  @override
  void onPause() {
    player.stop();
    AudioServiceBackground.setState(
      controls: [playControl, stopControl],
      basicState: BasicPlaybackState.paused,
    );
  }
}
