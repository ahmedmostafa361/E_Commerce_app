import 'package:injectable/injectable.dart';

import '../entinties/response/whishlist/get_whish_list_response.dart';
import '../repository/whishlist/cart_repository.dart';

@injectable
class GetItemsWhishListUseCase {
  WhishListRepository whishListRepository;

  GetItemsWhishListUseCase({required this.whishListRepository});

  Future<GetWhishListResponse> invoke() {
    return whishListRepository.getItemsWhishList();
  }
}
