import 'package:e_commerce_flutter_app/domain/entinties/response/add_cart/add_cart_response.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/add_cart/get_cart_response.dart';

abstract class CartRepository {
  Future<AddCartResponse> addToCart(String productId);

  Future<GetCartResponse> getItemsCart();

  Future<GetCartResponse> deleteItemsInCart(String productId);

  Future<GetCartResponse> updateCountInCart(String productId, int count);
}
