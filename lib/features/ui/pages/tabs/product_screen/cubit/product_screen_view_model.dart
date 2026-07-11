import 'package:e_commerce_flutter_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_flutter_app/domain/use_cases/get_all_products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'product_screen_states.dart';

@injectable
class ProductScreenViewModel extends Cubit<ProductScreenStates> {
  GetAllProductsUseCase getAllProductsUseCase;

  ProductScreenViewModel({required this.getAllProductsUseCase})
    : super(ProductScreenLoadingState()) {}

  // TODO: replace with real API call later
  Future<void> getProducts() async {
    try {
      emit(ProductScreenLoadingState());

      var productsList = await getAllProductsUseCase.invoke();

      emit(ProductScreenSuccessState(productsList: productsList));
    } on AppException catch (e) {
      emit(ProductScreenErrorState(message: e.errorMessage));
    }
  }
}
