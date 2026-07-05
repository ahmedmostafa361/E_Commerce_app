import 'package:json_annotation/json_annotation.dart';

part 'user_response_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "email")
  final String? email;

  UserDto({
    this.name,
    this.email,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
