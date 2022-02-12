import 'package:architecture_test_business/src/models/hotel.dart';
import 'package:architecture_test_business/src/models/hotel_preview.dart';
import 'package:architecture_test_business/src/models/hotels_notifier.dart';
import 'package:architecture_test_data/architecture_test_data.dart';
import 'package:flutter/material.dart';

class HotelsState with ChangeNotifier implements HotelsNotifier {
  HotelsState(this._api) {
    print("HotelDetailsState CONSTRUCTOR");
    loadHotelsPreviewData();
  }
  final Api _api;
  late Future<List<HotelPreview>> previewHotelData;
  late Future<Hotel> hotelData;

  void loadHotelsPreviewData() async {
    previewHotelData = _getHotelsPreviewDataFromApi();
    notifyListeners();
  }

  void loadHotelData(String uuid, {bool notify = true}) async {
    hotelData = _getHotelDataFromApi(uuid);
    if (notify) notifyListeners();
  }

  void updateHotel() {
    // not implemented
  }

  Future<List<HotelPreview>> _getHotelsPreviewDataFromApi() async {
    print("_getHotelsPreviewDataFromApi");
    var data = await _api.getHotelsPreviewData();
    return Future.value(_generateHotelsPreviewWithResponseData(data));
  }

  Future<Hotel> _getHotelDataFromApi(String uuid) async {
    print("_getHotelDataFromApi");
    var data = await _api.getHotelData(uuid);
    return Future.value(_generateHotelWithResponseData(data));
  }

  List<HotelPreview> _generateHotelsPreviewWithResponseData(List<HotelPreviewResponse> data) {
    // some logic on a sample of data

    print("_generateHotelsPreviewWithResponseData");
    List<HotelPreview> _hotelsPreview = [];

    data.forEach((item) {
      _hotelsPreview.add(HotelPreview(uuid: item.uuid, name: item.name, poster: item.poster));
    });

    return _hotelsPreview;
  }

  Hotel _generateHotelWithResponseData(HotelResponse data) {
    // some logic on a sample of data

    print("_fillHotelWithResponseData");
    Services _services = Services(free: data.services.free, paid: data.services.paid);
    Coords _coords = Coords(lat: data.address.coords.lat, lan: data.address.coords.lan);
    Address _address = Address(
        country: data.address.country,
        street: data.address.street,
        city: data.address.city,
        zipCode: data.address.zipCode,
        coords: _coords);
    Hotel _hotel = Hotel(
        uuid: data.uuid,
        name: data.name,
        poster: data.poster,
        address: _address,
        price: data.price,
        rating: data.rating,
        services: _services,
        photos: data.photos);

    return _hotel;
  }
}
