import 'package:e_commerce_flutter_app/api/mappers/products/products_mappers.dart';

import '../../../domain/entinties/response/whishlist/get_whish_list_response.dart';
import '../../model/response/whishlist/get_whishlist/get_whish_list_response_dto.dart';

extension GetWhishListResponseMappers on GetWhishListResponseDto {
  GetWhishListResponse toGetWhishListResponse() {
    return GetWhishListResponse(
      status: status,
      count: count,
      data: data?.map((e) => e.toProduct()).toList(),
    );
  }
}
