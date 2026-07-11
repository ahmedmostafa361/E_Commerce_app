import 'package:json_annotation/json_annotation.dart';

import 'get_cart_dto.dart';

part 'get_cart_response_dto.g.dart';

@JsonSerializable()
class GetCartResponseDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  @JsonKey(name: "cartId")
  final String? cartId;
  @JsonKey(name: "data")
  final GetCartDto? data;

  GetCartResponseDto({
    this.status,
    this.numOfCartItems,
    this.cartId,
    this.data,
  });

  factory GetCartResponseDto.fromJson(Map<String, dynamic> json) {
    return _$GetCartResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetCartResponseDtoToJson(this);
  }
}
