// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCartDto _$AddCartDtoFromJson(Map<String, dynamic> json) => AddCartDto(
  id: json['_id'] as String?,
  cartOwner: json['cartOwner'] as String?,
  products: (json['products'] as List<dynamic>?)
      ?.map((e) => AddProductDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  V: (json['__v'] as num?)?.toInt(),
  totalCartPrice: (json['totalCartPrice'] as num?)?.toInt(),
);

Map<String, dynamic> _$AddCartDtoToJson(AddCartDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'cartOwner': instance.cartOwner,
      'products': instance.products,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.V,
      'totalCartPrice': instance.totalCartPrice,
    };
