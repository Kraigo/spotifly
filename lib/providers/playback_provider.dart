import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_api/spotify_api.dart';

class PlaybackProvider extends ChangeNotifier {
  late AudioPlayer player;
  late Spotify spotify;

  PlaybackProvider() {
    player = AudioPlayer();

    final clientId = dotenv.get('SPOTIFY_CLIENT_ID');
    final redirectUrl = dotenv.get('SPOTIFY_REDIRECT_URL');
    spotify = Spotify(clientId: clientId, redirectUrl: redirectUrl);
  }

  Future<String?> getTrackUrl(String id) async {
    final response = await spotify.tracks.getTrack(id);

    return response.preview_url;
  }

  startPlaying(String trackId) async {
    if (isPlaying()) {
      player.stop();
    }
    final trackUrl = await getTrackUrl(trackId);

    if (trackUrl != null) {
      await player.play(UrlSource(trackUrl));
    }
  }
  stopPlaying() {
      player.stop();
  }

  pause() async {
    await player.pause();
  }

  resume() async {
    await player.resume();
  }
  bool isPlaying() {
    return player.state == PlayerState.playing;
  }
}
