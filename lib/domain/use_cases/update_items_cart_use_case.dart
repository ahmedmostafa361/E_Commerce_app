import 'package:e_commerce_flutter_app/domain/repository/add_cart/cart_repository.dart';
import 'package:injectable/injectable.dart';

import '../entinties/response/add_cart/get_cart_response.dart';

@injectable
class UpdateItemsCartUseCase {
  CartRepository cartRepository;

  UpdateItemsCartUseCase({required this.cartRepository});

  Future<GetCartResponse> invoke(String productId, int count) {
    return cartRepository.updateCountInCart(productId, count);
  }
}
