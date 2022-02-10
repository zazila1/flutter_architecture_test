import 'package:architecture_test_business/src/models/hotel.dart';
import 'package:architecture_test_business/src/notifiers/hotel_details_notifier.dart';
import 'package:architecture_test_data/architecture_test_data.dart';
import 'package:flutter/material.dart';

class HotelDetailsState with ChangeNotifier implements HotelDetailsNotifier {
  HotelDetailsState(this._api);

  final Api _api;
  late Hotel hotelData;

  bool isLoaded = false;

  void getHotelData(String uuid) async {
    var data = await _api.getHotelData(uuid);
    hotelData = _fillHotelWithResponseData(data);
    notifyListeners();
    isLoaded = true;
  }

  void updateHotel() {
    // not implemented
  }

  Hotel _fillHotelWithResponseData(HotelResponse data) {
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
