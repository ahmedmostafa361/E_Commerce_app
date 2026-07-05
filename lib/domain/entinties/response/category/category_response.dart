import 'package:e_commerce_flutter_app/domain/entinties/response/category/category.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/common/meta_data.dart';

class CategoryResponse {
  final int? results;
  final MetaData? metadata;
  final List<Category>? data;

  CategoryResponse({this.results, this.metadata, this.data});
}
