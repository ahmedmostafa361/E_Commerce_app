import 'package:json_annotation/json_annotation.dart';

part 'add_whish_list_response_dto.g.dart';

@JsonSerializable()
class AddWhishListResponseDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "data")
  final List<String>? data;

  AddWhishListResponseDto({this.status, this.message, this.data});

  factory AddWhishListResponseDto.fromJson(Map<String, dynamic> json) {
    return _$AddWhishListResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddWhishListResponseDtoToJson(this);
  }
}
