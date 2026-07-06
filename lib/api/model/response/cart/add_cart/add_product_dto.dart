import 'package:json_annotation/json_annotation.dart';

part 'add_product_dto.g.dart';

@JsonSerializable()
class AddProductDto {
  @JsonKey(name: "count")
  final int? count;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "product")
  final String? product;
  @JsonKey(name: "price")
  final int? price;

  AddProductDto({this.count, this.id, this.product, this.price});

  factory AddProductDto.fromJson(Map<String, dynamic> json) {
    return _$AddProductDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddProductDtoToJson(this);
  }
}
