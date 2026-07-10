import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_colors%20.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_text%20.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/products/product.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/tabs/whishlist_screen/cubit/whish_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../whishlist_screen/cubit/whish_list_states.dart';

class ProductTabItem extends StatefulWidget {
  final Product product;

  const ProductTabItem({super.key, required this.product});

  @override
  State<ProductTabItem> createState() => _ProductTabItemState();
}

class _ProductTabItemState extends State<ProductTabItem> {
  late bool isFavourite; // TODO: wire this up to real favourite logic/API later

  @override
  void initState() {
    super.initState();
    final productId = widget.product.id ?? '';
    // Check if the product is already in the fetched global wishlist
    final wishListViewModel = WhishListViewModel.get(context);
    isFavourite =
        wishListViewModel.whishList.any((item) => item.id == productId);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    final realPrice = product.price ?? 0;
    final fakeOriginalPrice =
        realPrice * 2; // TODO: remove this once real API sends discount data
    // TODO: compute from real discount data once available, e.g.
    // (((fakeOriginalPrice - realPrice) / fakeOriginalPrice) * 100).round()
    const discountPercent = 50;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias, // keeps image corners rounded, no overflow
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- Image + discount badge + favourite icon ----
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: product.imageCover ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(
                          color: Colors.grey.shade200,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.redColor,
                            ),
                          ),
                        ),
                    errorWidget: (context, url, error) =>
                        Container(
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.error_outline,
                            color: AppColors.redColor,
                          ),
                        ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.redColor,
                          AppColors.redColor.withOpacity(0.8)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.redColor.withOpacity(0.35),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      '-$discountPercent%',
                      style: AppTextStyle.normal12grey.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: _toggleFavourite,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(scale: animation, child: child),
                        child: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                          key: ValueKey<bool>(isFavourite),
                          size: 16.sp,
                          color: AppColors.redColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ---- Text content ----
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // title + description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        product.title ?? 'No title',
                        style: AppTextStyle.bold14black,
                        maxLines: 1,
                        minFontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      AutoSizeText(
                        product.description ?? '',
                        style: AppTextStyle.normal12grey,
                        maxLines: 1,
                        minFontSize: 9,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  // price + fake original price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          'EGP $realPrice',
                          style: AppTextStyle.bold14black.copyWith(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          minFontSize: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Flexible(
                        child: AutoSizeText(
                          'EGP $fakeOriginalPrice',
                          style: AppTextStyle.strikeThrough12Grey,
                          maxLines: 1,
                          minFontSize: 8,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  // rating + add button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                  Icons.star, size: 14.sp, color: Colors.amber),
                              SizedBox(width: 2.w),
                              Flexible(
                                child: AutoSizeText(
                                  '(${product.ratingsAverage?.toStringAsFixed(
                                      1) ?? '0.0'})',
                                  style: AppTextStyle.normal12grey,
                                  maxLines: 1,
                                  minFontSize: 9,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20.r),
                        onTap: () {
                          // TODO: add to cart use case
                          CartViewModel.get(context).addToCart(product.id ??
                              '');
                        },
                        child: Container(
                          padding: EdgeInsets.all(7.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryBlue,
                                AppColors.primaryBlue.withOpacity(0.75),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryBlue.withOpacity(0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(Icons.add, size: 16.sp, color: Colors
                              .white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleFavourite() async {
    final productId = widget.product.id ?? '';
    if (productId.isEmpty) return;

    final whishListViewModel = WhishListViewModel.get(context);

    // ---- LIVE DELETION PATH ----
    if (isFavourite) {
      setState(() => isFavourite = false); // Optimistic UI flip

      await whishListViewModel.deleteItemsWhishList(productId);

      if (!mounted) return;
      if (whishListViewModel.state is DeleteItemInWhishListErrorState) {
        setState(() => isFavourite = true); // Rollback on failure
      }
      return;
    }

    // ---- LIVE ADDITION PATH ----
    setState(() => isFavourite = true);

    await whishListViewModel.addToWhishList(productId);

    if (!mounted) return;

    if (whishListViewModel.state is AddWhishListErrorState) {
      setState(() => isFavourite = false);
    }
  }
}