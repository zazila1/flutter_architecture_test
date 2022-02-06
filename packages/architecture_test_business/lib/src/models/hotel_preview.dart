import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotel_preview.freezed.dart';
part 'hotel_preview.g.dart';

@freezed
class HotelPreview with _$HotelPreview {
  const factory HotelPreview({
    required String uuid,
    @Default('') String name,
    @Default('') String poster,
  }) = _HotelPreview;

  factory HotelPreview.fromJson(Map<String, dynamic> json) =>
      _$HotelPreviewFromJson(json);

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
}