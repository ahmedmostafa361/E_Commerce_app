import 'package:e_commerce_flutter_app/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/add_cart/add_cart_response.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/add_cart/get_cart_response.dart';
import 'package:e_commerce_flutter_app/domain/repository/add_cart/cart_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AddCartResponse> addToCart(String productId) {
    return remoteDataSource.addToCart(productId);
  }

  @override
  Future<GetCartResponse> getItemsCart() {
    return remoteDataSource.getItemsCart();
  }

  @override
  Future<GetCartResponse> deleteItemsInCart(String productId) {
    return remoteDataSource.deleteItemsInCart(productId);
  }

  @override
  Future<GetCartResponse> updateCountInCart(String productId, int count) {
    return remoteDataSource.updateCountInCart(productId, count);
  }
}
