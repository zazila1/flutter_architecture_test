import 'package:fluro/fluro.dart';
import 'package:hotels/views/detailed_view.dart';
import 'package:hotels/views/home_view.dart';
import 'package:architecture_test_business/architecture_test_business.dart';


Handler homeHandler = Handler(handlerFunc: (context, params) {
  return const HomeView();
});

Handler hotelDetailsHandler = Handler(handlerFunc: (context, params) {
  final args = context!.settings!.arguments as HotelPreview;
  return HotelDetailsView(hotelPreview: args,);
});
