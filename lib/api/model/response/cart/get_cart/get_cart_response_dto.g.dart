// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cart_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCartResponseDto _$GetCartResponseDtoFromJson(Map<String, dynamic> json) =>
    GetCartResponseDto(
      status: json['status'] as String?,
      numOfCartItems: (json['numOfCartItems'] as num?)?.toInt(),
      cartId: json['cartId'] as String?,
      data: json['data'] == null
          ? null
          : GetCartDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCartResponseDtoToJson(GetCartResponseDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'numOfCartItems': instance.numOfCartItems,
      'cartId': instance.cartId,
      'data': instance.data,
    };
