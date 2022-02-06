import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotels_preview_response.freezed.dart';
part 'hotels_preview_response.g.dart';

@freezed
class HotelPreview with _$HotelPreview {
  const factory HotelPreview({
    required String uuid,
    @Default('') String name,
    @Default('') String poster,
  }) = _HotelPreview;

  factory HotelPreview.fromJson(Map<String, dynamic> json) =>
      _$HotelPreviewFromJson(json);
}