import 'package:e_commerce_flutter_app/domain/entinties/response/add_cart/get_cart.dart';

class GetCartResponse {
  final String? status;
  final int? numOfCartItems;
  final String? cartId;
  final GetCart? data;

  GetCartResponse({this.status, this.numOfCartItems, this.cartId, this.data});
}
