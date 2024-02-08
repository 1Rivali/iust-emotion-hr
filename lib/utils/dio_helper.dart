import 'package:dio/dio.dart';
import 'package:front/utils/cache_helper.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(baseUrl: "http://127.0.0.1:8000/"));
  }

  static Future<Response?> getData(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    return await dio?.get(path,
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  static Future<Response?> getDataAuth(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    String? token = CacheHelper.getData(key: "token");
    return await dio?.get(
      path,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          ...?headers,
          "Authorization": "Token  $token",
        },
      ),
    );
  }

  static Future<Response?> postData(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      required dynamic data}) async {
    return await dio?.post(path,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers));
  }

  static Future<Response?> postDataAuth(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      required dynamic data}) async {
    String? token = CacheHelper.getData(key: "token");
    return await dio?.post(path,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          headers: {
            ...?headers,
            "Authorization": "Token  $token",
          },
        ));
  }

  static Future<Response?> patchData(
      {required String path,
      Map<String, dynamic>? queryParameters,
      required dynamic data}) async {
    return await dio?.patch(
      path,
      queryParameters: queryParameters,
      data: data,
    );
  }

  static Future<Response?> patchDataAuth(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      required dynamic data}) async {
    String? token = CacheHelper.getData(key: "token");
    return await dio?.patch(path,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          headers: {
            ...?headers,
            "Authorization": "Token  $token",
          },
        ));
  }

  static Future<Response?> deleteData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio?.delete(path,
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  static Future<Response?> deleteDataAuth({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    String? token = CacheHelper.getData(key: "token");
    return await dio?.delete(
      path,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          ...?headers,
          "Authorization": "Token  $token",
        },
      ),
    );
  }
}
