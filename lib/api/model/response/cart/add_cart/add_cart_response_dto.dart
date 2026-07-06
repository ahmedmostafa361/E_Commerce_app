import 'package:json_annotation/json_annotation.dart';

import 'add_cart_dto.dart';

part 'add_cart_response_dto.g.dart';

@JsonSerializable()
class AddCartResponseDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  @JsonKey(name: "cartId")
  final String? cartId;
  @JsonKey(name: "data")
  final AddCartDto? data;

  AddCartResponseDto({
    this.status,
    this.message,
    this.numOfCartItems,
    this.cartId,
    this.data,
  });

  factory AddCartResponseDto.fromJson(Map<String, dynamic> json) {
    return _$AddCartResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddCartResponseDtoToJson(this);
  }
}
