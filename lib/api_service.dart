import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mocking_eg4/dio_adapter_mock.dart';

class ApiService {
  static String baseUrl = 'http://demo7683289.mockable.io/';

  static Dio getDioClient() {
    Dio dio = Dio();

    /// If the network call is from any of tests, then use [DioAdapterMock]
    /// instead of the Default [HttpClientAdapter] of Dio so that the
    /// mock response is returned and real network call is avoided
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      print('RUNNING IN TEST ENV');
      dio.httpClientAdapter = DioAdapterMock();
    }

    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 20000;
    dio.options.receiveTimeout = 20000;

    return dio;
  }

  static Future<dynamic> callAPI1() async {
    Dio dioClient = getDioClient();
    return dioClient
        .get(
      'data1',
    )
        .then(
      (dynamic response) {
        return response;
      },
    );
  }

  static Future<dynamic> callAPI2() async {
    Dio dioClient = getDioClient();
    return dioClient
        .get(
      'data2',
    )
        .then(
      (dynamic response) {
        return response;
      },
    );
  }
}
