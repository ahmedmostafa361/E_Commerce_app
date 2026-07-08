// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../api/api_services.dart' as _i124;
import '../api/data_sources/remote/auth/auth_remote_data_source_impl.dart'
    as _i983;
import '../api/data_sources/remote/brands/brands_remote_data_source_impl.dart'
    as _i948;
import '../api/data_sources/remote/cart/cart_remote_data_source_impl.dart'
    as _i835;
import '../api/data_sources/remote/categories/categories_remote_data_source_impl.dart'
    as _i661;
import '../api/data_sources/remote/products/products_remote_data_source_impl.dart'
    as _i1063;
import '../api/dio/dio_module.dart' as _i223;
import '../data/data_sources/remote/auth_remote_data_source.dart' as _i354;
import '../data/data_sources/remote/brands_remote_data_source.dart' as _i337;
import '../data/data_sources/remote/cart_remote_data_source.dart' as _i798;
import '../data/data_sources/remote/categories_remote_data_source.dart'
    as _i727;
import '../data/data_sources/remote/products_remote_data_source.dart' as _i688;
import '../data/repository/auth/auth_repository_impl.dart' as _i779;
import '../data/repository/brands/brands_repository_impl.dart' as _i1059;
import '../data/repository/cart/cart_repository_impl.dart' as _i127;
import '../data/repository/categories/categories_repository_impl.dart' as _i142;
import '../data/repository/products/products_repository_impl.dart' as _i996;
import '../domain/repository/add_cart/cart_repository.dart' as _i909;
import '../domain/repository/auth_repository.dart' as _i306;
import '../domain/repository/brands/brands_repository.dart' as _i949;
import '../domain/repository/categories/categories_repository.dart' as _i2;
import '../domain/repository/products/products_repository.dart' as _i547;
import '../domain/use_cases/add_to_cart_use_case.dart' as _i994;
import '../domain/use_cases/get_all_brands_use_case.dart' as _i823;
import '../domain/use_cases/get_all_categories_use_case.dart' as _i557;
import '../domain/use_cases/get_all_products_use_case.dart' as _i960;
import '../domain/use_cases/get_items_cart_use_case.dart' as _i1041;
import '../domain/use_cases/login_use_cases.dart' as _i750;
import '../domain/use_cases/register_use_cases.dart' as _i548;
import '../features/ui/auth/login_screen/cubit/login_view_model.dart' as _i662;
import '../features/ui/auth/register_screen/cubit/register_view_model.dart'
    as _i588;
import '../features/ui/pages/cart_screen/cubit/cart_view_model.dart' as _i65;
import '../features/ui/pages/nav_bar_screen/cubit/wrapper_screen_view_model.dart'
    as _i221;
import '../features/ui/pages/tabs/home_screen/cubit/home_screen_view_model.dart'
    as _i5;
import '../features/ui/pages/tabs/product_screen/cubit/product_screen_view_model.dart'
    as _i393;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final getItModule = _$GetItModule();
    gh.factory<_i221.WrapperScreenViewModel>(
      () => _i221.WrapperScreenViewModel(),
    );
    gh.singleton<_i361.BaseOptions>(() => getItModule.provideBaseOptions());
    gh.singleton<_i528.PrettyDioLogger>(
      () => getItModule.providePrettyDioLogger(),
    );
    gh.singleton<_i361.Dio>(
      () => getItModule.provideDio(
        gh<_i361.BaseOptions>(),
        gh<_i528.PrettyDioLogger>(),
      ),
    );
    gh.singleton<_i124.ApiServices>(
      () => getItModule.provideApiServices(gh<_i361.Dio>()),
    );
    gh.factory<_i354.AuthRemoteDataSource>(
      () =>
          _i983.AuthRemoteDataSourceImpl(apiServices: gh<_i124.ApiServices>()),
    );
    gh.factory<_i727.CategoriesRemoteDataSource>(
      () => _i661.CategoriesRemoteDataSourceImpl(
        apiServices: gh<_i124.ApiServices>(),
      ),
    );
    gh.factory<_i306.AuthRepository>(
      () => _i779.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i354.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i798.CartRemoteDataSource>(
      () =>
          _i835.CartRemoteDataSourceImpl(apiServices: gh<_i124.ApiServices>()),
    );
    gh.factory<_i909.CartRepository>(
      () => _i127.CartRepositoryImpl(
        remoteDataSource: gh<_i798.CartRemoteDataSource>(),
      ),
    );
    gh.factory<_i688.ProductsRemoteDataSource>(
      () => _i1063.ProductsRemoteDataSourceImpl(
        apiServices: gh<_i124.ApiServices>(),
      ),
    );
    gh.factory<_i750.LoginUseCases>(
      () => _i750.LoginUseCases(authRepository: gh<_i306.AuthRepository>()),
    );
    gh.factory<_i548.RegisterUseCases>(
      () => _i548.RegisterUseCases(authRepository: gh<_i306.AuthRepository>()),
    );
    gh.factory<_i337.BrandsRemoteDataSource>(
      () => _i948.BrandsRemoteDataSourceImpl(
        apiServices: gh<_i124.ApiServices>(),
      ),
    );
    gh.factory<_i662.LoginViewModel>(
      () => _i662.LoginViewModel(loginUseCases: gh<_i750.LoginUseCases>()),
    );
    gh.factory<_i2.CategoriesRepository>(
      () => _i142.CategoriesRepositoryImpl(
        remoteDataSource: gh<_i727.CategoriesRemoteDataSource>(),
      ),
    );
    gh.factory<_i588.RegisterViewModel>(
      () => _i588.RegisterViewModel(
        registerUseCases: gh<_i548.RegisterUseCases>(),
      ),
    );
    gh.factory<_i547.ProductsRepository>(
      () => _i996.ProductsRepositoryImpl(
        remoteDataSource: gh<_i688.ProductsRemoteDataSource>(),
      ),
    );
    gh.factory<_i949.BrandsRepository>(
      () => _i1059.BrandsRepositoryImpl(
        remoteDataSource: gh<_i337.BrandsRemoteDataSource>(),
      ),
    );
    gh.factory<_i994.AddToCartUseCase>(
      () => _i994.AddToCartUseCase(cartRepository: gh<_i909.CartRepository>()),
    );
    gh.factory<_i1041.GetItemsCartUseCase>(
      () => _i1041.GetItemsCartUseCase(
        cartRepository: gh<_i909.CartRepository>(),
      ),
    );
    gh.factory<_i557.GetAllCategoriesUseCase>(
      () => _i557.GetAllCategoriesUseCase(
        categoriesRepository: gh<_i2.CategoriesRepository>(),
      ),
    );
    gh.factory<_i960.GetAllProductsUseCase>(
      () => _i960.GetAllProductsUseCase(
        productsRepository: gh<_i547.ProductsRepository>(),
      ),
    );
    gh.factory<_i823.GetAllBrandsUseCase>(
      () => _i823.GetAllBrandsUseCase(
        brandsRepository: gh<_i949.BrandsRepository>(),
      ),
    );
    gh.factory<_i65.CartViewModel>(
      () => _i65.CartViewModel(
        addToCartUseCase: gh<_i994.AddToCartUseCase>(),
        getItemsCartUseCase: gh<_i1041.GetItemsCartUseCase>(),
      ),
    );
    gh.factory<_i393.ProductScreenViewModel>(
      () => _i393.ProductScreenViewModel(
        getAllProductsUseCase: gh<_i960.GetAllProductsUseCase>(),
      ),
    );
    gh.factory<_i5.HomeScreenViewModel>(
      () => _i5.HomeScreenViewModel(
        getAllCategoriesUseCase: gh<_i557.GetAllCategoriesUseCase>(),
        getAllBrandsUseCase: gh<_i823.GetAllBrandsUseCase>(),
      ),
    );
    return this;
  }
}

class _$GetItModule extends _i223.GetItModule {}
