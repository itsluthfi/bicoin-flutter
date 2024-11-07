import 'package:dio/dio.dart';

class DioService {
  static final DioService _instance = DioService._internal();
  late Dio _dio;

  factory DioService() {
    return _instance;
  }

  DioService._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: "https://779v37p4-3000.asse.devtunnels.ms/api",
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
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
