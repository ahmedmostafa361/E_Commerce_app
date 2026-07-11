import 'package:e_commerce_flutter_app/api/model/response/common/meta_data_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/category_or_brand_dto.dart';

part 'brands_response_dto.g.dart';

@JsonSerializable()
class BrandsResponseDto {
  @JsonKey(name: "results")
  final int? results;
  @JsonKey(name: "metadata")
  final MetaDataDto? metadata;
  @JsonKey(name: "data")
  final List<CategoryOrBrandDto>? data;

  BrandsResponseDto({this.results, this.metadata, this.data});

  factory BrandsResponseDto.fromJson(Map<String, dynamic> json) {
    return _$BrandsResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BrandsResponseDtoToJson(this);
  }
}
