import 'package:dio/dio.dart';
import 'package:eccomerce_app/app/core/utils/appString/app_storage_string.dart';
import '../config/environment.dart';
import '../data/sharedPre.dart';
import 'api_exceptions.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  late Dio dio;

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: Environment.apiUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          final customException = ApiException.fromDioError(e);
          return handler.reject(customException);
        },
      ),
    );
  }

  Future<String?> _getToken() async {
    return SharedpreferenceUtil.getString(AppStorage.userToken);
  }
}
