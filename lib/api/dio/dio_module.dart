import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_app/api/api_services.dart';
import 'package:e_commerce_flutter_app/api/end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class GetItModule {
  @singleton
  // @injectable
  BaseOptions provideBaseOptions() {
    return BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 15),
      receiveTimeout: Duration(seconds: 15),
    );
  }

  @singleton
  // @injectable
  PrettyDioLogger providePrettyDioLogger() {
    return PrettyDioLogger(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
      error: true,
    );
  }

  @singleton
  // @injectable
  Dio provideDio(BaseOptions baseOptions,PrettyDioLogger prettyDioLogger){
    var dio = Dio(baseOptions);
    // todo : add interceptors
    dio.interceptors.add(prettyDioLogger);
    return dio;
  }

  @singleton
  // @injectable
  ApiServices provideApiServices(Dio dio) => ApiServices(dio);
}
