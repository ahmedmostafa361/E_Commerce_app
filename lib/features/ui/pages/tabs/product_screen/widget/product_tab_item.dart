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

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias, // keeps image corners rounded, no overflow
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- Image + favourite icon ----
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
                  right: 8.w,
                  child: GestureDetector(
                    onTap: _toggleFavourite,
                    child: CircleAvatar(
                      radius: 16.r,
                      backgroundColor: Colors.white,
                      child: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        size: 18.sp,
                        color: AppColors.redColor,
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
                          style: AppTextStyle.bold14black,
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, size: 14.sp, color: Colors.amber),
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
                      InkWell(
                        onTap: () {
                          // TODO: add to cart use case
                          CartViewModel.get(context).addToCart(product.id ??
                              '');
                        },
                        child: CircleAvatar(
                          radius: 14.r,
                          backgroundColor: AppColors.primaryBlue,
                          child: Icon(
                            Icons.add,
                            size: 16.sp,
                            color: Colors.white,
                          ),
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

  // Future<void> _toggleFavourite() async {
  //   final productId = widget.product.id ?? '';
  //   if (productId.isEmpty) return;
  //
  //   if (isFavourite) {
  //     // TODO: call your remove-from-wishlist use case here once it's ready.
  //     // No remove endpoint exists yet, so we just toggle the UI off for now.
  //     setState(() => isFavourite = false);
  //     return;
  //   }
  //
  //   setState(() => isFavourite = true); // optimistic — feels instant
  //
  //   final whishListViewModel = WhishListViewModel.get(context);
  //   await whishListViewModel.addToWhishList(productId);
  //
  //   if (!mounted) return;
  //   if (whishListViewModel.state is AddWhishListErrorState) {
  //     setState(() => isFavourite = false); // roll back — the API call failed
  //   }
  //   // Success case needs nothing else here — the screen-level BlocListener
  //   // (added below in ProductScreen) handles the toast.
  // }
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
