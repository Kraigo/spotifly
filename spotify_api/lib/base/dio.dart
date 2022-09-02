import 'dart:io';

// import 'package:bob_mobile/base/keys.dart';
// import 'package:bob_mobile/base/routes.dart';
// import 'package:bob_mobile/constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_api/constants/app_contants.dart';
// import 'package:shared_preferences/shared_preferences.dart';


class DioClient {
  late Dio dio;
  // late SharedPreferences _storage;

  DioClient() {
    dio = Dio();

    dio.options
        ..baseUrl = ApiPath.baseUrl
        // ..connectTimeout = 5000
        // ..receiveTimeout = 5000
        // ..validateStatus = (int? status) {
        //   return status != null && status > 0;
        // }
        // ..responseType = ResponseType.plain
        ..headers = {
          HttpHeaders.userAgentHeader: 'dio',
          'Content-Type': 'application/json; charset=UTF-8'
        };

    dio.interceptors
      ..add(QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          final storage = await SharedPreferences.getInstance();
          var token = storage.get(StorageKeys.accessToken);
          
          options.headers["Authorization"] = "Bearer $token";
          return handler.next(options);
        },
        onError: (DioError error, handler) async {
          if (error.response?.statusCode == 403 ||
              error.response?.statusCode == 401) {
            
            // AppKeys.navigatorKey.currentState!.pushNamed(Routes.logout);

            // dio.interceptors.requestLock.lock();
            // dio.interceptors.responseLock.lock();
            // RequestOptions options = error.requestOptions;
            // // FirebaseUser user = await FirebaseAuth.instance.currentUser();
            // // token = await user.getIdToken(refresh: true);
            // // await writeAuthKey(token);
            // // options.headers["Authorization"] = "Bearer " + token;

            // dio.interceptors.requestLock.unlock();
            // dio.interceptors.responseLock.unlock();
            // return dio.request(options.path, options: options);
          }

          return handler.next(error);
        }

      ))
      ..add(LogInterceptor(responseBody: false, responseHeader: false, requestHeader: false, request: false));
  
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