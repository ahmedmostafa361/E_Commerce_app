import '../products/product.dart';

class GetWhishListResponse {
  final String? status;
  final int? count;
  final List<Product>? data;

  GetWhishListResponse({this.status, this.count, this.data});
}
