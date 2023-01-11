import 'package:spotify_api/models/track.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_api/spotify_api.dart';

class PlayerProvider extends ChangeNotifier {
  Track? selected;
  late Stream<Duration> trackPosition;
  late Stream<Duration> trackDuration;
  late Stream<bool> isPlaying;

  late AudioPlayer _player;
  late Spotify _spotify;

  PlayerProvider() {
    _player = AudioPlayer();
    trackPosition = _player.onPositionChanged;
    trackDuration = _player.onDurationChanged;
    isPlaying = _player.onPlayerStateChanged
        .map((event) => event == PlayerState.playing);

    final clientId = dotenv.get('SPOTIFY_CLIENT_ID');
    final redirectUrl = dotenv.get('SPOTIFY_REDIRECT_URL');
    _spotify = Spotify(clientId: clientId, redirectUrl: redirectUrl);
  }

  Future<String?> getTrackUrl(String id) async {
    final response = await _spotify.tracks.getTrack(id);

    return response.preview_url;
  }

  loadAndStartPlaying(String trackId) async {
    if (_isPlaying()) {
      _player.stop();
    }
    final trackUrl = await getTrackUrl(trackId);

    if (trackUrl != null) {
      await _player.play(UrlSource(trackUrl));
    }
  }

  startPlaying() async {
    if (_isPlaying()) {
      _player.stop();
    }
    if (selected != null) {
      await _player.play(UrlSource(selected!.preview_url));

      notifyListeners();
    }
  }

  stopPlaying() {
    _player.stop();
  }

  pause() async {
    await _player.pause();
  }

  resume() async {
    await _player.resume();
  }
  bool _isPlaying() {
    return _player.state == PlayerState.playing;
  }

  void selectTrack(Track track) {
    selected = track;
    notifyListeners();
  }
}
