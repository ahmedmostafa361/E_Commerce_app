import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_flutter_app/domain/entinties/request/login_request.dart';
import 'package:e_commerce_flutter_app/features/ui/auth/auth_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/use_cases/login_use_cases.dart';

@injectable
class LoginViewModel extends Cubit<AuthStates>{ /// Think of Cubit as: A controller that decides what state the UI should be in
  LoginUseCases loginUseCases;
  LoginViewModel({required this.loginUseCases}): super(AuthLoadingStates());
  ///todo: hold data -- handle logic
  var formKey = GlobalKey<FormState>();
 void login(String email, String password) async{/// Cubit holds business logic and controls UI state, and emit sends new states that rebuild or react in the UI(in block builder or listener states).
   try{
     if(formKey.currentState?.validate() == true){
       emit(AuthLoadingStates());
       LoginRequest loginRequest = LoginRequest(
           email: email,
           password: password
       );
       var authResponse =await loginUseCases.invoke(loginRequest);
       emit(AuthSuccessStates(authResponse: authResponse));
     }
   } on AppException catch(e){
     emit(AuthErrorStates(errorMessage: e.errorMessage));
   } on DioException catch(e){
     final message = (e.error is AppException)?
     (e.error as AppException).errorMessage:
         'UnExpected error';
     emit(AuthErrorStates(errorMessage: message));
   }


}

}
/// view => object viewModel
/// viewModel => object useCase
/// useCase => object repository
/// repository => object ds
/// ds => apiServices