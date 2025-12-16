import 'package:e_commerce_flutter_app/domain/entinties/response/auth_response.dart';

abstract class AuthStates {

}
class AuthLoadingStates extends AuthStates{

}
class AuthErrorStates extends AuthStates{
String errorMessage;
AuthErrorStates({required this.errorMessage});
}
class AuthSuccessStates extends AuthStates{
AuthResponse authResponse;
AuthSuccessStates({required this.authResponse});
}