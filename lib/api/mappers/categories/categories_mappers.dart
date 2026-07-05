import 'package:e_commerce_flutter_app/api/model/response/common/category_or_brand_dto.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/category/category_or_brand.dart';

extension CategoriesMappers on CategoryOrBrandDto {
  CategoryOrBrand toCategory() {
    return CategoryOrBrand(image: image, name: name, id: id, slug: slug);
  }
}
