import 'package:e_commerce_flutter_app/core/cache_save_data/shared_prefrence.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_routes%20.dart';
import 'package:e_commerce_flutter_app/features/ui/auth/login_screen/login_screen.dart';
import 'package:e_commerce_flutter_app/features/ui/auth/register_screen/register_screen.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/bloc_observer.dart' show MyBlocObserver;
import 'config/di.dart';
import 'features/ui/pages/nav_bar_screen/main_wrapper_screen.dart';
import 'features/ui/pages/tabs/product_screen/product_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   configureDependencies();
  await SharedPreferencesUtils.init();
  Bloc.observer = MyBlocObserver();
  String routeName;
  var token = SharedPreferencesUtils.readData(key: 'token');
  if (token == null) {
    routeName = AppRoutes.loginScreen;
  } else {
    routeName = AppRoutes.mainWrapperScreen;
  }
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<CartViewModel>(),),
      ],
      child: MyApp(routeName: routeName,)));
}

class MyApp extends StatelessWidget {
  final String routeName;

  const MyApp({super.key, required this.routeName});
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: routeName,
          routes: {
            AppRoutes.loginScreen: (context) => const LoginScreen(),
            AppRoutes.registerScreen: (context) => const RegisterScreen(),
            AppRoutes.mainWrapperScreen: (context) => const MainWrapperScreen(),
            AppRoutes.productDetailsScreen: (
                context) => const ProductDetailsScreen(),
          },

        );
      },
    );

  }
}
