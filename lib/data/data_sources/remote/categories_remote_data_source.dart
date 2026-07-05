import '../../../domain/entinties/response/category/category_or_brand.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryOrBrand>?> getAllCategories();
}
