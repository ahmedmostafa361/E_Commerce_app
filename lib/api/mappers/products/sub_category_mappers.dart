import 'package:e_commerce_flutter_app/api/model/response/common/sub_category_dto.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/products/sub_category.dart';

extension SubCategoryMappers on SubCategoryDto {
  SubCategory toSubCategory() {
    return SubCategory(id: id, category: category, name: name, slug: slug);
  }
}
