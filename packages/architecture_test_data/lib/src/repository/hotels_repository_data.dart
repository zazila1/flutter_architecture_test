import 'package:architecture_test_data/src/api/api.dart';
import 'package:architecture_test_data/src/models/hotels_repository.dart';
import 'package:architecture_test_data/src/models/hotel_response.dart';
import 'package:architecture_test_data/src/models/hotels_preview_response.dart';


class HotelsRepositoryData implements HotelsRepository {
  HotelsRepositoryData(this._api);

  final Api _api;

  @override
  Future<HotelResponse> getHotelData(String uuid) {
    return _api.getHotelResponse(uuid);
  }

  @override
  Future<List<HotelPreviewResponse>> getHotelsPreviewData() {
    return _api.getHotelsPreviewResponse();
  }

}
