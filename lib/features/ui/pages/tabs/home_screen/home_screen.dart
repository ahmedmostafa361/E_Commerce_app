import 'package:e_commerce_flutter_app/core/utlis/app_assets%20.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/tabs/home_screen/widget/RowOfTextAndViewAll.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/tabs/home_screen/widget/columnOfImageAndTextInCategories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // TODO: replace with real data from your API/model layer
  static const List<Map<String, String>> categories = [
    {'image': 'https://picsum.photos/id/1/200', 'label': 'Tech'},
    {'image': 'https://picsum.photos/id/2/200', 'label': 'Fashion'},
    {'image': 'https://picsum.photos/id/3/200', 'label': 'Home'},
    {'image': 'https://picsum.photos/id/4/200', 'label': 'Sports'},
    {'image': 'https://picsum.photos/id/5/200', 'label': 'Beauty'},
    {'image': 'https://picsum.photos/id/6/200', 'label': 'Toys'},
  ];

  static const List<Map<String, String>> brands = [
    {'image': 'https://picsum.photos/id/11/200', 'label': 'Apple'},
    {'image': 'https://picsum.photos/id/12/200', 'label': 'Samsung'},
    {'image': 'https://picsum.photos/id/13/200', 'label': 'Sony'},
  ];

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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const RowOfTextAndViewAll(name: 'Categories'),
          ),
          SizedBox(height: 12.h),
          _buildCategoryBrandSec(items: categories),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const RowOfTextAndViewAll(name: 'Brands'),
          ),
          SizedBox(height: 12.h),
          _buildCategoryBrandSec(items: brands),
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

  Widget _buildCategoryBrandSec({required List<Map<String, String>> items}) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return ColumnOfImageAndTextInCategories(
          imageUrl: items[index]['image']!,
          label: items[index]['label']!,
        );
      },
    );
  }
}
