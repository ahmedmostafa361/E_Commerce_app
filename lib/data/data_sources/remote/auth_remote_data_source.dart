import '../../../domain/entinties/request/login_request.dart';
import '../../../domain/entinties/request/register_request.dart';
import '../../../domain/entinties/response/auth_response.dart';

abstract class AuthRemoteDataSource {

  Future<AuthResponse> login(LoginRequest loginRequest);
  Future<AuthResponse> register(RegisterRequest registerRequest);

}