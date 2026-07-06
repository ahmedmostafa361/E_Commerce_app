import 'package:e_commerce_flutter_app/core/utlis/app_assets%20.dart';
import 'package:e_commerce_flutter_app/domain/entinties/response/category/category_or_brand.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/tabs/home_screen/cubit/home_screen_states.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/tabs/home_screen/cubit/home_screen_view_model.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/tabs/home_screen/widget/MainErrorWidget.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/tabs/home_screen/widget/MainLodaingWidget.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/tabs/home_screen/widget/RowOfTextAndViewAll.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/tabs/home_screen/widget/columnOfImageAndTextInCategories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/di.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  // TODO: replace with real data once brands API is ready
  static const List<Map<String, String>> brands = [
    {'image': 'https://picsum.photos/id/11/200', 'label': 'Apple'},
    {'image': 'https://picsum.photos/id/12/200', 'label': 'Samsung'},
    {'image': 'https://picsum.photos/id/13/200', 'label': 'Sony'},
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final viewModel = getIt<HomeScreenViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getCategories();
    viewModel.getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h),
          _imageSliderShowAds(
            images: [AppAssets.ad1, AppAssets.ad2, AppAssets.ad3],
          ),
          SizedBox(height: 20.h),

          // Categories header - static, doesn't need Cubit
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const RowOfTextAndViewAll(name: 'Categories'),
          ),
          SizedBox(height: 12.h),

          BlocBuilder<HomeScreenViewModel, HomeScreenState>(
            bloc: viewModel,
            buildWhen: (previous, current) =>
                previous.categoriesList != current.categoriesList ||
                previous.isCategoriesLoading != current.isCategoriesLoading ||
                previous.categoriesError != current.categoriesError,
            builder: (context, state) {
              if (state.isCategoriesLoading) {
                return MainLoadingWidget();
              }

              if (state.categoriesError != null) {
                return MainErrorWidget(
                  errorMessage: state.categoriesError!,
                  onPressed: viewModel.getCategories,
                );
              }

              return _buildCategoryBrandSec(
                categoryOrBrandList: state.categoriesList,
              );
            },
          ),

          SizedBox(height: 20.h),

          // Brands section - static for now
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const RowOfTextAndViewAll(name: 'Brands'),
          ),
          SizedBox(height: 12.h),

          BlocBuilder<HomeScreenViewModel, HomeScreenState>(
            bloc: viewModel,
            buildWhen: (previous, current) =>
                previous.brandsList != current.brandsList ||
                previous.isBrandsLoading != current.isBrandsLoading ||
                previous.brandsError != current.brandsError,
            builder: (context, state) {
              if (state.isBrandsLoading) {
                return MainLoadingWidget();
              }

              if (state.brandsError != null) {
                return MainErrorWidget(
                  errorMessage: state.brandsError!,
                  onPressed: viewModel.getBrands,
                );
              }

              return _buildCategoryBrandSec(
                categoryOrBrandList: state.brandsList,
              );
            },
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _imageSliderShowAds({required List<String> images}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: ImageSlideshow(
          width: double.infinity,
          height: 180.h,
          initialPage: 0,
          indicatorColor: Colors.blue.shade900,
          indicatorBackgroundColor: Colors.white.withValues(alpha: 0.6),
          autoPlayInterval: 4000,
          isLoop: true,
          children: images
              .map(
                (img) => ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildCategoryBrandSec({
    required List<CategoryOrBrand> categoryOrBrandList,
  }) {
    return SizedBox(
      height: 220.h, // try increasing this, e.g. 240.h, 260.h
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: categoryOrBrandList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.w,
          crossAxisSpacing: 16.h,
          childAspectRatio: 0.68, // was 0.8 — lower value = taller cell
        ),
        itemBuilder: (context, index) {
          return ColumnOfImageAndTextInCategories(
            item: categoryOrBrandList[index],
          );
        },
      ),
    );
  }
}
