import 'package:e_commerce_flutter_app/domain/use_cases/add_to_cart_use_case.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/app_exception.dart';

@injectable
class CartViewModel extends Cubit<AddCartStates> {
  AddToCartUseCase addToCartUseCase;

  CartViewModel({required this.addToCartUseCase}) : super(CartInitialStates());
  int numOfCartItems = 0;

  static CartViewModel get(context) => BlocProvider.of<CartViewModel>(context);

  Future<void> addToCart(String productId) async {
    try {
      emit(AddCartLoadingState());

      var addCartResponse = await addToCartUseCase.invoke(productId);
      numOfCartItems = addCartResponse.numOfCartItems ?? 0;
      print('numOfCartItems after add: $numOfCartItems');

      emit(AddCartSuccessState(numOfCartItems: numOfCartItems));
    } on AppException catch (e) {
      emit(AddCartErrorState(message: e.errorMessage));
    }
  }
}
