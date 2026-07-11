import 'package:e_commerce_flutter_app/api/mappers/categories/categories_mappers.dart';
import 'package:e_commerce_flutter_app/api/mappers/products/sub_category_mappers.dart';
import 'package:e_commerce_flutter_app/api/model/response/product/product_dto.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/products/product.dart';

extension ProductsMappers on ProductDto {
  Product toProduct() {
    return Product(
      id: id,
      title: title,
      slug: slug,
      description: description,
      quantity: quantity,
      price: price,
      imageCover: imageCover,
      category: category!.toCategory(),
      brand: brand!.toCategory(),
      ratingsAverage: ratingsAverage,
      ratingsQuantity: ratingsQuantity,
      sold: sold,
      images: images,

      /// todo : convert it from List subcategoryDto to List subcategory
      subcategory:
          subcategory?.map((subDto) => subDto.toSubCategory()).toList() ?? [],
    );
  }
}
