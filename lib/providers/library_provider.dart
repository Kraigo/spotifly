import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_api/models/playlist.dart';
import 'package:spotify_api/spotify_api.dart';

class LibraryProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  late Spotify spotify;
  List<Playlist> playlists = [];

  LibraryProvider() {
    final clientId = dotenv.get('SPOTIFY_CLIENT_ID');
    final redirectUrl = dotenv.get('SPOTIFY_REDIRECT_URL');
    spotify = Spotify(clientId: clientId, redirectUrl: redirectUrl);
  }

  loadPlaylist() async {
    _loading = true;
    notifyListeners();
    try {
      final response = await spotify.playlists.getMyPlaylists();
      playlists = response.items;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
