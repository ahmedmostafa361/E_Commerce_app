import 'package:e_commerce_flutter_app/core/utlis/app_text%20.dart';
import 'package:flutter/material.dart';

class RowOfTextAndViewAll extends StatelessWidget {
  const RowOfTextAndViewAll({super.key, required this.name, this.onViewAllTap});

  final String name;
  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(name, style: AppTextStyle.bold20PrimaryBlue),
        const Spacer(),
        InkWell(
          onTap: onViewAllTap,
          borderRadius: BorderRadius.circular(4),
          child: Text('View All', style: AppTextStyle.bold12PrimaryBlue),
        ),
      ],
    );
  }
}
