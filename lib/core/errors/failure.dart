import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  final String statusMsg;

  Failure({required this.message, required this.statusMsg});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusMsg});
  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          message: 'Connection Timeout with Api service',
          statusMsg: dioException.message!,
        );

      case DioExceptionType.sendTimeout:
        return ServerFailure(
          message: 'Send Timeout with Api service',
          statusMsg: dioException.message!,
        );

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          message: 'Receive Timeout with Api service',
          statusMsg: dioException.message!,
        );

      case DioExceptionType.badCertificate:
        return ServerFailure(
          message: 'Bad Certificate with Api service',
          statusMsg: dioException.message!,
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(
          message: 'Request Api service was cancelled',
          statusMsg: dioException.message!,
        );

      case DioExceptionType.connectionError:
        return ServerFailure(
          message: 'Connection Error with Api service',
          statusMsg: dioException.message!,
        );

      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerFailure(
            message: 'Internet Connection',
            statusMsg: 'Internet Connection',
          );
        }
        return ServerFailure(
          message: 'UnExpected Error please try again!',
          statusMsg: dioException.message!,
        );
      default:
        return ServerFailure(
          message: 'Opps, There is an error',
          statusMsg: 'Opps, There is an error',
        );
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 422) {
      return ServerFailure(
        message: response['message'],
        statusMsg: response['statusMsg'],
      );
    } else if (statusCode == 404) {
      return ServerFailure(
        message: 'Your request not found , please try again later',
        statusMsg: 'Your request not found , please try again later',
      );
    } else if (statusCode == 500) {
      return ServerFailure(
        message: 'Internal server error , please try again later',
        statusMsg: 'Internal server error , please try again later',
      );
    } else {
      return ServerFailure(
        message: 'Opps, There is an error',
        statusMsg: 'Opps, There is an error',
      );
    }
  }
}
