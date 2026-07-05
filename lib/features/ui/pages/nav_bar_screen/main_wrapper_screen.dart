import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:e_commerce_flutter_app/features/ui/pages/nav_bar_screen/cubit/wrapper_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/di.dart';
import '../../../../core/utlis/app_colors .dart';
import 'cubit/wrapper_screen_states.dart';


class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({super.key});

  @override
  State<MainWrapperScreen> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<MainWrapperScreen> {

  WrapperScreenViewModel viewModel = getIt<WrapperScreenViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WrapperScreenViewModel, WrapperScreenStates>(
      bloc: viewModel,
      builder: (BuildContext context, WrapperScreenStates state) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            backgroundColor: AppColors.primaryBlue,
            itemCount: viewModel.navIcons.length,
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
                    child: Image.asset(
                        viewModel.navIcons[index], width: 22.w, height: 22.w),
                  ),
                ),
              );
            },
            activeIndex: viewModel.selectedIndex,
            gapLocation: GapLocation.none,
            notchSmoothness: NotchSmoothness.softEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            splashColor: Colors.transparent,
            onTap: viewModel.changeIndex,
          ),
          body: viewModel.selectedWidget[viewModel.selectedIndex],
        );
      },

    );
  }
}
