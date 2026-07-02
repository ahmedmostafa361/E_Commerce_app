import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/home_screen/tabs/favourite_screen.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/home_screen/tabs/home_screen.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/home_screen/tabs/product_screen.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/home_screen/tabs/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utlis/app_assets .dart';
import '../../../../core/utlis/app_colors .dart';

class mainWrapperScreen extends StatefulWidget {
  const mainWrapperScreen({super.key});

  @override
  State<mainWrapperScreen> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<mainWrapperScreen> {
  int selectedIndex = 0;

  // order matches your image: home, category, heart, user
  final navIcons = [
    AppAssets.home,
    AppAssets.category,
    AppAssets.heart,
    AppAssets.user,
  ];

  final List<Widget> selectedWidget = [
    const HomeScreen(),
    const ProductScreen(),
    const FavouriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        backgroundColor: AppColors.primaryBlue,
        itemCount: navIcons.length,
        height: 64.h,
        tabBuilder: (int index, bool isActive) {
          return Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                // white hover/pill ONLY on the selected item
                color: isActive ? AppColors.whiteColor : Colors.transparent,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  isActive ? AppColors.primaryBlue : AppColors.whiteColor,
                  BlendMode.srcIn,
                ),
                child: Image.asset(navIcons[index], width: 22.w, height: 22.w),
              ),
            ),
          );
        },
        activeIndex: selectedIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        splashColor: Colors.transparent,
        onTap: (index) => setState(() => selectedIndex = index),
      ),
      body: selectedWidget[selectedIndex],
    );
  }
}
