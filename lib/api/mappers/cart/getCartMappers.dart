import 'package:e_commerce_flutter_app/api/mappers/cart/get_products_mappers.dart';
import 'package:e_commerce_flutter_app/api/model/response/cart/get_cart/get_cart_dto.dart';

import '../../../domain/entinties/response/add_cart/get_cart.dart';

extension GetCartMappers on GetCartDto {
  GetCart toGetCart() {
    return GetCart(
      id: id,
      cartOwner: cartOwner,
      products:
          products
              ?.map((getProductsDto) => getProductsDto.toGetProducts())
              .toList() ??
          [],
      createdAt: createdAt,
      updatedAt: updatedAt,
      totalCartPrice: totalCartPrice,
      V: V,
    );
  }
}
