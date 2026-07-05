import 'package:e_commerce_flutter_app/domain/entinties/response/products/product.dart';
import 'package:injectable/injectable.dart';

import '../repository/products/products_repository.dart';

@injectable
class GetAllProductsUseCase {
  ProductsRepository productsRepository;

  GetAllProductsUseCase({required this.productsRepository});

  Future<List<Product>?> invoke() {
    return productsRepository.getAllProducts();
  }
}
