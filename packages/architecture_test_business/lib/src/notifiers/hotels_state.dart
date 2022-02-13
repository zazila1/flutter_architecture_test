import 'package:architecture_test_business/src/models/hotel.dart';
import 'package:architecture_test_business/src/models/hotel_preview.dart';
import 'package:architecture_test_business/src/models/hotels_notifier.dart';
import 'package:architecture_test_data/architecture_test_data.dart';
import 'package:flutter/material.dart';

class HotelsState with ChangeNotifier implements HotelsNotifier {
  HotelsState(this._hotelRepository) {
    loadHotelsPreviewData();
  }
  final HotelRepository _hotelRepository;

  @override
  late Future<List<HotelPreview>> previewHotelData;
  @override
  late Future<Hotel> hotelData;

  @override
  void loadHotelsPreviewData({bool notify = true}) async {
    previewHotelData = _getHotelsPreviewDataFromApi();
    previewHotelData.then(
      (value) => {
        if (notify) notifyListeners(),
      },
    );

    //return previewHotelData;
  }

  @override
  void loadHotelData(String uuid, {bool notify = true}) async {
    hotelData = _getHotelDataFromApi(uuid);

    hotelData.then(
      (value) => {
        if (notify) notifyListeners(),
      },
    );
  }

  @override
  void updateHotel() {
    // not implemented
  }

  Future<List<HotelPreview>> _getHotelsPreviewDataFromApi() async {
    var data = await _hotelRepository.getHotelsPreviewData();

    return Future.value(_generateHotelsPreviewWithResponseData(data));
  }

  Future<Hotel> _getHotelDataFromApi(String uuid) async {
    var data = await _hotelRepository.getHotelData(uuid);

    return Future.value(_generateHotelWithResponseData(data));
  }

  List<HotelPreview> _generateHotelsPreviewWithResponseData(List<HotelPreviewResponse> data) {
    // some logic on a sample of data

    List<HotelPreview> _hotelsPreview = [];

    for (var item in data) {
      _hotelsPreview.add(HotelPreview(uuid: item.uuid, name: item.name, poster: item.poster));
    }

    return _hotelsPreview;
  }

  Hotel _generateHotelWithResponseData(HotelResponse data) {
    // some logic on a sample of data

    Services _services = Services(free: data.services.free, paid: data.services.paid);
    Coords _coords = Coords(lat: data.address.coords.lat, lan: data.address.coords.lan);
    Address _address = Address(
      country: data.address.country,
      street: data.address.street,
      city: data.address.city,
      zipCode: data.address.zipCode,
      coords: _coords,
    );
    Hotel _hotel = Hotel(
      uuid: data.uuid,
      name: data.name,
      poster: data.poster,
      address: _address,
      price: data.price,
      rating: data.rating,
      services: _services,
      photos: data.photos,
    );

    return _hotel;
  }
}
