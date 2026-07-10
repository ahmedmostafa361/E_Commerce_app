import 'package:e_commerce_flutter_app/api/model/response/whishlist/add_whish_list_response_dto.dart';

import '../../../domain/entinties/response/whishlist/add_whish_list_response.dart';

extension AddWhishListResponseMappers on AddWhishListResponseDto {
  AddWhishListResponse toAddWhishListResponse() {
    return AddWhishListResponse(status: status, message: message, data: data);
  }
}
