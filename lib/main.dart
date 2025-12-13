import 'package:e_commerce_flutter_app/core/utlis/app_routes%20.dart';
import 'package:e_commerce_flutter_app/features/ui/auth/login_screen/login_screen.dart';
import 'package:e_commerce_flutter_app/features/ui/auth/register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config/di.dart';


void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.loginScreen,
          routes: {
            AppRoutes.loginScreen:(context) => LoginScreen(),
            AppRoutes.registerScreen:(context) => RegisterScreen(),
          },

        );
      },
    );

  }
}
