import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_app/api/api_services.dart';
import 'package:e_commerce_flutter_app/api/mappers/cart/add_whish_list_response_mappers.dart';
import 'package:e_commerce_flutter_app/api/mappers/cart/get_whish_list_response_mappers.dart';
import 'package:e_commerce_flutter_app/api/model/request/add_product_request_dto.dart';
import 'package:e_commerce_flutter_app/core/cache_save_data/shared_prefrence.dart';
import 'package:e_commerce_flutter_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/whishlist/add_whish_list_response.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/whishlist/get_whish_list_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/data_sources/remote/whish_list_remote_data_source.dart';

@Injectable(as: WhishListRemoteDataSource)
class WhishListRemoteDataSourceImpl implements WhishListRemoteDataSource {
  ApiServices apiServices;

  WhishListRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<AddWhishListResponse> addToWhishList(String productId) async {
    // TODO: implement addToWhishList
    try {
      AddProductRequestDto productRequest = AddProductRequestDto(
        productId: productId,
      );
      String? token = SharedPreferencesUtils.readData(key: 'token') as String?;
      var addWhishListResponse = await apiServices.addToWhishList(
        productRequest,
        token ?? '',
      );

      /// converted from dto to entity by mappers
      return addWhishListResponse.toAddWhishListResponse();
    } on DioException catch (e) {
      String message = (e.error as AppException).errorMessage;
      throw ServerErrorException(errorMessage: message);
    }
  }

  @override
  Future<GetWhishListResponse> getItemsWhishList() async {
    try {
      String? token = SharedPreferencesUtils.readData(key: 'token') as String?;
      var getWhishListResponse = await apiServices.getWhishListItemsInCart(
        token ?? '',
      );
      return getWhishListResponse.toGetWhishListResponse();
    } on DioException catch (e) {
      String message = (e.error as AppException).errorMessage;
      throw ServerErrorException(errorMessage: message);
    }
  }

  @override
  Future<GetWhishListResponse> deleteItemsInWhishList(String productId) async {
    try {
      String? token = SharedPreferencesUtils.readData(key: 'token') as String?;
      var deleteWhishListResponse = await apiServices.deleteItemsInWhishList(
        productId,
        token ?? '',
      );
      return deleteWhishListResponse.toGetWhishListResponse();
    } on DioException catch (e) {
      String message = (e.error as AppException).errorMessage;
      throw ServerErrorException(errorMessage: message);
    }
  }
}

//
// @override
// Future<GetCartResponse> deleteItemsInCart(String productId) async {
//   try {
//     String? token = SharedPreferencesUtils.readData(key: 'token') as String?;
//     var deleteCartResponse = await apiServices.deleteItemsInCart(
//       productId,
//       token ?? '',
//     );
//     return deleteCartResponse.toGetCartResponse();
//   } on DioException catch (e) {
//     String message = (e.error as AppException).errorMessage;
//     throw ServerErrorException(errorMessage: message);
//   }
// }
//
// @override
// Future<GetCartResponse> updateCountInCart(String productId, int count) async {
//   try {
//     String? token = SharedPreferencesUtils.readData(key: 'token') as String?;
//     CountRequestDto countRequestDto = CountRequestDto(count: '$count');
//     var updateCartResponse = await apiServices.updateCountInCart(
//       productId,
//       token ?? '',
//       countRequestDto,
//     );
//     return updateCartResponse.toGetCartResponse();
//   } on DioException catch (e) {
//     String message = (e.error as AppException).errorMessage;
//     throw ServerErrorException(errorMessage: message);
//   }
// }
