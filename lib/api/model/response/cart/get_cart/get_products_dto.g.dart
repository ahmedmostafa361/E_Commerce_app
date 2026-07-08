// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_products_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductsDto _$GetProductsDtoFromJson(Map<String, dynamic> json) =>
    GetProductsDto(
      count: (json['count'] as num?)?.toInt(),
      id: json['_id'] as String?,
      product: json['product'] == null
          ? null
          : ProductDto.fromJson(json['product'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetProductsDtoToJson(GetProductsDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      '_id': instance.id,
      'product': instance.product,
      'price': instance.price,
    };
