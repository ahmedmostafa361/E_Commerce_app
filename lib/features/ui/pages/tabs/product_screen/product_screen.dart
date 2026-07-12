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
import '../../../../../core/utlis/app_colors .dart';
import '../../../../../core/utlis/app_text .dart';
import '../../../../../domain/entinties/response/category/category_or_brand.dart';
import '../../../../../domain/entinties/response/products/product.dart';
import '../../../../../widget/toast_bar_message.dart';
import '../home_screen/cubit/home_screen_states.dart';
import '../home_screen/cubit/home_screen_view_model.dart';
import '../whishlist_screen/cubit/whish_list_states.dart';
import '../whishlist_screen/cubit/whish_list_view_model.dart';
import 'cubit/product_screen_view_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductScreenViewModel productScreenViewModel = getIt<
      ProductScreenViewModel>();

  // Same real categories API used elsewhere (Home tab), not fabricated.
  final HomeScreenViewModel categoriesViewModel = getIt<HomeScreenViewModel>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // null = "All Products" (no filter applied).
  CategoryOrBrand? _selectedCategory;

  @override
  void initState() {
    super.initState();
    productScreenViewModel.getProducts();
    categoriesViewModel.getCategories();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      WhishListViewModel.get(context).getItemsWhishList();
    });
  }

  List<Product> _filterByCategory(List<Product> all) {
    if (_selectedCategory == null) return all;
    return all.where((p) => p.category?.id == _selectedCategory!.id).toList();
  }

  void _selectCategory(CategoryOrBrand? category) {
    setState(() => _selectedCategory = category);
    Navigator
        .of(context)
        .pop(); // closes the drawer, same as tapping outside it
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
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.whiteColor,
        drawer: _buildCategoriesDrawer(),
        body: Column(
          children: [
            _buildHeaderRow(),
            Expanded(child: _buildProductsBody()),
          ],
        ),
      ),
    );
  }

  // ---------------- Slim header: menu button + current filter name ----------------

  Widget _buildHeaderRow() {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 16.w, 8.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: Icon(
                Icons.menu_rounded, color: AppColors.primaryBlue, size: 24.sp),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              _selectedCategory?.name ?? 'All Products',
              style: AppTextStyle.bold20PrimaryBlue,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Categories drawer ----------------

  Widget _buildCategoriesDrawer() {
    return Drawer(
      backgroundColor: AppColors.whiteColor,
      child: SafeArea(
        child: BlocBuilder<HomeScreenViewModel, HomeScreenState>(
          bloc: categoriesViewModel,
          buildWhen: (previous, current) =>
          previous.categoriesList != current.categoriesList ||
              previous.isCategoriesLoading != current.isCategoriesLoading ||
              previous.categoriesError != current.categoriesError,
          builder: (context, state) {
            if (state.isCategoriesLoading) {
              return const Center(child: MainLoadingWidget());
            }
            if (state.categoriesError != null) {
              return MainErrorWidget(
                errorMessage: state.categoriesError!,
                onPressed: categoriesViewModel.getCategories,
              );
            }

            final categories = state.categoriesList;

            return ListView(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 4.h),
                  child: Text(
                      'Categories', style: AppTextStyle.bold20PrimaryBlue),
                ),
                SizedBox(height: 8.h),
                _buildDrawerTile(name: 'All Products',
                    isSelected: _selectedCategory == null,
                    onTap: () => _selectCategory(null)),
                ...categories.map(
                      (category) =>
                      _buildDrawerTile(
                        name: category.name ?? '',
                        isSelected: _selectedCategory?.id == category.id,
                        onTap: () => _selectCategory(category),
                      ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDrawerTile({
    required String name,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: AppColors.primaryBlue.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      title: Text(
        name,
        style: isSelected
            ? AppTextStyle.bold16Black.copyWith(color: AppColors.primaryBlue)
            : AppTextStyle.bold16Black.copyWith(
          color: AppColors.greyColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ---------------- Product grid — same pattern as the original code ----------------

  Widget _buildProductsBody() {
    return BlocBuilder<ProductScreenViewModel, ProductScreenStates>(
      bloc: productScreenViewModel,
      builder: (context, state) {
        if (state is ProductScreenErrorState) {
          return MainErrorWidget(
            errorMessage: state.message,
            onPressed: productScreenViewModel.getProducts,
          );
        } else if (state is ProductScreenSuccessState) {
          final products = _filterByCategory(state.productsList ?? []);

          if (products.isEmpty) {
            return Center(
              child: Text('No products found here yet.',
                  style: AppTextStyle.normal16Grey),
            );
          }

          return BlocBuilder<WhishListViewModel, AddWhishListStates>(
            builder: (context, wishListState) {
              final wishListViewModel = WhishListViewModel.get(context);

              return GridView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 12.w,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  final isFav =
                  wishListViewModel.whishList.any((item) =>
                  item.id == product.id);

                  return InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: () async {
                      await Navigator.of(context).pushNamed(
                        AppRoutes.productDetailsScreen,
                        arguments: product,
                      );
                      if (mounted) {
                        WhishListViewModel.get(context).getItemsWhishList();
                      }
                    },
                    child: ProductTabItem(
                      key: ValueKey('${product.id}_$isFav'),
                      product: product,
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const Center(child: MainLoadingWidget());
        }
      },
    );
  }
}