import 'package:e_commerce_flutter_app/domain/entinties/response/add_cart/get_products.dart';
import 'package:e_commerce_flutter_app/domain/use_cases/add_to_cart_use_case.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/app_exception.dart';
import '../../../../../domain/use_cases/delete_items_cart_use_case.dart';
import '../../../../../domain/use_cases/get_items_cart_use_case.dart';
import '../../../../../domain/use_cases/update_items_cart_use_case.dart';

@injectable
class CartViewModel extends Cubit<AddCartStates> {
  AddToCartUseCase addToCartUseCase;
  GetItemsCartUseCase getItemsCartUseCase;
  DeleteItemsCartUseCase deleteItemsCartUseCase;
  UpdateItemsCartUseCase updateItemsCartUseCase;


  CartViewModel({required this.addToCartUseCase,
    required this.getItemsCartUseCase,
    required this.deleteItemsCartUseCase,
    required this.updateItemsCartUseCase})
      : super(CartInitialStates());
  int numOfCartItems = 0;

  List<GetProducts> productsList = [];
  static CartViewModel get(context) => BlocProvider.of<CartViewModel>(context);

  Future<void> addToCart(String productId) async {
    try {
      emit(AddCartLoadingState());

      var addCartResponse = await addToCartUseCase.invoke(productId);
      numOfCartItems = addCartResponse.numOfCartItems ?? 0;

      emit(AddCartSuccessState(numOfCartItems: numOfCartItems));
    } on AppException catch (e) {
      emit(AddCartErrorState(message: e.errorMessage));
    }
  }

  /// get cart view model
  Future<void> getItemsCart() async {
    try {
      emit(GetCartLoadingState());

      var getCartResponse = await getItemsCartUseCase.invoke();
      numOfCartItems = getCartResponse.numOfCartItems ?? 0;
      productsList = getCartResponse.data!.products ?? [];
      emit(GetCartSuccessState(getCart: getCartResponse.data!));
    } on AppException catch (e) {
      emit(GetCartErrorState(message: e.errorMessage));
    }
  }

  /// delete cart view model
  Future<void> deleteItemsCart(String productId) async {
    try {
      emit(DeleteItemInCartLoadingState());

      var deleteCartResponse = await deleteItemsCartUseCase.invoke(productId);
      numOfCartItems = deleteCartResponse.numOfCartItems ?? 0;
      // productsList = deleteCartResponse.data!.products ?? []; dont need it the state already cover it
      emit(DeleteItemInCartSuccessState(getCart: deleteCartResponse.data!));
    } on AppException catch (e) {
      emit(DeleteItemInCartErrorState(message: e.errorMessage));
    }
  }

  /// update cart view model
  Future<void> updateItemsInCart(String productId, int count) async {
    try {
      var updateItemInCartResponse = await updateItemsCartUseCase.invoke(
          productId, count);
      // numOfCartItems = updateItemInCartResponse.numOfCartItems ?? 0; dont need it here if need it use it
      // productsList = deleteCartResponse.data!.products ?? []; dont need it the state already cover it if need it use it
      emit(UpdateItemInCartSuccessState(
          getCart: updateItemInCartResponse.data!));
    } on AppException catch (e) {
      emit(UpdateItemInCartErrorState(message: e.errorMessage));
    }
  }

}
