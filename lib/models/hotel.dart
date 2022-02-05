import 'package:json_annotation/json_annotation.dart';

part 'hotel.g.dart';

@JsonSerializable(explicitToJson: true)
class Hotel {
  Hotel({
    this.uuid,
    this.name,
    this.poster,
    this.address,
    this.price,
    this.rating,
    this.services,
    this.photos,
  });

  String? uuid;
  String? name;
  String? poster;
  Address? address;
  double? price;
  double? rating;
  Services? services;
  List<String>? photos;

  static Future<Hotel>? parseHotel(dynamic responseData) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return Hotel.fromJson(responseData);
    } catch (e) {
      return Future.error(e);
    }
  }

  factory Hotel.fromJson(Map<String, dynamic> json) => _$HotelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Address {
  Address({
    this.country,
    this.street,
    this.city,
    this.zipCode,
    this.coords,
  });

  final String? country;
  final String? street;
  final String? city;
  final int? zipCode;
  final Coords? coords;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Coords {
  Coords({
    this.lat,
    this.lan,
  });

  final double? lat;
  final double? lan;

  factory Coords.fromJson(Map<String, dynamic> json) => _$CoordsFromJson(json);

  Map<String, dynamic> toJson() => _$CoordsToJson(this);
}

@JsonSerializable()
class Services {
  Services({
    this.free,
    this.paid,
  });

  final List<String>? free;
  final List<String>? paid;

  factory Services.fromJson(Map<String, dynamic> json) =>
      _$ServicesFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class HotelPreview {
  final String uuid;
  final String? name;
  final String? poster;

  HotelPreview({required this.uuid, this.name, this.poster});

  static Future<List<HotelPreview>>? parseHotelsPreview(
      dynamic responseData) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return List<HotelPreview>.from(
          responseData.map((preview) => HotelPreview.fromJson(preview)));
    } catch (e) {
      return Future.error(e);
    }
  }

  factory HotelPreview.fromJson(Map<String, dynamic> json) =>
      _$HotelPreviewFromJson(json);

  Map<String, dynamic> toJson() => _$HotelPreviewToJson(this);
}
