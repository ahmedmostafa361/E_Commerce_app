import 'package:json_annotation/json_annotation.dart';

import '../common/category_or_brand_dto.dart';
import '../common/meta_data_dto.dart';

part 'category_response_dto.g.dart';

@JsonSerializable()
class CategoryResponseDto {
  @JsonKey(name: "results")
  final int? results;
  @JsonKey(name: "metadata")
  final MetaDataDto? metadata;
  @JsonKey(name: "data")
  final List<CategoryOrBrandDto>? data;

  CategoryResponseDto({this.results, this.metadata, this.data});

  factory CategoryResponseDto.fromJson(Map<String, dynamic> json) {
    return _$CategoryResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoryResponseDtoToJson(this);
  }
}
