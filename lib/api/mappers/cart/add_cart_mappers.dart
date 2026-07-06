import 'package:e_commerce_flutter_app/api/mappers/cart/add_product_mappers.dart';
import 'package:e_commerce_flutter_app/api/model/response/cart/add_cart/add_cart_dto.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/add_cart/add_cart.dart';

extension AddCartMappers on AddCartDto {
  AddCart toAddCart() {
    return AddCart(
      id: id,
      cartOwner: cartOwner,
      products:
          products
              ?.map((addProductDto) => addProductDto.toAddProduct())
              .toList() ??
          [],
      createdAt: createdAt,
      updatedAt: updatedAt,
      V: V,
      totalCartPrice: totalCartPrice,
    );
  }
}
