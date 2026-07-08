import 'package:e_commerce_flutter_app/api/mappers/cart/getCartMappers.dart';
import 'package:e_commerce_flutter_app/api/model/response/cart/get_cart/get_cart_response_dto.dart';

import '../../../domain/entinties/response/add_cart/get_cart_response.dart';

extension GetCartResponseMappers on GetCartResponseDto {
  GetCartResponse toGetCartResponse() {
    return GetCartResponse(
      status: status,
      numOfCartItems: numOfCartItems,
      cartId: cartId,
      data: data?.toGetCart(),
    );
  }
}
