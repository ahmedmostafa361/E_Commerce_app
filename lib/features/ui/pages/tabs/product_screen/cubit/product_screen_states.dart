import 'package:e_commerce_flutter_app/domain/entinties/response/products/product.dart';

abstract class ProductScreenStates {}

class ProductScreenInitialStates extends ProductScreenStates {}

class ProductScreenLoadingState extends ProductScreenStates {}

class ProductScreenSuccessState extends ProductScreenStates {
  List<Product>? productsList;

  ProductScreenSuccessState({required this.productsList});
}

class ProductScreenErrorState extends ProductScreenStates {
  final String message;

  ProductScreenErrorState({required this.message});
}
