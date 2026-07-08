// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCartDto _$GetCartDtoFromJson(Map<String, dynamic> json) => GetCartDto(
  id: json['_id'] as String?,
  cartOwner: json['cartOwner'] as String?,
  products: (json['products'] as List<dynamic>?)
      ?.map((e) => GetProductsDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  V: (json['__v'] as num?)?.toInt(),
  totalCartPrice: (json['totalCartPrice'] as num?)?.toInt(),
);

Map<String, dynamic> _$GetCartDtoToJson(GetCartDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'cartOwner': instance.cartOwner,
      'products': instance.products,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.V,
      'totalCartPrice': instance.totalCartPrice,
    };
