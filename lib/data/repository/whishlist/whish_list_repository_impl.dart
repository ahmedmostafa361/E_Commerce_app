import 'package:e_commerce_flutter_app/domain/entinties/response/whishlist/add_whish_list_response.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/whishlist/get_whish_list_response.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repository/whishlist/cart_repository.dart';
import '../../data_sources/remote/whish_list_remote_data_source.dart';

@Injectable(as: WhishListRepository)
class WhishListRepositoryImpl implements WhishListRepository {
  WhishListRemoteDataSource remoteDataSource;

  WhishListRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AddWhishListResponse> addToWhishList(String productId) {
    // TODO: implement addToWhishList
    return remoteDataSource.addToWhishList(productId);
  }

  @override
  Future<GetWhishListResponse> getItemsWhishList() {
    // TODO: implement getItemsWhishList
    return remoteDataSource.getItemsWhishList();
  }

  @override
  Future<GetWhishListResponse> deleteItemsInWhishList(String productId) {
    // TODO: implement deleteItemsInWhishList
    return remoteDataSource.deleteItemsInWhishList(productId);
  }

  // @override
  // Future<GetCartResponse> deleteItemsInCart(String productId) {
  //   return remoteDataSource.deleteItemsInCart(productId);
  // }
  //
}
