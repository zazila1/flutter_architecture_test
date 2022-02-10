import 'package:architecture_test_data/src/models/hotel_response.dart';
import 'package:architecture_test_data/src/models/hotels_preview_response.dart';

abstract class Api<T> {
  Api(T _httpClient, [String? _baseUrl = ""]);

  Future<List<HotelsPreviewResponse>> getHotelsPreviewData();
  Future<HotelResponse> getHotelData(String uuid);
}
