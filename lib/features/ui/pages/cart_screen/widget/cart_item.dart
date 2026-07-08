import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/cache_save_data/cart_variant_storage_for_size_color.dart';
import '../../../../../core/utlis/app_colors .dart';
import '../../../../../core/utlis/app_text .dart';
import '../../../../../domain/entinties/response/add_cart/get_products.dart';

/// A single cart row: product image, title, price, quantity stepper, and a
/// delete action — matches the provided Cart screen design.
class CartItem extends StatelessWidget {
  final GetProducts item;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onDelete;

  const CartItem({
    super.key,
    required this.item,
    this.onIncrement,
    this.onDecrement,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    // TODO: confirm the real field name on your `Product` entity — assumed
    // `title` here, matching common Route-API product models.
    final String title = product?.title ?? '';
    final String imageUrl = product?.imageCover ?? '';
    final int price = item.price ?? product?.price ?? 0;
    final int count = item.count ?? 1;
    // On-device only — the API has no concept of variants (see
    // CartVariantsStorage doc comment for why).
    final variant = CartVariantsStorage.getVariant(product?.id ?? '');

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              imageUrl,
              width: 74.w,
              height: 74.w,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 74.w,
                height: 74.w,
                color: AppColors.scaffoldBackgroundColor,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColors.greyColor,
                ),
              ),
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  width: 74.w,
                  height: 74.w,
                  color: AppColors.scaffoldBackgroundColor,
                  child: Center(
                    child: SizedBox(
                      width: 18.w,
                      height: 18.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyle.bold16Blue,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: onDelete,
                      behavior: HitTestBehavior.opaque,
                      child: Icon(
                        Icons.delete_outline,
                        color: AppColors.primaryColor,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
                if (variant != null) ...[
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          color: Color(variant['color'] as int),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Size: ${variant['size']}',
                        style: AppTextStyle.normal16Grey.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 14.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('EGP $price', style: AppTextStyle.bold16Blue),
                    _buildQuantityStepper(count),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityStepper(int count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stepperButton(icon: Icons.remove, onTap: onDecrement),
          SizedBox(
            width: 26.w,
            child: Text(
              '$count',
              textAlign: TextAlign.center,
              style: AppTextStyle.normal16White,
            ),
          ),
          _stepperButton(icon: Icons.add, onTap: onIncrement),
        ],
      ),
    );
  }

  Widget _stepperButton({required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 22.w,
        height: 22.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.whiteColor, width: 1.2),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: AppColors.whiteColor, size: 14.sp),
      ),
    );
  }
}
