import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_app/api/api_services.dart';
import 'package:e_commerce_flutter_app/api/mappers/categories/categories_mappers.dart';
import 'package:e_commerce_flutter_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/category/category_or_brand.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/data_sources/remote/brands_remote_data_source.dart';

@Injectable(as: BrandsRemoteDataSource)
class BrandsRemoteDataSourceImpl implements BrandsRemoteDataSource {
  ApiServices apiServices;

  BrandsRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<List<CategoryOrBrand>?> getAllBrands() async {
    try {
      var brandsResponse = await apiServices.getAllBrands();
      return brandsResponse.data
              ?.map((CategoryDto) => CategoryDto.toCategory())
              .toList() ??
          [];
    } on DioException catch (e) {
      String message = (e.error as AppException).errorMessage;
      throw ServerErrorException(errorMessage: message);
    }
  }
}
