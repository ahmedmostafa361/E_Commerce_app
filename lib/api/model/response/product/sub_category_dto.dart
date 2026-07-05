import 'package:json_annotation/json_annotation.dart';

part 'sub_category_dto.g.dart';

@JsonSerializable()
class SubCategoryDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "category")
  final String? category;

  SubCategoryDto({this.id, this.name, this.slug, this.category});

  factory SubCategoryDto.fromJson(Map<String, dynamic> json) {
    return _$SubCategoryDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubCategoryDtoToJson(this);
  }
}
