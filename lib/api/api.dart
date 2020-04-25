import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ozen_app/api/track.dart';
import 'package:ozen_app/state/binding.dart';
import 'package:ozen_app/state/state.dart';
import 'package:requests/requests.dart';

Future<Track> getCurrentTrack() async {
  try {
    final response = await Requests.get(
        'https://public.radio.co/stations/scc370f2b2/status');

    final body = response.json();

    return Track.fromJson(body['current_track']);
  } catch (e) {
    print(e);
  }
}

Future<void> updateState({BuildContext context}) async {
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

Future<void> pushHeart({BuildContext context}) async {
  final currentUser = await FirebaseAuth.instance.currentUser();

  Firestore.instance.collection('hearts').add(
    {
      "uid": currentUser.uid,
      "timestamp": DateTime.now(),
    },
  );
}

Future<void> listenToHearts(
    {BuildContext context, VoidCallback callback}) async {
  Firestore.instance.collection('hearts').snapshots().listen((querySnapshot) {
    callback();
  });
}
