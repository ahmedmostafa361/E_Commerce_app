import 'package:json_annotation/json_annotation.dart';

import 'get_products_dto.dart';

part 'get_cart_dto.g.dart';

@JsonSerializable()
class GetCartDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "cartOwner")
  final String? cartOwner;
  @JsonKey(name: "products")
  final List<GetProductsDto>? products;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? V;
  @JsonKey(name: "totalCartPrice")
  final int? totalCartPrice;

  GetCartDto({
    this.id,
    this.cartOwner,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.V,
    this.totalCartPrice,
  });

  factory GetCartDto.fromJson(Map<String, dynamic> json) {
    return _$GetCartDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetCartDtoToJson(this);
  }
}
