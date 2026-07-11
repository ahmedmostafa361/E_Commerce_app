import 'package:e_commerce_flutter_app/domain/entinties/response/category/category_or_brand.dart';
import 'package:e_commerce_flutter_app/domain/repository/categories/categories_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCategoriesUseCase {
  CategoriesRepository categoriesRepository;

  GetAllCategoriesUseCase({required this.categoriesRepository});

  Future<List<CategoryOrBrand>?> invoke() {
    return categoriesRepository.getAllCategories();
  }
}
