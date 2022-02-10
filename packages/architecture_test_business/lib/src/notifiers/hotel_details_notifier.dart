import 'package:architecture_test_business/src/models/hotel.dart';
import 'package:architecture_test_data/architecture_test_data.dart';
import 'package:architecture_test_data/src/api/api.dart';
import 'package:flutter/material.dart';

class HotelDetailsState with ChangeNotifier {
  HotelDetailsState(this._api);

  final Api _api;

  late Hotel hotel;

  bool get isLoaded => hotel != null;

  void getHotelData(String uuid) async {
    var data = await _api.getHotelData(uuid);
    hotel = _fillHotelWithResponseData(data);
    notifyListeners();
  }

  void updateHotel() {
    //
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
