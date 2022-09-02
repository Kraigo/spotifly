
import 'package:spotify_api/base/dio.dart';
import 'package:spotify_api/constants/app_contants.dart';
import 'package:spotify_api/models/playlists_pagination.dart';

class PlaylistRepository extends DioClient {
  Future<PlaylistsPagination> getMyPlaylists() async {
    var response = await dio.get(ApiPath.getCurrentUserPlaylists);

    return PlaylistsPagination.fromMap(response.data);
  }
}