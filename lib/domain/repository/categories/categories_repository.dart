import 'package:e_commerce_flutter_app/domain/entinties/response/category/category.dart';

abstract class CategoriesRepository {
  Future<List<Category>?> getAllCategories();
}
