import 'package:architecture_test_business/src/notifiers/hotel_details_notifier.dart';
import 'package:architecture_test_business/src/notifiers/hotel_details_state.dart';
import 'package:architecture_test_data/architecture_test_data.dart';
import 'package:get_it/get_it.dart';

class ProvidersFactory {
  static final _getIt = GetIt.I;
  T get<T extends Object>() => _getIt.get<T>();

  static final instance = ProvidersFactory();

  void initialize() {
    ServiceProvider.instance.initialize();
    _getIt.registerFactory<HotelDetailsNotifier>(
          () => HotelDetailsState(_getIt.get<Api>()),
    );
  }
}