import 'package:e_commerce_flutter_app/domain/entinties/response/products/sub_category.dart';

import '../category/category_or_brand.dart';

class Product {
  final int? sold;
  final List<String>? images;
  final List<SubCategory>? subcategory;
  final int? ratingsQuantity;
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final int? quantity;
  final int? price;
  final String? imageCover;
  final CategoryOrBrand? category;
  final CategoryOrBrand? brand;
  final double? ratingsAverage;

  Product({
    this.sold,
    this.images,
    this.subcategory,
    this.ratingsQuantity,
    this.id,
    this.title,
    this.slug,
    this.description,
    this.quantity,
    this.price,
    this.imageCover,
    this.category,
    this.brand,
    this.ratingsAverage,
  });
}
