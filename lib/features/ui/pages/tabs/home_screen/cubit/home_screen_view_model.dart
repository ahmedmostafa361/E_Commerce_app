import 'package:e_commerce_flutter_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_flutter_app/domain/use_cases/get_all_categories_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'home_screen_states.dart';

@injectable
class HomeScreenViewModel extends Cubit<HomeScreenStates> {
  GetAllCategoriesUseCase getAllCategoriesUseCase;

  HomeScreenViewModel({required this.getAllCategoriesUseCase})
    : super(HomeScreenInitialStates()) {
    // getCategories();
  }

  // TODO: replace with real API call later
  Future<void> getCategories() async {
    try {
      emit(CategoriesLoadingState());

      var categoriesList = await getAllCategoriesUseCase.invoke();

      emit(CategoriesSuccessState(categoriesList: categoriesList));
    } on AppException catch (e) {
      emit(CategoriesErrorState(message: e.errorMessage));
    }
  }
}
