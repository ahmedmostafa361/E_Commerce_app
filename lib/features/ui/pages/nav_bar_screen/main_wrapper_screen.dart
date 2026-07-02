import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utlis/app_assets .dart';
import '../../../../core/utlis/app_colors .dart';
import '../tabs/favourite_screen.dart';
import '../tabs/home_screen/home_screen.dart';
import '../tabs/product_screen.dart';
import '../tabs/profile_screen.dart';

class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({super.key});

  @override
  State<MainWrapperScreen> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<MainWrapperScreen> {
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
