import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_api/constants/app_contants.dart';

import '../models/models.dart';

class HttpClient {
  late Dio dio;

  final StreamController<CloudEvent> _eventController =
      StreamController.broadcast();
  Stream<CloudEvent> get onEvent => _eventController.stream;

  HttpClient() {
    dio = Dio();

    dio.options
      ..baseUrl = ApiPath.baseUrl
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        'Content-Type': 'application/json; charset=UTF-8'
      };

    dio.interceptors
      ..add(QueuedInterceptorsWrapper(onRequest: (options, handler) async {
        final storage = await SharedPreferences.getInstance();
        var token = storage.get(StorageKeys.accessToken);

        options.headers["Authorization"] = "Bearer $token";
        return handler.next(options);
      }, onError: (DioError error, handler) async {
        if (error.response?.statusCode == 403 ||
            error.response?.statusCode == 401) {
          _eventController
              .add(CloudEvent(type: CloudEventType.authorizationFailed));
        }

        return handler.next(error);
      }))
      ..add(LogInterceptor(
        responseBody: false,
        responseHeader: false,
        requestHeader: false,
        request: false,
      ));
  }

  // ignore: unused_element
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
