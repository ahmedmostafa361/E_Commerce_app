import 'package:e_commerce_flutter_app/domain/entinties/response/products/product.dart';

import '../common/meta_data.dart';

class ProductResponse {
  final int? results;
  final MetaData? metadata;
  final List<Product>? data;

  ProductResponse({this.results, this.metadata, this.data});
}
