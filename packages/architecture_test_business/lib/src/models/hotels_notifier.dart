import 'package:architecture_test_business/architecture_test_business.dart';
import 'package:flutter/material.dart';

abstract class HotelsNotifier with ChangeNotifier  {
  //late bool isLoaded;
  late Future<List<HotelPreview>> previewHotelData;
  late Future<Hotel> hotelData;

  void loadHotelsPreviewData({bool notify});
  void loadHotelData(String uuid, {bool notify});
  void updateHotel();
}
