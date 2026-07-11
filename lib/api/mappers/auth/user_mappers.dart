import 'package:e_commerce_flutter_app/domain/entinties/response/user_response.dart';

import '../../model/response/auth/user_response_dto.dart';

extension UserMappers on UserDto{
  User toUser(){
     return User(
       email: email,
       name: name,
     );
   }

}