import 'package:dio/dio.dart';
import 'package:spotify_api/constants/app_contants.dart';

import '../models/models.dart';

class TracksRepository {
  final Dio dio;
  const TracksRepository(this.dio);

  Future<Track?> getTrack(String id) async {
    try {
      var response = await dio.get(ApiPath.getTrack(id));

      return Track.fromMap(response.data);
    } catch (_) {
      return null;
    }
  }
}
