import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotels_preview_response.freezed.dart';
part 'hotels_preview_response.g.dart';

@freezed
class HotelsPreviewResponse with _$HotelsPreviewResponse {
  const factory HotelsPreviewResponse({
    required String uuid,
    @Default('') String name,
    @Default('') String poster,
  }) = _HotelsPreviewResponse;

  factory HotelsPreviewResponse.fromJson(Map<String, dynamic> json) =>
      _$HotelsPreviewResponseFromJson(json);
}
