import 'package:e_commerce_flutter_app/domain/entinties/response/products/product.dart';

abstract class ProductsRemoteDataSource {
  Future<List<Product>?> getAllProducts();
}
