import '../../../domain/entinties/response/category/category.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<Category>?> getAllCategories();
}
