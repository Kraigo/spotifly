library spotify_api;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_api/constants/app_contants.dart';
import 'package:spotify_api/repositories/playlist_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class Spotify {
  final String clientId;
  final String redirectUrl;

  final playlists = PlaylistRepository();

  Spotify({
    required this.clientId,
    required this.redirectUrl,
  });

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
