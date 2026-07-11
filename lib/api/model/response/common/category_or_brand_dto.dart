import 'package:json_annotation/json_annotation.dart';

part 'category_or_brand_dto.g.dart';

@JsonSerializable()
class CategoryOrBrandDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;

  CategoryOrBrandDto({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryOrBrandDto.fromJson(Map<String, dynamic> json) {
    return _$CategoryOrBrandDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoryOrBrandDtoToJson(this);
  }
}
