import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';


class ApiService {

  final Dio _dio;
  final String baseUrl = "https://fakestoreapi.com/";
  ApiService(this._dio) {
    _dio.interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: true,
      ),
    );
  }

  Future<ApiData> get(
      {required String endPoint, Map<String, dynamic>? queryParameters}) async {
    var response = await _dio.get(
      '$baseUrl$endPoint',
      queryParameters: queryParameters,
    );


    if (200 <= response.statusCode! && response.statusCode! <= 300) {
       return ApiData(
          data: response.data,
          code: response.statusCode ?? 0,
          errorMessage: "",
          success: true);
    } else if (response.statusCode == 401) {

      return ApiData(
          data: response.data,
          code: response.statusCode ?? 0,
          errorMessage: "",
          success: false);
    } else {
      return ApiData(
          data: response.data,
          code: response.statusCode ?? 0,
          errorMessage: getError(response),
          success: false);
    }
  }

  String getError(Response json) {
    final jsonString = jsonEncode(json.data);

    if (jsonString.contains("errors")) {
      String error = "";

      try {
        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        Map<String, dynamic> errors = jsonData['errors'];
        // Get the first error message
        error = errors.values.first.first;
        error = error.replaceAll('"', '');

      } catch (e) {
        error = "something want wrong try again";
      }

      return error;
    } else {
      String error = "";
      try {
        error = jsonEncode(json.data['message']);
        error = error.replaceAll('"', '');
      } catch (e) {
        error = "something want wrong try again";
      }
      return error;
    }
  }

}

class ApiData {
  final List<dynamic> data;
  final int code;
  final String errorMessage;
  final bool success;

  const ApiData(
      {required this.data,
      required this.code,
      required this.errorMessage,
      required this.success});

  ApiData copyWith({
    List<dynamic>? data,
    int? code,
    String? errorMessage,
    bool? success,
  }) {
    return ApiData(
      data: data ?? this.data,
      code: code ?? this.code,
      errorMessage: errorMessage ?? this.errorMessage,
      success: success ?? this.success,
    );
  }
}
