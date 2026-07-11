import 'package:e_commerce_flutter_app/domain/entinties/response/whishlist/add_whish_list_response.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/whishlist/get_whish_list_response.dart';

abstract class WhishListRemoteDataSource {
  Future<AddWhishListResponse> addToWhishList(String productId);

  Future<GetWhishListResponse> getItemsWhishList();

  //
  Future<GetWhishListResponse> deleteItemsInWhishList(String productId);
  //
}
