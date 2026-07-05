import 'package:json_annotation/json_annotation.dart';

part 'meta_data_dto.g.dart';

@JsonSerializable()
class MetaDataDto {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "numberOfPages")
  final int? numberOfPages;
  @JsonKey(name: "limit")
  final int? limit;

  MetaDataDto({this.currentPage, this.numberOfPages, this.limit});

  factory MetaDataDto.fromJson(Map<String, dynamic> json) {
    return _$MetaDataDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetaDataDtoToJson(this);
  }
}
