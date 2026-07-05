import 'package:e_commerce_flutter_app/domain/entinties/response/category/category_or_brand.dart';

abstract class HomeScreenStates {}

class HomeScreenInitialStates extends HomeScreenStates {}

class CategoriesLoadingState extends HomeScreenStates {}

class CategoriesErrorState extends HomeScreenStates {
  final String message;

  CategoriesErrorState({required this.message});
}

// class CategoriesSuccessState extends HomeScreenStates {
//   List<CategoryOrBrand>? categoriesList;
//
//   CategoriesSuccessState({required this.categoriesList});
// }

/// todo: brands states
class BrandsLoadingState extends HomeScreenStates {}

class BrandsErrorState extends HomeScreenStates {
  final String message;

  BrandsErrorState({required this.message});
}

// class BrandsSuccessState extends HomeScreenStates {
//   List<CategoryOrBrand>? brandsList;
//
//   BrandsSuccessState({required this.brandsList});
// }

class HomeTabSuccessState extends HomeScreenStates {
  List<CategoryOrBrand>? categoriesList;
  List<CategoryOrBrand>? brandsList;

  HomeTabSuccessState({this.categoriesList, this.brandsList});

  HomeTabSuccessState copyWith({
    List<CategoryOrBrand>? categoriesList,
    List<CategoryOrBrand>? brandsList,
  }) {
    return HomeTabSuccessState(
      categoriesList: categoriesList ?? this.categoriesList,
      brandsList: brandsList ?? this.brandsList,
    );
  }
}
