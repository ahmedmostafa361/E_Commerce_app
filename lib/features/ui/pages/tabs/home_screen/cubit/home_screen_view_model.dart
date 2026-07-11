import 'package:e_commerce_flutter_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_flutter_app/domain/use_cases/get_all_brands_use_case.dart';
import 'package:e_commerce_flutter_app/domain/use_cases/get_all_categories_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'home_screen_states.dart';

@injectable
class HomeScreenViewModel extends Cubit<HomeScreenState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetAllBrandsUseCase getAllBrandsUseCase;

  HomeScreenViewModel({
    required this.getAllCategoriesUseCase,
    required this.getAllBrandsUseCase,
  }) : super(
    const HomeScreenState(
      isCategoriesLoading: true,
      isBrandsLoading: true,
    ),
  );

  Future<void> getCategories() async {
    emit(
      state.copyWith(
        isCategoriesLoading: true,
        categoriesError: null,
      ),
    );

    try {
      final categories = await getAllCategoriesUseCase.invoke();

      emit(
        state.copyWith(
          isCategoriesLoading: false,
          categoriesList: categories,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          isCategoriesLoading: false,
          categoriesError: e.errorMessage,
        ),
      );
    }
  }

  Future<void> getBrands() async {
    emit(
      state.copyWith(
        isBrandsLoading: true,
        brandsError: null,
      ),
    );

    try {
      final brands = await getAllBrandsUseCase.invoke();

      emit(
        state.copyWith(
          isBrandsLoading: false,
          brandsList: brands,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          isBrandsLoading: false,
          brandsError: e.errorMessage,
        ),
      );
    }
  }
}