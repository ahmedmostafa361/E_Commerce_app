import 'package:e_commerce_flutter_app/domain/entinties/response/products/product.dart';

class GetProducts {
  final int? count;
  final String? id;
  final Product? product;
  final int? price;

  GetProducts({this.count, this.id, this.product, this.price});
}
