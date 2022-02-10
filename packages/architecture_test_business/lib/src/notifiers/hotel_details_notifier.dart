import 'package:architecture_test_business/architecture_test_business.dart';
import 'package:flutter/material.dart';

abstract class HotelDetailsNotifier with ChangeNotifier  {
  late bool isLoaded;
  late Hotel hotelData;

  void getHotelData(String uuid);
  void updateHotel();
}
