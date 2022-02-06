import 'package:architecture_test_data/src/interfaces/api.dart';
import 'package:dio/dio.dart';

class ApiDio implements Api<Dio> {
  ApiDio(this.httpClient, {this.baseUrl = ""});

  late Dio httpClient;
  late String? baseUrl;
}