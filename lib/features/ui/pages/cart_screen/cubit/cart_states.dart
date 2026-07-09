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

/// delete & update cart states

class DeleteItemInCartLoadingState extends AddCartStates {}

class DeleteItemInCartSuccessState extends AddCartStates {
  GetCart getCart;

  DeleteItemInCartSuccessState({required this.getCart});
}

class DeleteItemInCartErrorState extends AddCartStates {
  final String message;

  DeleteItemInCartErrorState({required this.message});
}

class UpdateItemInCartLoadingState extends AddCartStates {}

class UpdateItemInCartSuccessState extends AddCartStates {
  GetCart getCart;

  UpdateItemInCartSuccessState({required this.getCart});
}

class UpdateItemInCartErrorState extends AddCartStates {
  final String message;

  UpdateItemInCartErrorState({required this.message});
}