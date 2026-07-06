import 'package:json_annotation/json_annotation.dart';

part 'add_product_request_dto.g.dart';

@JsonSerializable()
class AddProductRequestDto {
  @JsonKey(name: "productId")
  final String? productId;

  AddProductRequestDto({this.productId});

  factory AddProductRequestDto.fromJson(Map<String, dynamic> json) {
    return _$AddProductRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddProductRequestDtoToJson(this);
  }
}
