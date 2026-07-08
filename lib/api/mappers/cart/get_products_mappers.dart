import 'package:e_commerce_flutter_app/api/mappers/products/products_mappers.dart';
import 'package:e_commerce_flutter_app/api/model/response/cart/get_cart/get_products_dto.dart';

import '../../../domain/entinties/response/add_cart/get_products.dart';

extension GetProductsMappers on GetProductsDto {
  GetProducts toGetProducts() {
    return GetProducts(
      id: id,
      price: price,
      count: count,
      product: product!.toProduct(),
    );
  }
}
