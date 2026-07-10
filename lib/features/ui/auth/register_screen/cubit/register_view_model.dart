import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_app/domain/entinties/request/register_request.dart';
import 'package:e_commerce_flutter_app/domain/use_cases/register_use_cases.dart';
import 'package:e_commerce_flutter_app/features/ui/auth/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/cache_save_data/auth_local_storage.dart';
import '../../../../../core/cache_save_data/shared_prefrence.dart';
import '../../../../../core/exceptions/app_exception.dart';

@injectable
class RegisterViewModel extends Cubit<AuthStates>{
  RegisterUseCases registerUseCases;
  RegisterViewModel({required this.registerUseCases}): super(AuthLoadingStates());
  ///todo: hold data -- handle logic
  var formKey = GlobalKey<FormState>();

  // void register(String email, String password,String phone,String name,String passwordConfirm) async{/// Cubit holds business logic and controls UI state, and emit sends new states that rebuild or react in the UI(in block builder or listener states).
  //   try{
  //     if(formKey.currentState?.validate() == true){
  //       emit(AuthLoadingStates());
  //       RegisterRequest registerRequest = RegisterRequest(
  //           email: email,
  //           password: password,
  //         phone: phone,
  //         rePassword: passwordConfirm,
  //         name: name
  //       );
  //       var authResponse =await registerUseCases.invoke(registerRequest);
  //       emit(AuthSuccessStates(authResponse: authResponse));
  //     }
  //   } on AppException catch(e){
  //     emit(AuthErrorStates(errorMessage: e.errorMessage));
  //   } on DioException catch(e){
  //     final message = (e.error is AppException)?
  //     (e.error as AppException).errorMessage:
  //     'UnExpected error';
  //     emit(AuthErrorStates(errorMessage: message));
  //   }
  //
  //
  // }

// --- RegisterViewModel: identical addition ---

  void register(String email,
      String password,
      String phone,
      String name,
      String passwordConfirm,) async {
    try {
      if (formKey.currentState?.validate() == true) {
        emit(AuthLoadingStates());
        RegisterRequest registerRequest = RegisterRequest(
          email: email,
          password: password,
          phone: phone,
          rePassword: passwordConfirm,
          name: name,
        );
        var authResponse = await registerUseCases.invoke(registerRequest);

        // NEW — same persistence as LoginViewModel above.
        if (authResponse.token != null) {
          await SharedPreferencesUtils.saveData(
              key: 'token', value: authResponse.token);
        }
        if (authResponse.user != null) {
          await AuthLocalStorage.saveUser(authResponse.user!);
        }
        // `phone` is never returned by the backend, but the user genuinely
        // typed it into this registration — cache it locally since this is
        // the only moment we ever have it.
        await AuthLocalStorage.savePhone(phone);

        emit(AuthSuccessStates(authResponse: authResponse));
      }
    } on AppException catch (e) {
      emit(AuthErrorStates(errorMessage: e.errorMessage));
    } on DioException catch (e) {
      final message = (e.error is AppException)
          ? (e.error as AppException).errorMessage
          : 'UnExpected error';
      emit(AuthErrorStates(errorMessage: message));
    }
  }
}
/// view => object viewModel
/// viewModel => object useCase
/// useCase => object repository
/// repository => object ds
/// ds => apiServices