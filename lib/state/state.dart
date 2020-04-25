import 'package:ozen_app/api/track.dart';
import 'package:ozen_app/api/user.dart';

class AppState {
  final Track currentTrack;
  final List<Track> history;
  final bool isPlaying;

  final bool isLoading;
  final User currentUser;
  List<Map<String, dynamic>> messages;

  AppState({
    this.currentTrack,
    this.history,
    this.isPlaying,
    this.isLoading,
    this.currentUser,
    this.messages,
  });

  AppState copyWith({
    Track currentTrack,
    List<Track> history,
    bool isPlaying,
    bool isLoading,
    User currentUser,
    List<Map<String, dynamic>> messages,
  }) {
    return AppState(
      currentTrack: currentTrack ?? this.currentTrack,
      history: history ?? this.history,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
      messages: messages ?? this.messages,
    );
  }
}
