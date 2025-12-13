
import 'package:e_commerce_flutter_app/domain/entinties/request/register_request.dart';

import '../entinties/request/login_request.dart';
import '../entinties/response/auth_response.dart';

abstract class AuthRepository {

  Future<AuthResponse> login(LoginRequest loginRequest);
  Future<AuthResponse> register(RegisterRequest registerRequest);

}