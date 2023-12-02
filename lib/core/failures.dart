import 'package:dio/dio.dart';

 class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioError dioError) {
    switch (dioError.type) {


      case DioErrorType.sendTimeout:
         return ServerFailure('Send timeout with ApiServer');

      case DioErrorType.receiveTimeout:
         return ServerFailure('Receive timeout with ApiServer');


      case DioErrorType.cancel:
         return ServerFailure('Request to ApiServer was canceld');

      case DioErrorType.connectTimeout:
       return ServerFailure('Request to ApiServer was canceld');


      default:
         return ServerFailure('Opps There was an Error, Please try again');

    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure("opps There was an Error Please try again");
    } else if (statusCode == 404) {
       return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 500) {
       return ServerFailure('Internal Server error, Please try later');
    } else {
       return ServerFailure('Opps There was an Error, Please try again');

    }
  }
}
