import 'package:e_commerce_flutter_app/features/ui/pages/tabs/whishlist_screen/cubit/whish_list_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/exceptions/app_exception.dart';
import '../../../../../../domain/entinties/response/products/product.dart';
import '../../../../../../domain/use_cases/add_to_whish_list_use_case.dart';
import '../../../../../../domain/use_cases/delete_items_whish_list_use_case.dart';
import '../../../../../../domain/use_cases/get_items_whish_list_use_case.dart';

@injectable
class WhishListViewModel extends Cubit<AddWhishListStates> {
  AddToWhishlListUseCase addToWhishlListUseCase;
  GetItemsWhishListUseCase getItemsWhishListUseCase;
  DeleteItemsWhishListUseCase deleteItemsWhishListUseCase;

  WhishListViewModel({
    required this.addToWhishlListUseCase,
    required this.getItemsWhishListUseCase,
    required this.deleteItemsWhishListUseCase,
  }) : super(WhishListInitialStates());

  List<Product> whishList = [];

  static WhishListViewModel get(context) =>
      BlocProvider.of<WhishListViewModel>(context);

  Future<void> addToWhishList(String productId) async {
    try {
      emit(AddWhishListLoadingState());

      final response = await addToWhishlListUseCase.invoke(productId);

      emit(AddWhishListSuccessState(response: response));
    } on AppException catch (e) {
      emit(AddWhishListErrorState(message: e.errorMessage));
    }
  }

  /// get whsihList view model
  Future<void> getItemsWhishList() async {
    try {
      emit(GetWhishListLoadingState());

      var getWhishListResponse = await getItemsWhishListUseCase.invoke();
      whishList = getWhishListResponse.data ?? [];

      emit(
        GetWhishListSuccessState(getWhishListResponse: getWhishListResponse),
      );
    } on AppException catch (e) {
      emit(GetWhishListErrorState(message: e.errorMessage));
    }
  }

  /// delete whsihList view model
  Future<void> deleteItemsWhishList(String productId) async {
    try {
      emit(DeleteItemInWhishListLoadingState());

      final response = await deleteItemsWhishListUseCase.invoke(productId);

      whishList = response.data ?? [];

      emit(DeleteItemInWhishListSuccessState(getWhishListResponse: response));
    } on AppException catch (e) {
      emit(DeleteItemInWhishListErrorState(message: e.errorMessage));
    }
  }
}
