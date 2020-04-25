import 'dart:async';

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
        currentUser: state.currentUser,
        messages: state.messages,
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

StreamSubscription<QuerySnapshot> listenToHearts(
    {BuildContext context, VoidCallback callback}) {
  return Firestore.instance
      .collection('hearts')
      .orderBy('timestamp', descending: true)
      .where('timestamp', isGreaterThan: Timestamp.now())
      .snapshots()
      .listen((querySnapshot) {
    querySnapshot.documentChanges
        .where((d) => d.type == DocumentChangeType.added)
        .forEach((d) => callback());
  });
}

Future<void> sendMessage({BuildContext context, String body}) async {
  final state = ModelBinding.of<AppState>(context);

  await Firestore.instance.collection('messages').add({
    'timestamp': DateTime.now(),
    'uid': state.currentUser.firebaseUser.uid,
    'username': state.currentUser.username,
    'body': body,
  });
}

StreamSubscription<QuerySnapshot> listenToMessages({
  BuildContext context,
  void Function(Map<String, dynamic>) callback,
}) {
  return Firestore.instance
      .collection('messages')
      .orderBy('timestamp', descending: true)
      .where('timestamp', isGreaterThan: Timestamp.now())
      .snapshots()
      .listen((querySnapshot) {
    querySnapshot.documentChanges
        .where((d) => d.type == DocumentChangeType.added)
        .forEach(
          (d) => callback(d.document.data),
        );
  });
  ;
}
