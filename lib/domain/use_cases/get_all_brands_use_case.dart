import 'package:e_commerce_flutter_app/domain/entinties/response/category/category_or_brand.dart';
import 'package:injectable/injectable.dart';

import '../repository/brands/brands_repository.dart';

@injectable
class GetAllBrandsUseCase {
  BrandsRepository brandsRepository;

  GetAllBrandsUseCase({required this.brandsRepository});

  Future<List<CategoryOrBrand>?> invoke() {
    return brandsRepository.getAllBrands();
  }
}
