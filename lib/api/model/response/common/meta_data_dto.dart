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
  @JsonKey(name: "nextPage")
  final int? nextPage;

  MetaDataDto(
      {this.currentPage, this.numberOfPages, this.limit, this.nextPage});

  factory MetaDataDto.fromJson(Map<String, dynamic> json) {
    return _$MetaDataDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetaDataDtoToJson(this);
  }
}
