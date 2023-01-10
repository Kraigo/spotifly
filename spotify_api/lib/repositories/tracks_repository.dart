
import 'package:spotify_api/base/dio.dart';
import 'package:spotify_api/constants/app_contants.dart';

import '../models/models.dart';

class TracksRepository extends DioClient {
  Future<Track> getTrack(String id) async {
    var response = await dio.get(ApiPath.getTrack(id));

    return Track.fromMap(response.data);
  }
}