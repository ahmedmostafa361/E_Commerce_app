import 'package:json_annotation/json_annotation.dart';

part 'count_request_dto.g.dart';

@JsonSerializable()
class CountRequestDto {
  @JsonKey(name: "count")
  final String? count;

  CountRequestDto({this.count});

  factory CountRequestDto.fromJson(Map<String, dynamic> json) {
    return _$CountRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CountRequestDtoToJson(this);
  }
}
