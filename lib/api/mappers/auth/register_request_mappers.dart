import 'package:e_commerce_flutter_app/api/model/request/register_request_dto.dart';
import 'package:e_commerce_flutter_app/domain/entinties/request/register_request.dart';

extension RegisterRequestMappers on RegisterRequest{

  RegisterRequestDto toRegisterRequestDto(){
    return RegisterRequestDto(
        email: email,
        password: password,
      name: name,
        rePassword: rePassword,
      phone: phone
    );
  }
}