// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_whish_list_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWhishListResponseDto _$GetWhishListResponseDtoFromJson(
  Map<String, dynamic> json,
) => GetWhishListResponseDto(
  status: json['status'] as String?,
  count: (json['count'] as num?)?.toInt(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetWhishListResponseDtoToJson(
  GetWhishListResponseDto instance,
) => <String, dynamic>{
  'status': instance.status,
  'count': instance.count,
  'data': instance.data,
};
