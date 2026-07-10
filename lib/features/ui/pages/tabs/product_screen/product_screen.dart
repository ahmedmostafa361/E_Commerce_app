// import 'package:e_commerce_flutter_app/core/utlis/app_routes%20.dart';
// import 'package:e_commerce_flutter_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
// import 'package:e_commerce_flutter_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
// import 'package:e_commerce_flutter_app/features/ui/pages/tabs/home_screen/widget/MainErrorWidget.dart';
// import 'package:e_commerce_flutter_app/features/ui/pages/tabs/home_screen/widget/MainLodaingWidget.dart';
// import 'package:e_commerce_flutter_app/features/ui/pages/tabs/product_screen/cubit/product_screen_states.dart';
// import 'package:e_commerce_flutter_app/features/ui/pages/tabs/product_screen/widget/product_tab_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../config/di.dart';
// import '../../../../../widget/toast_bar_message.dart';
// import '../whishlist_screen/cubit/whish_list_states.dart';
// import '../whishlist_screen/cubit/whish_list_view_model.dart';
// import 'cubit/product_screen_view_model.dart';
//
// class ProductScreen extends StatefulWidget {
//   const ProductScreen({super.key});
//
//   @override
//   State<ProductScreen> createState() => _ProductScreenState();
// }
//
// class _ProductScreenState extends State<ProductScreen> {
//   final ProductScreenViewModel productScreenViewModel =
//   getIt<ProductScreenViewModel>();
//
//   @override
//   void initState() {
//     super.initState();
//     // 1. Fetch your products list
//     productScreenViewModel.getProducts();
//
//     // 2. FIXED: Fetch your wishlist items instantly on startup
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       WhishListViewModel.get(context).getItemsWhishList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<CartViewModel, AddCartStates>(
//           listener: (context, state) {
//             if (state is AddCartSuccessState) {
//               AppToast.success(context, 'Item Added Successfully');
//             } else if (state is AddCartErrorState) {
//               AppToast.error(context, state.message);
//             }
//           },
//         ),
//         BlocListener<WhishListViewModel, AddWhishListStates>(
//           listener: (context, state) {
//             if (state is AddWhishListSuccessState) {
//               AppToast.success(context, 'Item Added to your wishlist');
//             } else if (state is AddWhishListErrorState) {
//               AppToast.error(context, state.message);
//             }
//           },
//         ),
//       ],
//       child: BlocBuilder<ProductScreenViewModel, ProductScreenStates>(
//         bloc: productScreenViewModel,
//         builder: (context, state) {
//           if (state is ProductScreenErrorState) {
//             return MainErrorWidget(
//               errorMessage: state.message,
//               onPressed: productScreenViewModel.getProducts,
//             );
//           } else if (state is ProductScreenSuccessState) {
//             // 3. FIXED: Wrap the grid with a Wishlist BlocBuilder so it redraws
//             // the heart shapes the moment the backend response comes back!
//             return BlocBuilder<WhishListViewModel, AddWhishListStates>(
//               builder: (context, wishListState) {
//                 final wishListViewModel = WhishListViewModel.get(context);
//
//                 return SafeArea(
//                   child: GridView.builder(
//                     padding: EdgeInsets.all(16.w),
//                     itemCount: state.productsList?.length ?? 0,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 16.h,
//                       crossAxisSpacing: 12.w,
//                       childAspectRatio: 0.62,
//                     ),
//                     // itemBuilder: (context, index) {
//                     //   final product = state.productsList![index];
//                     //
//                     //   // Check if this specific item is favorited in the global list
//                     //   final isFav = wishListViewModel.whishList.any((item) => item.id == product.id);
//                     //
//                     //   return InkWell(
//                     //     borderRadius: BorderRadius.circular(16.r),
//                     //     onTap: () {
//                     //       Navigator.of(context).pushNamed(
//                     //           AppRoutes.productDetailsScreen,
//                     //           arguments: state.productsList![index]);
//                     //     },
//                     //     child: ProductTabItem(
//                     //       // Using a dynamic key forces Flutter to safely update the heart
//                     //       // checkbox rendering state without throwing any layout conflicts!
//                     //       key: ValueKey('${product.id}_$isFav'),
//                     //       product: product,
//                     //     ),
//                     //   );
//                     // },
//                     itemBuilder: (context, index) {
//                       final product = state.productsList![index];
//
//                       // Check if this specific item is favorited in the global list
//                       final isFav = wishListViewModel.whishList.any((item) => item.id == product.id);
//
//                       return InkWell(
//                         borderRadius: BorderRadius.circular(16.r),
//                         // FIXED: Made async to catch the return transition back to this screen
//                         onTap: () async {
//                           await Navigator.of(context).pushNamed(
//                               AppRoutes.productDetailsScreen,
//                               arguments: product);
//
//                           // Forces the grid view to instantly re-read the updated wishlist arrays
//                           // the exact millisecond the user returns to this page!
//                           if (mounted) {
//                             setState(() {});
//                           }
//                         },
//                         child: ProductTabItem(
//                           // Using a dynamic key forces Flutter to safely update the heart
//                           // checkbox rendering state without throwing any layout conflicts!
//                           key: ValueKey('${product.id}_$isFav'),
//                           product: product,
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const Center(child: MainLoadingWidget());
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:e_commerce_flutter_app/core/utlis/app_routes%20.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/tabs/home_screen/widget/MainErrorWidget.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/tabs/home_screen/widget/MainLodaingWidget.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/tabs/product_screen/cubit/product_screen_states.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/tabs/product_screen/widget/product_tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/di.dart';
import '../../../../../widget/toast_bar_message.dart';
import '../whishlist_screen/cubit/whish_list_states.dart';
import '../whishlist_screen/cubit/whish_list_view_model.dart';
import 'cubit/product_screen_view_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductScreenViewModel productScreenViewModel =
  getIt<ProductScreenViewModel>();

  @override
  void initState() {
    super.initState();
    productScreenViewModel.getProducts();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      WhishListViewModel.get(context).getItemsWhishList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CartViewModel, AddCartStates>(
          listener: (context, state) {
            if (state is AddCartSuccessState) {
              AppToast.success(context, 'Item Added Successfully');
            } else if (state is AddCartErrorState) {
              AppToast.error(context, state.message);
            }
          },
        ),
        BlocListener<WhishListViewModel, AddWhishListStates>(
          listener: (context, state) {
            if (state is AddWhishListSuccessState) {
              AppToast.success(context, 'Item Added to your wishlist');
            } else if (state is AddWhishListErrorState) {
              AppToast.error(context, state.message);
            }
          },
        ),
      ],
      child: BlocBuilder<ProductScreenViewModel, ProductScreenStates>(
        bloc: productScreenViewModel,
        builder: (context, state) {
          if (state is ProductScreenErrorState) {
            return MainErrorWidget(
              errorMessage: state.message,
              onPressed: productScreenViewModel.getProducts,
            );
          } else if (state is ProductScreenSuccessState) {
            return BlocBuilder<WhishListViewModel, AddWhishListStates>(
              builder: (context, wishListState) {
                final wishListViewModel = WhishListViewModel.get(context);

                return SafeArea(
                  child: GridView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: state.productsList?.length ?? 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.h,
                      crossAxisSpacing: 12.w,
                      childAspectRatio: 0.62,
                    ),
                    itemBuilder: (context, index) {
                      final product = state.productsList![index];

                      final isFav = wishListViewModel.whishList.any((
                          item) => item.id == product.id);

                      return InkWell(
                        borderRadius: BorderRadius.circular(16.r),
                        // FIXED: Forces a data re-fetch directly from the server on return
                        onTap: () async {
                          await Navigator.of(context).pushNamed(
                              AppRoutes.productDetailsScreen,
                              arguments: product);

                          if (mounted) {
                            // Pulls clean server-side favorite updates instantly when coming back
                            WhishListViewModel.get(context).getItemsWhishList();
                          }
                        },
                        child: ProductTabItem(
                          key: ValueKey('${product.id}_$isFav'),
                          product: product,
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: MainLoadingWidget());
          }
        },
      ),
    );
  }
}