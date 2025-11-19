import 'package:dio/dio.dart';

class ApiException extends DioException {
  final String message;

  ApiException._(this.message, {required super.requestOptions});

  factory ApiException.fromDioError(DioException error) {
    String message = "Something went wrong";

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout. Please try again.";
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout. Please try again.";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout. Please try again.";
        break;
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        message = _handleStatusCode(statusCode, error.response?.data);
        break;
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled.";
        break;
      case DioExceptionType.connectionError:
        message = "No internet connection.";
        break;
      default:
        message = "Unexpected error occurred.";
        break;
    }
    return ApiException._(message, requestOptions: error.requestOptions);
  }

  static String _handleStatusCode(int statusCode, dynamic data) {
    switch (statusCode) {
      case 400:
        return data?['message'] ?? "Bad request";
      case 401:
        return "Unauthorized request. Please login again.";
      case 403:
        return "Forbidden access.";
      case 404:
        return "Resource not found.";
      case 500:
        return "Internal server error.";
      default:
        return "Received invalid status code: $statusCode";
    }
  }

  @override
  String toString() => message;
}
