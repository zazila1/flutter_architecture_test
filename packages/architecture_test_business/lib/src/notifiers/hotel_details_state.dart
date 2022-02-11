import 'package:architecture_test_business/src/models/hotel.dart';
import 'package:architecture_test_business/src/notifiers/hotel_details_notifier.dart';
import 'package:architecture_test_data/architecture_test_data.dart';
import 'package:flutter/material.dart';

class HotelDetailsState with ChangeNotifier implements HotelDetailsNotifier {
  HotelDetailsState(this._api)
  {
   print ("HotelDetailsState CONSTRUCTOR");
  }


  final Api _api;
  late Future<Hotel> hotelData;

  //bool isLoaded = false;

  void loadHotelData(String uuid) async {
    hotelData = _getHotelDataFromApi(uuid);
    notifyListeners();
  }

  void updateHotel() {
    // not implemented
  }

  Future<Hotel> _getHotelDataFromApi(String uuid) async {
    print("getHotelData");
    var data;
    try {
      data = await _api.getHotelData(uuid);
    }
    catch(e)
    {
      return Future.error(e);
    }
    return Future.value(_fillHotelWithResponseData(data));
  }

  Hotel _fillHotelWithResponseData(HotelResponse data) {
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
