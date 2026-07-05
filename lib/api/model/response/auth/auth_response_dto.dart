import 'package:e_commerce_flutter_app/api/model/response/auth/user_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response_dto.g.dart';
@JsonSerializable()
class AuthResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDto? user;
  @JsonKey(name: "token")
  final String? token;

  AuthResponseDto ({
    this.message,
    this.user,
    this.token,
  });

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return _$AuthResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AuthResponseDtoToJson(this);
  }
}



