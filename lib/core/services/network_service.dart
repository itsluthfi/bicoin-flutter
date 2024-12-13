import 'package:dev_coinku/core/constants/key_constant.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class DioService {
  static final DioService _instance = DioService._internal();
  late Dio _dio;
  late Dio _dioAuth;

  factory DioService() {
    return _instance;
  }

  DioService._internal() {
    final box = GetStorage();

    _dio = Dio(BaseOptions(
      baseUrl: "https://5265-66-96-225-164.ngrok-free.app/",
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read(KeyConstant.token)}'
      },
    ));

    _dioAuth = Dio(BaseOptions(
      baseUrl: "https://5265-66-96-225-164.ngrok-free.app/",
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    // print({
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer ${box.read(KeyConstant.token)}'
    // });
  }

  static DioService get instance => _instance;

  // Dio get dio => _dio;

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
      final response = await _dio.post(endpoint,
          data: data,
          options: Options(
            contentType: Headers.jsonContentType,
          ));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postRequestAuth(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dioAuth.post(endpoint,
          data: data,
          options: Options(
            contentType: Headers.jsonContentType,
          ));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
