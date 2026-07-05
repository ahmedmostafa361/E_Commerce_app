import 'package:e_commerce_flutter_app/domain/entinties/response/category/category_or_brand.dart';
import 'package:e_commerce_flutter_app/domain/repository/brands/brands_repository.dart';
import 'package:injectable/injectable.dart';

import '../../data_sources/remote/brands_remote_data_source.dart';

@Injectable(as: BrandsRepository)
class BrandsRepositoryImpl implements BrandsRepository {
  BrandsRemoteDataSource remoteDataSource;

  BrandsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CategoryOrBrand>?> getAllBrands() {
    // TODO: implement getAllBrands
    return remoteDataSource.getAllBrands();
  }
}
