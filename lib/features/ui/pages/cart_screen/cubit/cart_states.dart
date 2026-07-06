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
