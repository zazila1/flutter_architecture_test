import 'package:architecture_test_data/src/api/api.dart';
import 'package:architecture_test_data/src/models/hotel_response.dart';
import 'package:architecture_test_data/src/models/hotels_preview_response.dart';
import 'package:dio/dio.dart';

class ApiDio implements Api<Dio> {
  ApiDio(this._httpClient, [this._baseUrl = ""]);

  late Dio _httpClient;
  late String? _baseUrl;

  Future<List<HotelsPreviewResponse>> getHotelsPreviewData() async {
    final List<HotelsPreviewResponse> _data;
    final responseData;

    try {
      responseData = await _httpClient.get('${_baseUrl}ac888dc5-d193-4700-b12c-abb43e289301');
    } on DioError catch (e) {
      String error = e.response?.data["message"] ?? e.error.toString();

      return Future.error(error);
    }

    try {
      _data = List<HotelsPreviewResponse>.from(
          responseData.data.map((preview) => HotelsPreviewResponse.fromJson(preview)));

      return _data;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<HotelResponse> getHotelData(String uuid) async {
    HotelResponse _data;
    final responseData;

    try {
      responseData = await _httpClient.get('${_baseUrl}${uuid}');
    } on DioError catch (e) {
      String error = e.response?.data["message"] ?? e.error.toString();

      return Future.error(error);
    }

    try {
      _data = HotelResponse.fromJson(responseData.data);

      return _data;
    } catch (e) {
      return Future.error(e);
    }
  }
}
