import 'package:dio/dio.dart';

class ApiErrorHandler {
  static ErrorModel handle(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        final data = error.response!.data;

        if (data is Map && data['message'] != null) {
          return ErrorModel(message: data['message']);
        }

        return ErrorModel(
          message:
              '${ErrorMessages.badResponse} (code: ${ error.response!.statusCode})',
        );
      }

      switch (error.type) {
        case DioExceptionType.connectionError:
          return ErrorModel(message: ErrorMessages.connectionError);

        case DioExceptionType.cancel:
          return ErrorModel(message: ErrorMessages.requestCancelled);

        case DioExceptionType.connectionTimeout:
          return ErrorModel(message: ErrorMessages.connectionTimeout);

        case DioExceptionType.receiveTimeout:
          return ErrorModel(message: ErrorMessages.receiveTimeout);

        case DioExceptionType.sendTimeout:
          return ErrorModel(message: ErrorMessages.sendTimeout);

        case DioExceptionType.badCertificate:
          return ErrorModel(message: ErrorMessages.badCertificate);

        case DioExceptionType.badResponse:
          return ErrorModel(message: ErrorMessages.badResponse);

        default:
          if (error.message?.toLowerCase().contains('socket') == true) {
            return ErrorModel(message: ErrorMessages.noInternet);
          }

          return ErrorModel(message: ErrorMessages.unknown);
      }
    }

    return ErrorModel(message: ErrorMessages.general);
  }
}

class ErrorMessages {
  static const connectionError = 'Connection to server failed';
  static const requestCancelled = 'Request was cancelled';
  static const connectionTimeout = 'Connection timeout';
  static const receiveTimeout = 'Receive timeout while waiting for server';
  static const sendTimeout = 'Send timeout while sending data';
  static const badCertificate = 'Server certificate is not valid';
  static const badResponse = 'Bad response from server';
  static const unknown = 'An unexpected error occurred';
  static const noInternet = 'No internet connection';
  static const general = 'Something went wrong';
}
