// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponseDto _$CategoryResponseDtoFromJson(Map<String, dynamic> json) =>
    CategoryResponseDto(
      results: (json['results'] as num?)?.toInt(),
      metadata: json['metadata'] == null
          ? null
          : MetaDataDto.fromJson(json['metadata'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryResponseDtoToJson(
  CategoryResponseDto instance,
) => <String, dynamic>{
  'results': instance.results,
  'metadata': instance.metadata,
  'data': instance.data,
};
