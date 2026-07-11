import 'package:e_commerce_flutter_app/domain/repository/add_cart/cart_repository.dart';
import 'package:injectable/injectable.dart';

import '../entinties/response/add_cart/get_cart_response.dart';

@injectable
class GetItemsCartUseCase {
  CartRepository cartRepository;

  GetItemsCartUseCase({required this.cartRepository});

  Future<GetCartResponse> invoke() {
    return cartRepository.getItemsCart();
  }
}
