import 'package:flutter/material.dart';
import 'package:ozen_app/api/track.dart';

class AppState {
  final Track currentTrack;
  final List<Track> history;
  final bool isPlaying;

  final bool isLoading;

  AppState({this.currentTrack, this.history, this.isPlaying, this.isLoading});

  AppState copyWith({
    Track currentTrack,
    List<Track> history,
    bool isPlaying,
    bool isLoading,
  }) {
    return AppState(
      currentTrack: currentTrack ?? this.currentTrack,
      history: history ?? this.history,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
