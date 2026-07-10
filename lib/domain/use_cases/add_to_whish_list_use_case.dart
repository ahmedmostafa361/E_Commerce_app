import 'package:e_commerce_flutter_app/domain/repository/whishlist/cart_repository.dart';
import 'package:injectable/injectable.dart';

import '../entinties/response/whishlist/add_whish_list_response.dart';

@injectable
class AddToWhishlListUseCase {
  WhishListRepository whishListRepository;

  AddToWhishlListUseCase({required this.whishListRepository});

  Future<AddWhishListResponse> invoke(String productId) {
    return whishListRepository.addToWhishList(productId);
  }
}
