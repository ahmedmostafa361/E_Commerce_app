import 'package:e_commerce_flutter_app/domain/entinties/request/login_request.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/auth_response.dart';
import 'package:e_commerce_flutter_app/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCases {
  AuthRepository authRepository;
  LoginUseCases({required this.authRepository});

  Future<AuthResponse> invoke(LoginRequest loginRequest){
    return authRepository.login(loginRequest);

  }

}