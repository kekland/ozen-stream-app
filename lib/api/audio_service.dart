import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

void ozenBackgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => MyBackgroundTask());
}

class MyBackgroundTask extends BackgroundAudioTask {
  final player = AudioPlayer();
  @override
  Future<void> onStart() async {
    await player.setUrl('http://streaming.radio.co/scc370f2b2/listen.m3u');
  }

  @override
  void onStop() {
    player.stop();
    player.dispose();
  }
  
  @override
  void onPlay() {
    player.play();
  }

  @override
  void onPause() {
    player.pause();
  }
}
