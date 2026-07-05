// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brands_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandsResponseDto _$BrandsResponseDtoFromJson(Map<String, dynamic> json) =>
    BrandsResponseDto(
      results: (json['results'] as num?)?.toInt(),
      metadata: json['metadata'] == null
          ? null
          : MetaDataDto.fromJson(json['metadata'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryOrBrandDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BrandsResponseDtoToJson(BrandsResponseDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'metadata': instance.metadata,
      'data': instance.data,
    };
