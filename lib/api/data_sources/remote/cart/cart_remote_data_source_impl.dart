import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_app/api/api_services.dart';
import 'package:e_commerce_flutter_app/api/mappers/cart/add_cart_response_mappers.dart';
import 'package:e_commerce_flutter_app/api/mappers/cart/get_cart_response_mappers.dart';
import 'package:e_commerce_flutter_app/api/model/request/add_product_request_dto.dart';
import 'package:e_commerce_flutter_app/core/cache_save_data/shared_prefrence.dart';
import 'package:e_commerce_flutter_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_flutter_app/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/add_cart/get_cart_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entinties/response/add_cart/add_cart_response.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  ApiServices apiServices;

  CartRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<AddCartResponse> addToCart(String productId) async {
    try {
      AddProductRequestDto productRequest = AddProductRequestDto(
        productId: productId,
      );
      String? token = SharedPreferencesUtils.readData(key: 'token') as String?;
      var addCartResponse = await apiServices.addToCart(
        productRequest,
        token ?? '',
      );
      return addCartResponse.toAddCartResponse();
    } on DioException catch (e) {
      String message = (e.error as AppException).errorMessage;
      throw ServerErrorException(errorMessage: message);
    }
  }

  @override
  Future<GetCartResponse> getItemsCart() async {
    try {
      String? token = SharedPreferencesUtils.readData(key: 'token') as String?;
      var getCartResponse = await apiServices.getItemsInCart(token ?? '');
      return getCartResponse.toGetCartResponse();
    } on DioException catch (e) {
      String message = (e.error as AppException).errorMessage;
      throw ServerErrorException(errorMessage: message);
    }
  }
}
