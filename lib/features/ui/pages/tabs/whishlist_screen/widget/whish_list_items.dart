import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utlis/app_colors .dart';
import '../../../../../../core/utlis/app_text .dart';
import '../../../../../../domain/entinties/response/products/product.dart';
import '../../../../../../widget/custom_elevated_button .dart';
import '../../../cart_screen/cubit/cart_view_model.dart';
import '../cubit/whish_list_states.dart';
import '../cubit/whish_list_view_model.dart';

/// A single wishlist row: image, title, favourite (remove) icon, price, and
/// an "Add to Cart" action — matches the provided design.
class WishlistItem extends StatefulWidget {
  final Product product;

  const WishlistItem({super.key, required this.product});

  @override
  State<WishlistItem> createState() => _WishlistItemState();
}

class _WishlistItemState extends State<WishlistItem> {
  bool _isRemoving = false;
  bool _isAddingToCart = false;

  Future<void> _handleRemove() async {
    if (_isRemoving) return;
    final productId = widget.product.id ?? '';
    if (productId.isEmpty) return;

    // 1. Optimistic UI slide/fade animation trigger
    setState(() => _isRemoving = true);

    // 2. Fire live deletion API
    final viewModel = WhishListViewModel.get(context);
    await viewModel.deleteItemsWhishList(productId);

    if (!mounted) return;

    // 3. Roll back animation cleanly if network call fails
    if (viewModel.state is DeleteItemInWhishListErrorState) {
      setState(() => _isRemoving = false);
    }
  }

  Future<void> _handleAddToCart() async {
    if (_isAddingToCart) return;
    final productId = widget.product.id ?? '';
    if (productId.isEmpty) return;

    setState(() => _isAddingToCart = true);
    await CartViewModel.get(context).addToCart(productId);
    if (!mounted) return;
    setState(() => _isAddingToCart = false);
    // Success/error toast is handled by a screen-level BlocListener on
    // CartViewModel, so nothing else is needed here.
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _isRemoving ? 0 : 1,
        child: _isRemoving
            ? const SizedBox(width: double.infinity)
            : _buildCard(),
      ),
    );
  }

  Widget _buildCard() {
    final product = widget.product;
    final String title = product.title ?? '';
    final String imageUrl = product.imageCover ?? '';
    final int realPrice = product.price ?? 0;
    // TODO: remove this once the API sends real discount/original-price
    // data — Product currently has no such field, so there is nothing
    // genuine to show here yet. Mirrors the same placeholder already used
    // in ProductTabItem for consistency.
    final int fakeOriginalPrice = realPrice * 2;

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 74.w,
              height: 74.w,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 74.w,
                height: 74.w,
                color: Colors.grey.shade200,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 74.w,
                height: 74.w,
                color: Colors.grey.shade200,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColors.greyColor,
                ),
              ),
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
                      onTap: _handleRemove,
                      behavior: HitTestBehavior.opaque,
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.primaryColor,
                        size: 22.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text('EGP $realPrice', style: AppTextStyle.bold16Blue),
                    SizedBox(width: 6.w),
                    Text(
                      'EGP $fakeOriginalPrice',
                      style: AppTextStyle.normal16Grey.copyWith(
                        fontSize: 13.sp,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 32.h,
                    child: CustomElevatedButton(
                      onPressed: _handleAddToCart,
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      hasIcon: true,
                      customInButton: _isAddingToCart
                          ? SizedBox(
                              width: 16.w,
                              height: 16.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.whiteColor,
                              ),
                            )
                          : Text(
                              'Add to Cart',
                              style: AppTextStyle.normal16White.copyWith(
                                fontSize: 13.sp,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
