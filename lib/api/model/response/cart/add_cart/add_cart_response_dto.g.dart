// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_cart_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCartResponseDto _$AddCartResponseDtoFromJson(Map<String, dynamic> json) =>
    AddCartResponseDto(
      status: json['status'] as String?,
      message: json['message'] as String?,
      numOfCartItems: (json['numOfCartItems'] as num?)?.toInt(),
      cartId: json['cartId'] as String?,
      data: json['data'] == null
          ? null
          : AddCartDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddCartResponseDtoToJson(AddCartResponseDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'numOfCartItems': instance.numOfCartItems,
      'cartId': instance.cartId,
      'data': instance.data,
    };
