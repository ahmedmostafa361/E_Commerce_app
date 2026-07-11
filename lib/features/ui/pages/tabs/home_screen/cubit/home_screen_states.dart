import 'package:e_commerce_flutter_app/domain/entinties/response/category/category_or_brand.dart';

class HomeScreenState {
  final bool isCategoriesLoading;
  final bool isBrandsLoading;

  final List<CategoryOrBrand> categoriesList;
  final List<CategoryOrBrand> brandsList;

  final String? categoriesError;
  final String? brandsError;

  const HomeScreenState({
    this.isCategoriesLoading = false,
    this.isBrandsLoading = false,
    this.categoriesList = const [],
    this.brandsList = const [],
    this.categoriesError,
    this.brandsError,
  });

  HomeScreenState copyWith({
    bool? isCategoriesLoading,
    bool? isBrandsLoading,
    List<CategoryOrBrand>? categoriesList,
    List<CategoryOrBrand>? brandsList,
    String? categoriesError,
    String? brandsError,
  }) {
    return HomeScreenState(
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      isBrandsLoading: isBrandsLoading ?? this.isBrandsLoading,
      categoriesList: categoriesList ?? this.categoriesList,
      brandsList: brandsList ?? this.brandsList,
      categoriesError: categoriesError,
      brandsError: brandsError,
    );
  }
}