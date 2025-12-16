import 'package:e_commerce_flutter_app/api/api_services.dart';
import 'package:e_commerce_flutter_app/api/mappers/auth_response_mappers.dart';
import 'package:e_commerce_flutter_app/api/mappers/login_request_mappers.dart';
import 'package:e_commerce_flutter_app/api/mappers/register_request_mappers.dart';
import 'package:e_commerce_flutter_app/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:e_commerce_flutter_app/domain/entinties/request/login_request.dart';
import 'package:e_commerce_flutter_app/domain/entinties/request/register_request.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/auth_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  ApiServices apiServices;
  AuthRemoteDataSourceImpl({required this.apiServices});
  @override
  Future<AuthResponse> login(LoginRequest loginRequest) async{
    // TODO: implement login
    //todo: convert login request =>>> login request dto
    var authResponse = await apiServices.login(loginRequest.toLoginRequestDto());
    //todo: convert authResponseDto =>>> authResponse
    return authResponse.toAuthResponse();
  }

  @override
  Future<AuthResponse> register(RegisterRequest registerRequest) async{
    // TODO: implement register
    var authResponse = await apiServices.register(registerRequest.toRegisterRequestDto());
    return authResponse.toAuthResponse();
  }


}