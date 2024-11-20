import 'package:dio/dio.dart';

class DioService {
  static final DioService _instance = DioService._internal();
  late Dio _dio;

  factory DioService() {
    return _instance;
  }

  DioService._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: "http://10.0.2.2:8080/api",
      connectTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000),
    ));
  }

  static DioService get instance => _instance;

  Dio get dio => _dio;

  Future<Response> getRequest(
    String endpoint,
  ) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
