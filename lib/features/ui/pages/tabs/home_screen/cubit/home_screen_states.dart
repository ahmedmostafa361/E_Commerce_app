import 'package:e_commerce_flutter_app/domain/entinties/response/category/category.dart';

abstract class HomeScreenStates {}

class HomeScreenInitialStates extends HomeScreenStates {}

class CategoriesLoadingState extends HomeScreenStates {}

class CategoriesErrorState extends HomeScreenStates {
  final String message;

  CategoriesErrorState({required this.message});
}

class CategoriesSuccessState extends HomeScreenStates {
  List<Category>? categoriesList;

  CategoriesSuccessState({required this.categoriesList});
}
