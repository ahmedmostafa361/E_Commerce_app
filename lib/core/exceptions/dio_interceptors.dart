import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_app/core/exceptions/app_exception.dart';

class DioInterceptors extends Interceptor{
  void onError(DioException err,ErrorInterceptorHandler handler){
    AppException exception;
     final responseData= err.response?.data;
     String message = 'Something went wrong';

     if(responseData is Map){
       message = (responseData['errors']?['msg'] as String?) ??
           (responseData['message']as String?)??
           message;
     }
     if(err.type== DioExceptionType.connectionError ||
         err.type== DioExceptionType.connectionTimeout){
       exception = NetworkErrorException(errorMessage: 'No internet connection');
     }else if(err.response?.statusCode != null){
      exception = ServerErrorException(
          errorMessage: message,
      statusCode: err.response?.statusCode);
    }else{
       exception = UnExpectedErrorException(errorMessage: message);
     }
     ///todo: This code creates a new DioException with the same request info but replaces the original error with your custom AppException,then passes it forward using handler.next() so the rest of the app receives a clean,unified error instead of raw Dio errors.
     handler.next(
       DioException(
           requestOptions: err.requestOptions,
         error: exception
       )
     );

  }

}