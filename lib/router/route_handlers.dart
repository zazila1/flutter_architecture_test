// 📦 Package imports:
import 'package:fluro/fluro.dart';
//import 'package:hotels/models/hotel.dart';
import 'package:hotels/views/detailed_view.dart';
import 'package:hotels/views/detailed_view_with_provider.dart';
import 'package:hotels/views/home_views.dart';
import 'package:architecture_test_business/architecture_test_business.dart';
// 🌎 Project imports:


Handler homeHandler = Handler(handlerFunc: (context, params) {
  return const HomeView();
});

Handler hotelDetailsHandler = Handler(handlerFunc: (context, params) {
  final args = context!.settings!.arguments as HotelPreview;
  return HotelDetailsView1(hotelPreview: args,);
});
