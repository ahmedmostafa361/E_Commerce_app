import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_colors%20.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_text%20.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/category/category_or_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ColumnOfImageAndTextInCategories extends StatelessWidget {
  final CategoryOrBrand item;
  const ColumnOfImageAndTextInCategories({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded( // image takes whatever space is available, won't force overflow
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: item.image ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(
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
        ),
        SizedBox(height: 8.h),
        Text(
          item.name ?? ' no category',
          style: AppTextStyle.normal14black,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}