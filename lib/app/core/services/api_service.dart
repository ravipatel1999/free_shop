import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart'; // For MediaType
import '../data/sharedPre.dart';
import '../utils/appString/app_storage_string.dart';
import 'api_client.dart';
import 'api_exceptions.dart';

class ApiService {
  final Dio _dio = ApiClient().dio;

  // ==========================================================
  // ================ COMMON REQUEST METHODS =================
  // ==========================================================

  // -------------------- GET --------------------
  Future<Response> getRequest(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: _defaultHeaders()),
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Response> getRequestAuth(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final token = await _getAuthToken();
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: _authHeaders(token)),
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // -------------------- POST --------------------
  Future<Response> postRequest(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: _defaultHeaders()),
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Response> postRequestAuth(String endpoint, dynamic data) async {
    try {
      final token = await _getAuthToken();
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: _authHeaders(token)),
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // -------------------- PUT --------------------
  Future<Response> putRequest(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        options: Options(headers: _defaultHeaders()),
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Response> putRequestAuth(String endpoint, dynamic data) async {
    try {
      final token = await _getAuthToken();
      final response = await _dio.put(
        endpoint,
        data: data,
        options: Options(headers: _authHeaders(token)),
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // -------------------- DELETE --------------------
  Future<Response> deleteRequest(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.delete(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: _defaultHeaders()),
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Response> deleteRequestAuth(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final token = await _getAuthToken();
      final response = await _dio.delete(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: _authHeaders(token)),
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // ==========================================================
  // =============== UNIVERSAL FILE UPLOAD ===================
  // ==========================================================

  /// 🔹 Upload files (image, pdf, etc.) WITHOUT authentication
  Future<Response> uploadFiles(
    String endpoint, {
    required Map<String, dynamic> fields,
    required List<File> files,
    String fileFieldName = 'files',
    ProgressCallback? onProgress,
  }) async {
    try {
      // Convert files to MultipartFile list
      final fileList = await Future.wait(
        files.map(
          (file) async => await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
            contentType: _getMediaType(file.path),
          ),
        ),
      );

      final formData = FormData.fromMap({
        ...fields,
        fileFieldName: fileList.length == 1 ? fileList.first : fileList,
      });

      final response = await _dio.post(
        endpoint,
        data: formData,
        onSendProgress: onProgress,
        options: Options(
          headers: _defaultHeaders(),
          contentType: 'multipart/form-data',
        ),
      );

      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  /// 🔹 Upload files (image, pdf, etc.) WITH authentication
// In your ApiService class, update the uploadFilesAuth method:

  /// 🔹 Upload files (image, pdf, etc.) WITH authentication
  /// 🔹 Upload files (image, pdf, etc.) WITH authentication
  Future<Response> uploadFilesAuth(
    String endpoint, {
    required Map<String, dynamic> fields,
    required List<File> files,
    String fileFieldName = 'documents', // Change from 'files' to 'documents'
    ProgressCallback? onProgress,
  }) async {
    try {
      final token = await _getAuthToken();

      final fileList = await Future.wait(
        files.map(
          (file) async => await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
            contentType: _getMediaType(file.path),
          ),
        ),
      );

      final formData = FormData.fromMap({
        ...fields,
        fileFieldName: fileList.length == 1 ? fileList.first : fileList,
      });

      final response = await _dio.post(
        endpoint,
        data: formData,
        onSendProgress: onProgress,
        options: Options(
          headers: _authHeaders(token),
          contentType: 'multipart/form-data',
        ),
      );

      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
  // ==========================================================
  // =============== Helper Utilities =========================
  // ==========================================================

  MediaType _getMediaType(String filePath) {
    final ext = filePath.split('.').last.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      case 'pdf':
        return MediaType('application', 'pdf');
      case 'mp4':
        return MediaType('video', 'mp4');
      case 'doc':
      case 'docx':
        return MediaType('application', 'msword');
      default:
        return MediaType('application', 'octet-stream');
    }
  }

  Map<String, String> _defaultHeaders() {
    return {'Accept': 'application/json'};
  }

  Map<String, String> _authHeaders(String? token) {
    return {
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<String?> _getAuthToken() async {
    return SharedpreferenceUtil.getString(AppStorage.userToken);
  }
}
