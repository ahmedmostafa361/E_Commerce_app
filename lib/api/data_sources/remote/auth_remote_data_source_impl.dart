import 'package:e_commerce_flutter_app/api/api_services.dart';
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
  Future<AuthResponse> login(LoginRequest loginRequest) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<AuthResponse> register(RegisterRequest registerRequest) {
    // TODO: implement register
    throw UnimplementedError();
  }


}