import 'package:json_annotation/json_annotation.dart';

import '../../product/product_dto.dart';

part 'get_products_dto.g.dart';

@JsonSerializable()
class GetProductsDto {
  @JsonKey(name: "count")
  final int? count;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "product")
  final ProductDto? product;
  @JsonKey(name: "price")
  final int? price;

  GetProductsDto({this.count, this.id, this.product, this.price});

  factory GetProductsDto.fromJson(Map<String, dynamic> json) {
    return _$GetProductsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetProductsDtoToJson(this);
  }
}
