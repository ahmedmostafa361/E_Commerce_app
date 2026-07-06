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
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartViewModel, AddCartStates>(
      listener: (BuildContext context, AddCartStates state) {
        if (state is AddCartSuccessState) {
          AppToast.success(context, 'Item Added Successfully');
        } else if (state is AddCartErrorState) {
          AppToast.error(context, state.message);
        } else {

        }
      },
      child: BlocBuilder<ProductScreenViewModel, ProductScreenStates>(
        bloc: productScreenViewModel, // was missing - would have crashed
        builder: (context, state) {
          if (state is ProductScreenErrorState) {
            return MainErrorWidget(
              errorMessage: state.message,
              onPressed: productScreenViewModel.getProducts,
            );
          } else if (state is ProductScreenSuccessState) {
            return SafeArea(
              child: GridView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: state.productsList?.length ?? 0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 12.w,
                  childAspectRatio: 0.62, // tweak based on your device testing
                ),
                itemBuilder: (context, index) {
                  final product = state.productsList![index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: () {
                      // TODO: Navigate to details screen
                      Navigator.of(context).pushNamed(
                          AppRoutes.productDetailsScreen,
                          arguments: state.productsList![index]);
                    },
                    child: ProductTabItem(product: product),
                  );
                },
              ),
            );
          } else {
            return const Center(child: MainLoadingWidget());
          }
        },
      ),
    );
  }
}