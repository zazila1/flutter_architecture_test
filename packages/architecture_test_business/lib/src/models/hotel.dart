import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotel.freezed.dart';
part 'hotel.g.dart';

@freezed
class Hotel with _$Hotel {
  const factory Hotel({
    required String uuid,
    @Default('') name,
    @Default('') poster,
    Address? address,
    @Default(0.0) double price,
    @Default(0.0) double rating,
    Services? services,
    List<String>? photos,
  }) = _Hotel;

  factory Hotel.fromJson(Map<String, dynamic> json) => _$HotelFromJson(json);

  static Future<Hotel>? parseHotel(dynamic responseData) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return Hotel.fromJson(responseData);
    } catch (e) {
      return Future.error(e);
    }
  }
}

@freezed
class Address with _$Address {
  const factory Address({
    @Default('') String country,
    @Default('') String street,
    @Default('') String city,
    @Default(0) int zipCode,
    Coords? coords,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}

@freezed
class Coords with _$Coords {
  const factory Coords({
    @Default(0.0) double lat,
    @Default(0.0) double lan,
  }) = _Coords;

  factory Coords.fromJson(Map<String, dynamic> json) => _$CoordsFromJson(json);
}

@freezed
class Services with _$Services {
  const factory Services({
    List<String>? free,
    List<String>? paid,
  }) = _Services;

  factory Services.fromJson(Map<String, dynamic> json) => _$ServicesFromJson(json);
}
