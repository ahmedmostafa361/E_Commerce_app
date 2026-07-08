import 'package:e_commerce_flutter_app/domain/entinties/response/add_cart/get_cart.dart';

sealed class AddCartStates {}

class CartInitialStates extends AddCartStates {}

class AddCartLoadingState extends AddCartStates {}

class AddCartSuccessState extends AddCartStates {
  int numOfCartItems;

  AddCartSuccessState({required this.numOfCartItems});
}

class AddCartErrorState extends AddCartStates {
  final String message;

  AddCartErrorState({required this.message});
}

/// get cart states

class GetCartLoadingState extends AddCartStates {}

class GetCartSuccessState extends AddCartStates {
  GetCart getCart;

  GetCartSuccessState({required this.getCart});
}

class GetCartErrorState extends AddCartStates {
  final String message;

  GetCartErrorState({required this.message});
}
