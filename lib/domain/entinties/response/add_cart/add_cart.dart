import 'package:e_commerce_flutter_app/domain/entinties/response/add_cart/add_product.dart';

class AddCart {
  final String? id;
  final String? cartOwner;
  final List<AddProduct>? products;
  final String? createdAt;
  final String? updatedAt;
  final int? V;
  final int? totalCartPrice;

  AddCart({
    this.id,
    this.cartOwner,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.V,
    this.totalCartPrice,
  });
}
