import 'package:e_commerce_flutter_app/features/ui/pages/tabs/whishlist_screen/widget/whish_list_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../widget/toast_bar_message.dart';
import '../home_screen/widget/MainErrorWidget.dart';
import '../home_screen/widget/MainLodaingWidget.dart';
import '../whishlist_screen/cubit/whish_list_states.dart';
import '../whishlist_screen/cubit/whish_list_view_model.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

// CORRECTED: This was accidentally named _ProductTabItemState before
class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WhishListViewModel.get(context).getItemsWhishList();
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Wishlist'),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: BlocListener<WhishListViewModel, AddWhishListStates>(
        listener: (context, state) {
          if (state is DeleteItemInWhishListSuccessState) {
            AppToast.success(context, 'Item removed successfully');
          } else if (state is DeleteItemInWhishListErrorState) {
            AppToast.error(context, state.message);
          }
        },
        child: BlocBuilder<WhishListViewModel, AddWhishListStates>(
          builder: (context, state) {
            final viewModel = WhishListViewModel.get(context);

            // Show loading ONLY if the list is completely empty
            if (state is GetWhishListLoadingState &&
                viewModel.whishList.isEmpty) {
              return const Center(child: MainLoadingWidget());
            }

            // Show error ONLY if the list is completely empty
            if (state is GetWhishListErrorState &&
                viewModel.whishList.isEmpty) {
              return MainErrorWidget(
                errorMessage: state.message,
                onPressed: () => viewModel.getItemsWhishList(),
              );
            }

            // If loading finished and there are no items
            if (viewModel.whishList.isEmpty) {
              return _buildEmptyState();
            }

            // Show the list (allows pull-to-refresh)
            return RefreshIndicator(
              onRefresh: () => viewModel.getItemsWhishList(),
              color: Colors.blue,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                itemCount: viewModel.whishList.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final product = viewModel.whishList[index];
                  return WishlistItem(
                    key: ValueKey(product.id ?? index.toString()),
                    product: product,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 64.sp,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 12.h),
          Text(
            'Your wishlist is empty',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}