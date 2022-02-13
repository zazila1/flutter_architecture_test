import 'package:architecture_test_data/src/models/hotel_response.dart';
import 'package:architecture_test_data/src/models/hotels_preview_response.dart';

abstract class Api<T> {
  Future<List<HotelPreviewResponse>> getHotelsPreviewData();
  Future<HotelResponse> getHotelData(String uuid);
}
