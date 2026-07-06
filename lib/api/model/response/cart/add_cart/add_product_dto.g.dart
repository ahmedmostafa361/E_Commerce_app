// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProductDto _$AddProductDtoFromJson(Map<String, dynamic> json) =>
    AddProductDto(
      count: (json['count'] as num?)?.toInt(),
      id: json['_id'] as String?,
      product: json['product'] as String?,
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddProductDtoToJson(AddProductDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      '_id': instance.id,
      'product': instance.product,
      'price': instance.price,
    };
