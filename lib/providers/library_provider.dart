import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_api/models/models.dart';
import 'package:spotify_api/spotify_api.dart';

class LibraryProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  late Spotify _spotify;
  List<Playlist> playlists = [];
  Playlist? currentPlaylist;

  List<Track> get currentTracks =>
      currentPlaylist?.tracks.map((e) => e.track!).toList() ?? [];

  LibraryProvider({required Spotify spotify}) {
    _spotify = spotify;
  }

  loadMyPlaylist() async {
    _loading = true;
    notifyListeners();
    try {
      final response = await _spotify.playlists.getMyPlaylists();
      if (response != null) {
        playlists = response.items;
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  loadPlaylist(String id) async {
    _loading = true;
    notifyListeners();
    try {
      final response = await _spotify.playlists.getPlaylist(id);
      currentPlaylist = response;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
