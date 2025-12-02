import 'package:e_commerce_flutter_app/core/utlis/app_assets%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
             Padding(
               padding:  EdgeInsets.only(top: 91.h,right: 96.w,left: 97.w,bottom: 769.9.h),
               child: Image(image: AssetImage(
                 AppAssets.eCommerce
               )),
             )
          ],
        ),
      ),
    );
  }
}
