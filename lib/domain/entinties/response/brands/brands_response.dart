import 'package:e_commerce_flutter_app/domain/entinties/response/common/meta_data.dart';

import '../category/category_or_brand.dart';

class BrandsResponseDto {
  final int? results;
  final MetaData? metadata;
  final List<CategoryOrBrand>? data;

  BrandsResponseDto({this.results, this.metadata, this.data});
}
