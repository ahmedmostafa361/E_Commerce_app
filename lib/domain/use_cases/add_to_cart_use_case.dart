import 'package:e_commerce_flutter_app/domain/repository/add_cart/cart_repository.dart';
import 'package:injectable/injectable.dart';

import '../entinties/response/add_cart/add_cart_response.dart';

@injectable
class AddToCartUseCase {
  CartRepository cartRepository;

  AddToCartUseCase({required this.cartRepository});

  Future<AddCartResponse> invoke(String productId) {
    return cartRepository.addToCart(productId);
  }
}
