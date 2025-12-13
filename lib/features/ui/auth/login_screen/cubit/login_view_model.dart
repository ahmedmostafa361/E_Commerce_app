import 'package:e_commerce_flutter_app/features/ui/auth/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/use_cases/login_use_cases.dart';

@injectable
class LoginViewModel extends Cubit<AuthStates>{
  LoginUseCases loginUseCases;
  LoginViewModel({required this.loginUseCases}): super(AuthLoadingStates());


}
/// view => object viewModel
/// viewModel => object useCase
/// useCase => object repository
/// repository => object ds
/// ds => apiServices