// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_whish_list_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddWhishListResponseDto _$AddWhishListResponseDtoFromJson(
  Map<String, dynamic> json,
) => AddWhishListResponseDto(
  status: json['status'] as String?,
  message: json['message'] as String?,
  data: (json['data'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$AddWhishListResponseDtoToJson(
  AddWhishListResponseDto instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
