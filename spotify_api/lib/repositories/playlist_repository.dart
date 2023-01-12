import 'package:dio/dio.dart';
import 'package:spotify_api/constants/app_contants.dart';
import 'package:spotify_api/models/playlist.dart';
import 'package:spotify_api/models/playlists_pagination.dart';

class PlaylistRepository {
  final Dio dio;
  const PlaylistRepository(this.dio);

  Future<PlaylistsPagination?> getMyPlaylists() async {
    try {
      var response = await dio.get(ApiPath.getCurrentUserPlaylists);

      return PlaylistsPagination.fromMap(response.data);
    } catch (_) {
      return null;
    }
  }

  Future<Playlist?> getPlaylist(String id) async {
    try {
      var response = await dio.get(ApiPath.getPlaylist(id));

      return Playlist.fromMap(response.data);
    } catch (_) {
      return null;
    }
  }
}
