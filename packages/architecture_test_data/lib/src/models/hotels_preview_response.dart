import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotels_preview_response.freezed.dart';
part 'hotels_preview_response.g.dart';

@freezed
class HotelPreviewResponse with _$HotelsPreviewResponse {
  const factory HotelPreviewResponse({
    required String uuid,
    @Default('') String name,
    @Default('') String poster,
  }) = _HotelsPreviewResponse;

  factory HotelPreviewResponse.fromJson(Map<String, dynamic> json) =>
      _$HotelsPreviewResponseFromJson(json);
}
