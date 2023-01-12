library spotify_api;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_api/constants/app_contants.dart';
import 'package:spotify_api/repositories/playlist_repository.dart';
import 'package:spotify_api/repositories/tracks_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import 'base/http_client.dart';

class Spotify {
  static late Spotify instance;

  final String clientId;
  final String redirectUrl;
  late HttpClient httpClient;

  late PlaylistRepository playlists;
  late TracksRepository tracks;

  Spotify({
    required this.clientId,
    required this.redirectUrl,
  }) {
    instance = this;
    httpClient = HttpClient();
    playlists = PlaylistRepository(httpClient.dio);
    tracks = TracksRepository(httpClient.dio);
  }

  Uri get url => Uri(
          scheme: 'https',
          host: 'accounts.spotify.com',
          path: '/authorize',
          queryParameters: {
            'client_id': clientId,
            'redirect_uri': redirectUrl,
            'scope':
                'user-read-private user-read-email playlist-read-collaborative playlist-read-private',
            'response_type': 'token'
          });

  openLogin() async {
    if (!await launchUrl(url)) {
      throw 'Could not launch ${url.toString()}';
    }
  }

  setAuthorization(String token) async {
    final storage = await SharedPreferences.getInstance();
    storage.setString(StorageKeys.accessToken, token);
  }
}
