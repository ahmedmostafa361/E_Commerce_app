import 'package:get_it/get_it.dart';

import 'package:injectable/injectable.dart';
import 'package:e_commerce_flutter_app/api/dio/dio_module.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();
