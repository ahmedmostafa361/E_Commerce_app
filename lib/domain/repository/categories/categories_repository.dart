import 'package:e_commerce_flutter_app/domain/entinties/response/category/category_or_brand.dart';

abstract class CategoriesRepository {
  Future<List<CategoryOrBrand>?> getAllCategories();
}
