import 'package:e_commerce_flutter_app/api/model/response/user_response_dto.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/user_response.dart';

extension UserMappers on UserDto{
  User toUser(){
     return User(
       email: email,
       name: name,
     );
   }

}