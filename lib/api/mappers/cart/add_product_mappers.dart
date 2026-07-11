import 'package:e_commerce_flutter_app/api/model/response/cart/add_cart/add_product_dto.dart';

import '../../../domain/entinties/response/add_cart/add_product.dart';

extension AddProductMappers on AddProductDto {
  AddProduct toAddProduct() {
    return AddProduct(count: count, id: id, product: product, price: price);
  }
}
