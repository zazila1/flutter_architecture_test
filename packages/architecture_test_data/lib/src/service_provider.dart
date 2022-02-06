import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'api_dio.dart';
import 'interfaces/api.dart';

class ServiceProvider {
  static final _getIt = GetIt.I;

  static final instance = ServiceProvider();

  void initialize() {
    _getIt.registerLazySingleton<Dio>(() => Dio());
    _getIt.registerLazySingleton<Api>(() => ApiDio(
      _getIt.get<Dio>(),
      baseUrl: "https://run.mocky.io/v3/"
    ));
  }
}
