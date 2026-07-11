import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_app/api/api_services.dart';
import 'package:e_commerce_flutter_app/api/mappers/categories/categories_mappers.dart';
import 'package:e_commerce_flutter_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_flutter_app/data/data_sources/remote/categories_remote_data_source.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/category/category_or_brand.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRemoteDataSource)
class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  ApiServices apiServices;

  CategoriesRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<List<CategoryOrBrand>?> getAllCategories() async {
    try {
      var categoriesResponse = await apiServices.getAllCategories();
      return categoriesResponse.data
              ?.map((CategoryDto) => CategoryDto.toCategory())
              .toList() ??
          [];
    } on DioException catch (e) {
      String message = (e.error as AppException).errorMessage;
      throw ServerErrorException(errorMessage: message);
    }
  }
}
