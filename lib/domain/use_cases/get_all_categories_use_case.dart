import 'package:e_commerce_flutter_app/domain/entinties/response/category/category.dart';
import 'package:e_commerce_flutter_app/domain/repository/categories/categories_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCategoriesUseCase {
  CategoriesRepository categoriesRepository;

  GetAllCategoriesUseCase({required this.categoriesRepository});

  Future<List<Category>?> invoke() {
    return categoriesRepository.getAllCategories();
  }
}
