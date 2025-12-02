
import 'package:e_commerce_flutter_app/domain/entinties/response/user_response.dart';

/// todo: import must depend only on domain ( depend on her self )
class AuthResponse {
  final String? message;
  final User? user;
  final String? token;

  AuthResponse ({
    this.message,
    this.user,
    this.token,
  });
}



