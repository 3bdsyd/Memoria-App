import 'package:dio/dio.dart';
import 'api_endpoints.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 300),
        headers: const {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: false,
        error: true,
      ),
    );
  }
}
