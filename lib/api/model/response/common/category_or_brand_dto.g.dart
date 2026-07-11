// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_or_brand_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryOrBrandDto _$CategoryOrBrandDtoFromJson(Map<String, dynamic> json) =>
    CategoryOrBrandDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CategoryOrBrandDtoToJson(CategoryOrBrandDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
