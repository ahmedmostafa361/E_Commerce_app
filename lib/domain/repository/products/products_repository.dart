import 'package:e_commerce_flutter_app/domain/entinties/response/products/product.dart';

abstract class ProductsRepository {
  Future<List<Product>?> getAllProducts();
}
