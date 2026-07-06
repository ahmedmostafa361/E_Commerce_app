import 'package:e_commerce_flutter_app/api/mappers/cart/add_cart_mappers.dart';
import 'package:e_commerce_flutter_app/api/model/response/cart/add_cart/add_cart_response_dto.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/add_cart/add_cart_response.dart';

extension AddCartResponseMappers on AddCartResponseDto {
  AddCartResponse toAddCartResponse() {
    return AddCartResponse(
      status: status,
      message: message,
      numOfCartItems: numOfCartItems,
      cartId: cartId,
      data: data?.toAddCart(),
    );
  }
}
