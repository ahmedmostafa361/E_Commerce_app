import 'package:e_commerce_flutter_app/api/mappers/user_mappers.dart';
import 'package:e_commerce_flutter_app/api/model/response/auth_response_dto.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/auth_response.dart';

extension AuthResponseMappers on AuthResponseDto{
AuthResponse toAuthResponse(){
  if(token!=null || user !=null || token!.isNotEmpty){
    return AuthResponse(
      message: message,
      token: token,
      //todo : convert userDto to user
      user: user?.toUser(),
    );
  }else{
    throw Exception();
  }


}
}