import 'package:e_commerce_flutter_app/domain/entinties/response/category/category_or_brand.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/common/meta_data.dart';

class CategoryResponse {
  final int? results;
  final MetaData? metadata;
  final List<CategoryOrBrand>? data;

  CategoryResponse({this.results, this.metadata, this.data});
}
