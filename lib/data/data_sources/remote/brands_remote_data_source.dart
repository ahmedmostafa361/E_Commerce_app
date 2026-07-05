import '../../../domain/entinties/response/category/category_or_brand.dart';

abstract class BrandsRemoteDataSource {
  Future<List<CategoryOrBrand>?> getAllBrands();
}
