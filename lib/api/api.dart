import 'package:flutter/cupertino.dart';
import 'package:ozen_app/api/track.dart';
import 'package:ozen_app/state/binding.dart';
import 'package:ozen_app/state/state.dart';
import 'package:requests/requests.dart';

Future<void> fetchState({BuildContext context}) async {
  try {
    final response = await Requests.get(
        'https://public.radio.co/stations/scc370f2b2/status');

    final body = response.json();

    final state = ModelBinding.of<AppState>(context);
    ModelBinding.update<AppState>(
      context,
      AppState(
        currentTrack: Track.fromJson(body['current_track']),
        history: body['history']
            .map((h) => Track.fromJson(h))
            .cast<Track>()
            .toList(),
        isLoading: false,
        isPlaying: state.isPlaying,
      ),
    );
  } catch (e) {
    print(e);
  }
}
