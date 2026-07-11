import 'package:injectable/injectable.dart';

import '../entinties/response/whishlist/get_whish_list_response.dart';
import '../repository/whishlist/cart_repository.dart';

@injectable
class DeleteItemsWhishListUseCase {
  WhishListRepository whishListRepository;

  DeleteItemsWhishListUseCase({required this.whishListRepository});

  Future<GetWhishListResponse> invoke(String productId) {
    return whishListRepository.deleteItemsInWhishList(productId);
  }
}
