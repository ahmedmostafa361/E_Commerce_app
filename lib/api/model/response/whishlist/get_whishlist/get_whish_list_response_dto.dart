import 'package:json_annotation/json_annotation.dart';

import '../../product/product_dto.dart';

part 'get_whish_list_response_dto.g.dart';

@JsonSerializable()
class GetWhishListResponseDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "count")
  final int? count;
  @JsonKey(name: "data")
  final List<ProductDto>? data;

  GetWhishListResponseDto({this.status, this.count, this.data});

  factory GetWhishListResponseDto.fromJson(Map<String, dynamic> json) {
    return _$GetWhishListResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetWhishListResponseDtoToJson(this);
  }
}
