import 'package:e_commerce_flutter_app/data/data_sources/remote/categories_remote_data_source.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/category/category_or_brand.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repository/categories/categories_repository.dart';

@Injectable(as: CategoriesRepository)
class CategoriesRepositoryImpl implements CategoriesRepository {
  CategoriesRemoteDataSource remoteDataSource;

  CategoriesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CategoryOrBrand>?> getAllCategories() {
    // TODO: implement getAllCategories
    return remoteDataSource.getAllCategories();
  }
}
