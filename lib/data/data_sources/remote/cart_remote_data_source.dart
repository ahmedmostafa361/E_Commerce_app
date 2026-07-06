import '../../../domain/entinties/response/add_cart/add_cart_response.dart';

abstract class CartRemoteDataSource {
  Future<AddCartResponse> addToCart(String productId);
}
