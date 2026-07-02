import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_colors%20.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_text%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColumnOfImageAndTextInCategories extends StatelessWidget {
  const ColumnOfImageAndTextInCategories({
    super.key,
    required this.imageUrl,
    required this.label,
  });

  final String imageUrl;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.redColor,
                ),
              ),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error_outline, color: AppColors.redColor),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: AppTextStyle.normal14black,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
