import 'package:dio/dio.dart';

class ApiFailure {
  final String message;

  ApiFailure(this.message);

  factory ApiFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ApiFailure("Connection timeout with API server");
      case DioExceptionType.sendTimeout:
        return ApiFailure("Send timeout in with API server");
      case DioExceptionType.receiveTimeout:
        return ApiFailure("Receive timeout in with API server");
      case DioExceptionType.badResponse:
        return ApiFailure._fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
      case DioExceptionType.cancel:
        return ApiFailure("Request to API server was cancelled");
      case DioExceptionType.connectionError:
        return ApiFailure("No Internet Connection");
      case DioExceptionType.unknown:
      default:
        return ApiFailure("Unexpected error, please try again later!");
    }
  }

  factory ApiFailure._fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ApiFailure(
        response?['message'] ?? "Unauthorized request or bad request",
      );
    } else if (statusCode == 404) {
      return ApiFailure("Your request not found, please try later!");
    } else if (statusCode == 500) {
      return ApiFailure("Internal Server Error, please try later!");
    } else {
      return ApiFailure("Opps! There was an error, please try again");
    }
  }
}
