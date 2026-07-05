import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_app/api/api_services.dart';
import 'package:e_commerce_flutter_app/api/mappers/products/products_mappers.dart';
import 'package:e_commerce_flutter_app/core/exceptions/app_exception.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/products/product.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/data_sources/remote/products_remote_data_source.dart';

@Injectable(as: ProductsRemoteDataSource)
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  ApiServices apiServices;

  ProductsRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<List<Product>?> getAllProducts() async {
    try {
      var productResponse = await apiServices.getAllProducts();
      return productResponse.data
              ?.map((productDto) => productDto.toProduct())
              .toList() ??
          [];
    } on DioException catch (e) {
      String message = (e.error as AppException).errorMessage;
      throw ServerErrorException(errorMessage: message);
    }
  }
}
