import 'package:dio/dio.dart';
import 'package:spotify_api/base/dio.dart';
import 'package:spotify_api/constants/app_contants.dart';
import 'package:spotify_api/models/token.dart';

class AuthorizationRepository extends DioClient {
  Future<Token> getAccessToken({
    required String code,
    required redirectUri,
  }) async {
    final formData = FormData.fromMap({
      'code': code,
      'redirect_uri': redirectUri,
      'grant_type': 'authorization_code',
    });
    final response = await dio.post(ApiPath.token, data: formData);

    return Token.fromJson(response.data);
  }

  Future<Token> getRefreshToken(String token) async {
    final formData = FormData.fromMap({
      'grant_type': 'refresh_token',
      'refresh_token': token,
    });
    final response = await dio.post(ApiPath.token, data: formData);

    return Token.fromJson(response.data);
  }
}
