import 'package:e_commerce_flutter_app/domain/entinties/response/add_cart/add_cart_response.dart';

abstract class CartRepository {
  Future<AddCartResponse> addToCart(String productId);
}
