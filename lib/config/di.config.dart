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
import '../api/data_sources/remote/auth_remote_data_source_impl.dart' as _i668;
import '../api/dio/dio_module.dart' as _i223;
import '../data/data_sources/remote/auth_remote_data_source.dart' as _i354;
import '../data/repository/auth/auth_repository_impl.dart' as _i779;
import '../domain/repository/auth_repository.dart' as _i306;
import '../domain/use_cases/login_use_cases.dart' as _i750;
import '../domain/use_cases/register_use_cases.dart' as _i548;
import '../features/ui/auth/login_screen/cubit/login_view_model.dart' as _i662;
import '../features/ui/auth/register_screen/cubit/register_view_model.dart'
    as _i588;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final getItModule = _$GetItModule();
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
          _i668.AuthRemoteDataSourceImpl(apiServices: gh<_i124.ApiServices>()),
    );
    gh.factory<_i306.AuthRepository>(
      () => _i779.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i354.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i750.LoginUseCases>(
      () => _i750.LoginUseCases(authRepository: gh<_i306.AuthRepository>()),
    );
    gh.factory<_i548.RegisterUseCases>(
      () => _i548.RegisterUseCases(authRepository: gh<_i306.AuthRepository>()),
    );
    gh.factory<_i662.LoginViewModel>(
      () => _i662.LoginViewModel(loginUseCases: gh<_i750.LoginUseCases>()),
    );
    gh.factory<_i588.RegisterViewModel>(
      () => _i588.RegisterViewModel(
        registerUseCases: gh<_i548.RegisterUseCases>(),
      ),
    );
    return this;
  }
}

class _$GetItModule extends _i223.GetItModule {}
