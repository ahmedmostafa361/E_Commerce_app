import 'package:e_commerce_flutter_app/domain/entinties/request/register_request.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/auth_response.dart';
import 'package:injectable/injectable.dart';

import '../repository/auth_repository.dart';
@injectable
class RegisterUseCases {
  AuthRepository authRepository;
  RegisterUseCases({required this.authRepository});

  Future<AuthResponse> invoke(RegisterRequest registerRequest){
    return authRepository.register(registerRequest);
  }
}