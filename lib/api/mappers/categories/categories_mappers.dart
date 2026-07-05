import 'package:e_commerce_flutter_app/api/model/response/category/category_dto.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/category/category.dart';

extension CategoriesMappers on CategoryDto {
  Category toCategory() {
    return Category(image: image, name: name, id: id, slug: slug);
  }
}
