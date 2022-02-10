import 'package:architecture_test_data/architecture_test_data.dart';
import 'package:get_it/get_it.dart';

class BusinessFactory {
  static final _getIt = GetIt.I;
  //T get<T extends Object>() => _getIt.get<T>();

  static final instance = BusinessFactory();

  void init() {
    ServiceProvider.instance.initialize();
    // _getIt.registerFactory<MainBloc>(
    //       () => MainBloc(
    //     yaFunctions: ServiceProvider.instance.get<YaFunctions>(),
    //   ),
    // );
  }
}