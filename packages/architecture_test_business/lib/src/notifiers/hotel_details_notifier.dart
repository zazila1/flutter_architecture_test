import 'package:architecture_test_business/architecture_test_business.dart';
import 'package:flutter/material.dart';

abstract class HotelDetailsNotifier with ChangeNotifier  {
  //late bool isLoaded;
  late Future<Hotel> hotelData;

  void loadHotelData(String uuid);
  void updateHotel();
}
