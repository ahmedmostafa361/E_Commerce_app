// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../core/cache_save_data/cart_variant_storage_for_size_color.dart';
// import '../../../../../core/utlis/app_colors .dart';
// import '../../../../../core/utlis/app_text .dart';
// import '../../../../../domain/entinties/response/add_cart/get_products.dart';
//
// /// A single cart row: product image, title, price, quantity stepper, and a
// /// delete action — matches the provided Cart screen design.
// class CartItem extends StatelessWidget {
//   final GetProducts item;
//   final VoidCallback? onIncrement;
//   final VoidCallback? onDecrement;
//   final VoidCallback? onDelete;
//
//   const CartItem({
//     super.key,
//     required this.item,
//     this.onIncrement,
//     this.onDecrement,
//     this.onDelete,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final product = item.product;
//     // TODO: confirm the real field name on your `Product` entity — assumed
//     // `title` here, matching common Route-API product models.
//     final String title = product?.title ?? '';
//     final String imageUrl = product?.imageCover ?? '';
//     final int price = item.price ?? product?.price ?? 0;
//     final int count = item.count ?? 1;
//     // On-device only — the API has no concept of variants (see
//     // CartVariantsStorage doc comment for why).
//     final variant = CartVariantsStorage.getVariant(product?.id ?? '');
//
//     return Container(
//       margin: EdgeInsets.only(bottom: 14.h),
//       padding: EdgeInsets.all(10.w),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(color: AppColors.primaryColor.withOpacity(0.15)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12.r),
//             child: Image.network(
//               imageUrl,
//               width: 74.w,
//               height: 74.w,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => Container(
//                 width: 74.w,
//                 height: 74.w,
//                 color: AppColors.scaffoldBackgroundColor,
//                 child: Icon(
//                   Icons.image_not_supported_outlined,
//                   color: AppColors.greyColor,
//                 ),
//               ),
//               loadingBuilder: (context, child, progress) {
//                 if (progress == null) return child;
//                 return Container(
//                   width: 74.w,
//                   height: 74.w,
//                   color: AppColors.scaffoldBackgroundColor,
//                   child: Center(
//                     child: SizedBox(
//                       width: 18.w,
//                       height: 18.w,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         color: AppColors.primaryColor,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         title,
//                         style: AppTextStyle.bold16Blue,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     SizedBox(width: 8.w),
//                     GestureDetector(
//                       onTap: onDelete,
//                       behavior: HitTestBehavior.opaque,
//                       child: Icon(
//                         Icons.delete_outline,
//                         color: AppColors.primaryColor,
//                         size: 20.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (variant != null) ...[
//                   SizedBox(height: 6.h),
//                   Row(
//                     children: [
//                       Container(
//                         width: 10.w,
//                         height: 10.w,
//                         decoration: BoxDecoration(
//                           color: Color(variant['color'] as int),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       SizedBox(width: 6.w),
//                       Text(
//                         'Size: ${variant['size']}',
//                         style: AppTextStyle.normal16Grey.copyWith(
//                           fontSize: 13.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//                 SizedBox(height: 14.h),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('EGP $price', style: AppTextStyle.bold16Blue),
//                     _buildQuantityStepper(count),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQuantityStepper(int count) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
//       decoration: BoxDecoration(
//         color: AppColors.primaryColor,
//         borderRadius: BorderRadius.circular(30.r),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _stepperButton(icon: Icons.remove, onTap: onDecrement),
//           SizedBox(
//             width: 26.w,
//             child: Text(
//               '$count',
//               textAlign: TextAlign.center,
//               style: AppTextStyle.normal16White,
//             ),
//           ),
//           _stepperButton(icon: Icons.add, onTap: onIncrement),
//         ],
//       ),
//     );
//   }
//
//   Widget _stepperButton({required IconData icon, VoidCallback? onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       behavior: HitTestBehavior.opaque,
//       child: Container(
//         width: 22.w,
//         height: 22.w,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: AppColors.whiteColor, width: 1.2),
//         ),
//         alignment: Alignment.center,
//         child: Icon(icon, color: AppColors.whiteColor, size: 14.sp),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/cache_save_data/cart_variant_storage_for_size_color.dart';
import '../../../../../core/utlis/app_colors .dart';
import '../../../../../core/utlis/app_text .dart';
import '../../../../../domain/entinties/response/add_cart/get_cart.dart';
import '../../../../../domain/entinties/response/add_cart/get_products.dart';
import '../../../../../widget/toast_bar_message.dart';
import '../cubit/cart_states.dart';
import '../cubit/cart_view_model.dart';

/// A single cart row: product image, title, price, quantity stepper, and a
/// delete action.
///
/// Quantity changes are applied **optimistically** (the number updates the
/// instant you tap +/-, before the network call resolves) and rolled back
/// automatically if the server rejects the change — this is what makes the
/// stepper feel instant/"luxurious" instead of laggy.
///
/// Deleting plays a fade + collapse animation before the row is actually
/// removed from the list, and asks for confirmation first since it's a
/// destructive action.
class CartItem extends StatefulWidget {
  final GetProducts item;

  /// Called with the fresh [GetCart] whenever an update or delete succeeds,
  /// so the parent screen can refresh the list + total price from the
  /// server's authoritative response.
  final ValueChanged<GetCart> onCartUpdated;

  const CartItem({
    super.key,
    required this.item,
    required this.onCartUpdated,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int _count;
  bool _isUpdatingQty = false;
  bool _isRemoving = false;

  @override
  void initState() {
    super.initState();
    _count = widget.item.count ?? 1;
  }

  @override
  void didUpdateWidget(covariant CartItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync with the server's authoritative count once it arrives, as long
    // as we're not mid-optimistic-update ourselves.
    if (!_isUpdatingQty && widget.item.count != null &&
        widget.item.count != _count) {
      _count = widget.item.count!;
    }
  }

  /// The cart API identifies cart lines by product id (see
  /// `updateItemsInCart(productId, count)` / `deleteItemsCart(productId)`).
  String get _productId => widget.item.product?.id ?? widget.item.id ?? '';

  Future<void> _changeQuantity(int delta) async {
    if (_isUpdatingQty || _isRemoving) return;
    final newCount = _count + delta;
    if (newCount < 1) return;

    final previousCount = _count;
    setState(() {
      _count = newCount;
      _isUpdatingQty = true;
    });

    final cartViewModel = CartViewModel.get(context);
    await cartViewModel.updateItemsInCart(_productId, newCount);

    if (!mounted) return;
    setState(() => _isUpdatingQty = false);

    final state = cartViewModel.state;
    if (state is UpdateItemInCartSuccessState) {
      widget.onCartUpdated(state.getCart);
    } else if (state is UpdateItemInCartErrorState) {
      setState(() => _count = previousCount); // roll back the optimistic change
      AppToast.error(context, state.message);
    }
  }

  Future<void> _confirmAndDelete() async {
    if (_isUpdatingQty || _isRemoving) return;

    final confirmed = await _showDeleteConfirmationDialog(context);
    if (confirmed != true) return;
    if (!mounted) return;

    setState(() => _isRemoving = true); // starts the fade/collapse animation

    final cartViewModel = CartViewModel.get(context);
    await cartViewModel.deleteItemsCart(_productId);

    if (!mounted) return;

    final state = cartViewModel.state;
    if (state is DeleteItemInCartSuccessState) {
      // Let the exit animation finish playing before the row actually
      // disappears from the list underneath it.
      await Future.delayed(const Duration(milliseconds: 220));
      if (!mounted) return;
      widget.onCartUpdated(state.getCart);
    } else if (state is DeleteItemInCartErrorState) {
      setState(() => _isRemoving = false);
      AppToast.error(context, state.message);
    }
  }

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) =>
          AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r)),
            title: Text('Remove item', style: AppTextStyle.bold20Black),
            content: Text(
              'Are you sure you want to remove this item from your cart?',
              style: AppTextStyle.normal16Grey,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text('Cancel', style: AppTextStyle.normal16Grey),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(
                  'Remove',
                  style: AppTextStyle.bold16Blue.copyWith(
                      color: AppColors.redColor),
                ),
              ),
            ],
          ),
    );
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
            : _buildCard(context),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    final product = widget.item.product;
    // TODO: confirm the real field name on your `Product` entity — assumed
    // `title` here, matching common Route-API product models.
    final String title = product?.title ?? '';
    final String imageUrl = product?.imageCover ?? '';
    final int price = widget.item.price ?? product?.price ?? 0;
    // On-device only — the API has no concept of variants.
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
                child: Icon(Icons.image_not_supported_outlined,
                    color: AppColors.greyColor),
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
                          strokeWidth: 2, color: AppColors.primaryColor),
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
                      onTap: _confirmAndDelete,
                      behavior: HitTestBehavior.opaque,
                      child: Icon(
                        Icons.delete_outline,
                        color: (_isUpdatingQty || _isRemoving)
                            ? AppColors.greyColor
                            : AppColors.primaryColor,
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
                            fontSize: 13.sp),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 14.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('EGP $price', style: AppTextStyle.bold16Blue),
                    _buildQuantityStepper(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityStepper() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: _isUpdatingQty
            ? AppColors.primaryColor.withOpacity(0.6)
            : AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stepperButton(
            icon: Icons.remove,
            onTap: _isUpdatingQty ? null : () => _changeQuantity(-1),
          ),
          SizedBox(
            width: 28.w,
            child: _isUpdatingQty
                ? Center(
              child: SizedBox(
                width: 14.w,
                height: 14.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.whiteColor,
                ),
              ),
            )
                : Text(
              '$_count',
              textAlign: TextAlign.center,
              style: AppTextStyle.normal16White,
            ),
          ),
          _stepperButton(
            icon: Icons.add,
            onTap: _isUpdatingQty ? null : () => _changeQuantity(1),
          ),
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