import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_app/api/end_points.dart';
import 'package:e_commerce_flutter_app/api/model/request/login_request_dto.dart';
import 'package:e_commerce_flutter_app/api/model/request/register_request_dto.dart';
import 'package:e_commerce_flutter_app/api/model/response/auth/auth_response_dto.dart';
import 'package:e_commerce_flutter_app/api/model/response/brands/brands_response_dto.dart';
import 'package:e_commerce_flutter_app/api/model/response/category/category_response_dto.dart';
import 'package:e_commerce_flutter_app/api/model/response/product/product_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class ApiServices {
  factory ApiServices(
      Dio dio, {
        String? baseUrl,
      }) = _ApiServices;

  @POST(EndPoints.loginApi)
  Future<AuthResponseDto> login(
      @Body() LoginRequestDto loginRequest,
      );

  @POST(EndPoints.registerApi)
  Future<AuthResponseDto> register(
      @Body() RegisterRequestDto registerRequest,
      );

  @GET(EndPoints.categoryApi)
  Future<CategoryResponseDto> getAllCategories();

  @GET(EndPoints.brandsApi)
  Future<BrandsResponseDto> getAllBrands();

  @GET(EndPoints.productsApi)
  Future<ProductResponseDto> getAllProducts();
}
