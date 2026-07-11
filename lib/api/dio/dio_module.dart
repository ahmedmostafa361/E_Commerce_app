import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_app/api/api_services.dart';
import 'package:e_commerce_flutter_app/api/end_points.dart';
import 'package:e_commerce_flutter_app/core/exceptions/dio_interceptors.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class GetItModule {

  @singleton
  BaseOptions provideBaseOptions() => BaseOptions(
    baseUrl: EndPoints.baseUrl,
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  );

  @singleton
  PrettyDioLogger providePrettyDioLogger() => PrettyDioLogger(
    requestBody: true,
    responseBody: true,
    requestHeader: true,
    responseHeader: true,
    request: true,
    error: true,
  );

  @singleton
  Dio provideDio(
      BaseOptions baseOptions,
      PrettyDioLogger prettyDioLogger,
      ) {
    final dio = Dio(baseOptions);
    dio.interceptors.add(DioInterceptors());
    dio.interceptors.add(prettyDioLogger);
    return dio;
  }

  @singleton
  ApiServices provideApiServices(Dio dio) => ApiServices(dio);
}
