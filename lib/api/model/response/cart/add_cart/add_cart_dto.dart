import 'package:e_commerce_flutter_app/api/model/response/cart/add_cart/add_product_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_cart_dto.g.dart';

@JsonSerializable()
class AddCartDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "cartOwner")
  final String? cartOwner;
  @JsonKey(name: "products")
  final List<AddProductDto>? products;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? V;
  @JsonKey(name: "totalCartPrice")
  final int? totalCartPrice;

  AddCartDto({
    this.id,
    this.cartOwner,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.V,
    this.totalCartPrice,
  });

  factory AddCartDto.fromJson(Map<String, dynamic> json) {
    return _$AddCartDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddCartDtoToJson(this);
  }
}
