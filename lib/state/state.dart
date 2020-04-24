import 'package:flutter/material.dart';
import 'package:ozen_app/api/track.dart';

class AppState {
  final Track currentTrack;
  final List<Track> history;
  final bool isPlaying;

  final bool isLoading;

  AppState({this.currentTrack, this.history, this.isPlaying, this.isLoading});
}
