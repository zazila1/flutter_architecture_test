import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotel_response.freezed.dart';
part 'hotel_response.g.dart';

@freezed
class HotelResponse with _$HotelResponse {
  const factory HotelResponse({
    required String uuid,
    @Default('') name,
    @Default('') poster,
    AddressResponse? address,
    @Default(0.0) double price,
    @Default(0.0) double rating,
    ServicesResponse? services,
    List<String>? photos,
  }) = _HotelResponse;

  factory HotelResponse.fromJson(Map<String, dynamic> json) => _$HotelResponseFromJson(json);
}

@freezed
class AddressResponse with _$AddressResponse {
  const factory AddressResponse({
    @Default('') String country,
    @Default('') String street,
    @Default('') String city,
    @Default(0) int zipCode,
    CoordsResponse? coords,
  }) = _AddressResponse;

  factory AddressResponse.fromJson(Map<String, dynamic> json) => _$AddressResponseFromJson(json);
}

@freezed
class CoordsResponse with _$CoordsResponse {
  const factory CoordsResponse({
    @Default(0.0) double lat,
    @Default(0.0) double lan,
  }) = _CoordsResponse;

  factory CoordsResponse.fromJson(Map<String, dynamic> json) => _$CoordsResponseFromJson(json);
}

@freezed
class ServicesResponse with _$ServicesResponse {
  const factory ServicesResponse({
    List<String>? free,
    List<String>? paid,
  }) = _ServicesResponse;

  factory ServicesResponse.fromJson(Map<String, dynamic> json) => _$ServicesResponseFromJson(json);
}
