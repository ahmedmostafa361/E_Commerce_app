import 'package:e_commerce_flutter_app/domain/entinties/response/products/product.dart';
import 'package:e_commerce_flutter_app/domain/repository/products/products_repository.dart';
import 'package:injectable/injectable.dart';

import '../../data_sources/remote/products_remote_data_source.dart';

@Injectable(as: ProductsRepository)
class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRemoteDataSource remoteDataSource;

  ProductsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>?> getAllProducts() {
    // TODO: implement getAllBrands
    return remoteDataSource.getAllProducts();
  }
}
