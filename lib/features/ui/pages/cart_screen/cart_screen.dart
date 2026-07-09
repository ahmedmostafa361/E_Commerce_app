// import 'package:e_commerce_flutter_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
// import 'package:e_commerce_flutter_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
// import 'package:e_commerce_flutter_app/features/ui/pages/cart_screen/widget/cart_item.dart';
// import 'package:e_commerce_flutter_app/features/ui/pages/tabs/home_screen/widget/MainErrorWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../core/utlis/app_colors .dart';
// import '../../../../core/utlis/app_routes .dart';
// import '../../../../core/utlis/app_text .dart';
// import '../../../../widget/custom_app_bar/custom_app_bar_cart.dart';
// import '../../../../widget/custom_elevated_button .dart';
// import '../tabs/home_screen/widget/MainLodaingWidget.dart';
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   @override
//   void initState() {
//     super.initState();
//     CartViewModel.get(context).getItemsCart();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       body: SafeArea(
//         child: Column(
//           children: [
//             CustomAppBarCart(
//               titleText: 'Cart',
//               onCartTap: () {
//                 Navigator.of(context).pushNamed(AppRoutes.cartScreen);
//               },
//             ),
//             Expanded(
//               child: BlocBuilder<CartViewModel, AddCartStates>(
//                 builder: (context, state) {
//                   if (state is GetCartErrorState) {
//                     return MainErrorWidget(errorMessage: state.message);
//                   } else if (state is GetCartSuccessState) {
//                     final products = state.getCart.products ?? [];
//
//                     if (products.isEmpty) {
//                       return _buildEmptyCart();
//                     }
//
//                     return Column(
//                       children: [
//                         Expanded(
//                           child: ListView.builder(
//                             padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
//                             itemCount: products.length,
//                             itemBuilder: (context, index) {
//                               final item = products[index];
//                               return CartItem(
//                                 item: item,
//                                 onIncrement: () {
//                                   // TODO: call your update-quantity use case once it
//                                   // exists, e.g.:
//                                   // CartViewModel.get(context).updateCartItemQuantity(
//                                   //   item.id ?? '',
//                                   //   (item.count ?? 1) + 1,
//                                   // );
//                                 },
//                                 onDecrement: () {
//                                   // TODO: same as above, guard against going below 1:
//                                   // final newCount = (item.count ?? 1) - 1;
//                                   // if (newCount < 1) return;
//                                   // CartViewModel.get(context).updateCartItemQuantity(
//                                   //   item.id ?? '',
//                                   //   newCount,
//                                   // );
//                                 },
//                                 onDelete: () {
//                                   // TODO: call your remove-from-cart use case once it
//                                   // exists, e.g.:
//                                   // CartViewModel.get(context).removeCartItem(item.id ?? '');
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                         _buildBottomBar(context, state.getCart.totalCartPrice ??
//                             0),
//                       ],
//                     );
//                   } else {
//                     return const MainLoadingWidget();
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyCart() {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 32.w),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               Icons.shopping_cart_outlined,
//               size: 64.sp,
//               color: AppColors.primaryColor.withOpacity(0.4),
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               'Your cart is empty',
//               style: AppTextStyle.bold20Black,
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               'Looks like you haven\'t added anything to your cart yet.',
//               style: AppTextStyle.normal16Grey,
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBottomBar(BuildContext context, int totalPrice) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 14.h),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 12,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('Total price', style: AppTextStyle.normal16Grey),
//                 SizedBox(height: 2.h),
//                 Text('EGP $totalPrice', style: AppTextStyle.bold16Blue),
//               ],
//             ),
//           ),
//           SizedBox(width: 12.w),
//           Expanded(
//             flex: 3,
//             child: CustomElevatedButton(
//               onPressed: () {
//                 // TODO: navigate to your checkout flow, e.g.:
//                 // Navigator.of(context).pushNamed(AppRoutes.checkoutScreen);
//               },
//               backgroundColor: AppColors.primaryColor,
//               hasIcon: true,
//               customInButton: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'Check Out',
//                     style: AppTextStyle.normal16White,
//                   ),
//                   SizedBox(width: 8.w),
//                   Icon(Icons.arrow_forward, color: AppColors.whiteColor,
//                       size: 18.sp),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:e_commerce_flutter_app/domain/entinties/response/add_cart/get_cart.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/cart_screen/widget/cart_item.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/tabs/home_screen/widget/MainErrorWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utlis/app_colors .dart';
import '../../../../core/utlis/app_routes .dart';
import '../../../../core/utlis/app_text .dart';
import '../../../../widget/custom_app_bar/custom_app_bar_cart.dart';
import '../../../../widget/custom_elevated_button .dart';
import '../tabs/home_screen/widget/MainLodaingWidget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Kept in local state (instead of switching the whole body off the Bloc
  // state directly) so that transient loading states triggered by a single
  // item's +/-/delete action don't blow away and re-render the entire list.
  // Only the very first load (before we have any cart yet) shows a
  // full-screen loading/error state.
  GetCart? _cart;
  String? _initialLoadError;

  @override
  void initState() {
    super.initState();
    CartViewModel.get(context).getItemsCart();
  }

  void _onCartUpdated(GetCart cart) {
    setState(() => _cart = cart);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBarCart(
              titleText: 'Cart',
              onCartTap: () {
                Navigator.of(context).pushNamed(AppRoutes.cartScreen);
              },
            ),
            Expanded(
              child: BlocListener<CartViewModel, AddCartStates>(
                listener: (context, state) {
                  if (state is GetCartSuccessState) {
                    _onCartUpdated(state.getCart);
                  } else if (state is GetCartErrorState && _cart == null) {
                    setState(() => _initialLoadError = state.message);
                  }
                  // Update/delete success is handled inside CartItem itself
                  // (it calls _onCartUpdated directly) since it already
                  // knows exactly which row triggered the action. Their
                  // error states are also surfaced as toasts from there.
                },
                child: _buildBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_cart == null) {
      if (_initialLoadError != null) {
        return MainErrorWidget(errorMessage: _initialLoadError!);
      }
      return const MainLoadingWidget();
    }

    final products = _cart!.products ?? [];
    if (products.isEmpty) {
      return _buildEmptyCart();
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final item = products[index];
              return CartItem(
                // Stable key so Flutter preserves each row's local state
                // (its optimistic count, in-flight flags, etc.) across
                // rebuilds instead of recreating the widget from scratch.
                key: ValueKey(item.product?.id ?? item.id ?? index),
                item: item,
                onCartUpdated: _onCartUpdated,
              );
            },
          ),
        ),
        _buildBottomBar(_cart!.totalCartPrice ?? 0),
      ],
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 64.sp,
              color: AppColors.primaryColor.withOpacity(0.4),
            ),
            SizedBox(height: 16.h),
            Text(
              'Your cart is empty',
              style: AppTextStyle.bold20Black,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'Looks like you haven\'t added anything to your cart yet.',
              style: AppTextStyle.normal16Grey,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(int totalPrice) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 14.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Total price', style: AppTextStyle.normal16Grey),
                SizedBox(height: 2.h),
                // AnimatedSwitcher gives the total price a quick pop/fade
                // whenever it changes after an update/delete — a small
                // touch that makes it feel responsive to your actions.
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: Text(
                    'EGP $totalPrice',
                    key: ValueKey<int>(totalPrice),
                    style: AppTextStyle.bold16Blue,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 3,
            child: CustomElevatedButton(
              onPressed: () {
                // TODO: navigate to your checkout flow, e.g.:
                // Navigator.of(context).pushNamed(AppRoutes.checkoutScreen);
              },
              backgroundColor: AppColors.primaryColor,
              hasIcon: true,
              customInButton: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Check Out', style: AppTextStyle.normal16White),
                  SizedBox(width: 8.w),
                  Icon(Icons.arrow_forward, color: AppColors.whiteColor,
                      size: 18.sp),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}