// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaDataDto _$MetaDataDtoFromJson(Map<String, dynamic> json) => MetaDataDto(
  currentPage: (json['currentPage'] as num?)?.toInt(),
  numberOfPages: (json['numberOfPages'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
);

Map<String, dynamic> _$MetaDataDtoToJson(MetaDataDto instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'numberOfPages': instance.numberOfPages,
      'limit': instance.limit,
    };
