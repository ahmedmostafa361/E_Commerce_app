import 'package:e_commerce_flutter_app/core/utlis/app_colors%20.dart';
import 'package:flutter/material.dart';

class MainLoadingWidget extends StatelessWidget {
  const MainLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(color: AppColors.primaryBlue));
  }
}
