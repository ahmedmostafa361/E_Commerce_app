import 'package:e_commerce_flutter_app/api/model/request/login_request_dto.dart';
import 'package:e_commerce_flutter_app/domain/entinties/request/login_request.dart';

extension LoginRequestMappers on LoginRequest{

  LoginRequestDto toLoginRequestDto(){
    return LoginRequestDto(
      email: email,
      password: password
    );
  }
}