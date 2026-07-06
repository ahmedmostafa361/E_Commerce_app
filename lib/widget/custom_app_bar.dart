import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utlis/app_assets .dart';
import '../core/utlis/app_colors .dart';
import '../core/utlis/app_text .dart';
import '../features/ui/pages/cart_screen/cubit/cart_states.dart';
import '../features/ui/pages/cart_screen/cubit/cart_view_model.dart';

/// Custom home app bar: logo on top, search field + cart icon (with a live
/// item-count badge) below it — matches the provided design.
///
/// Reads the live cart count from `CartViewModel.numOfCartItems` via
/// `BlocBuilder<CartViewModel, AddCartStates>`, so the badge updates
/// automatically whenever `CartViewModel.get(context).addToCart(...)` is
/// called anywhere in the app.
///
/// Usage:
/// ```dart
/// Scaffold(
///   appBar: CustomHomeAppBar(
///     searchController: _searchController,
///     onSearchChanged: (query) => viewModel.onSearchChanged(query),
///     onCartTap: () => Navigator.pushNamed(context, AppRoutes.cartScreen),
///   ),
///   body: ...,
/// )
/// ```
class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchSubmitted;
  final VoidCallback? onCartTap;

  const CustomHomeAppBar({
    super.key,
    this.searchController,
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.onCartTap,
  });

  @override
  Size get preferredSize => Size.fromHeight(118.h);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLogo(),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(child: _buildSearchField()),
                SizedBox(width: 12.w),
                _AnimatedCartIcon(onTap: onCartTap),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      AppAssets.logoECommerce,
      height: 26.h,
      fit: BoxFit.contain,
    );
  }

  Widget _buildSearchField() {
    OutlineInputBorder border({Color? color, double width = 1}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.r),
        borderSide: BorderSide(
          color: color ?? AppColors.primaryColor,
          width: width,
        ),
      );
    }

    return SizedBox(
      height: 44.h,
      child: TextField(
        controller: searchController,
        onChanged: onSearchChanged,
        onSubmitted: (_) => onSearchSubmitted?.call(),
        textAlignVertical: TextAlignVertical.center,
        style: AppTextStyle.normal16Grey,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: AppColors.whiteColor,
          hintText: 'what do you search for?',
          hintStyle: AppTextStyle.normal16Grey,
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.primaryColor,
            size: 22.sp,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
          border: border(),
          enabledBorder: border(),
          focusedBorder: border(width: 1.4),
        ),
      ),
    );
  }
}

/// Cart icon + badge, wrapped in its own [StatefulWidget] so it can play a
/// jump/pulse animation on the whole icon whenever an item is successfully
/// added to the cart — on top of the badge's own pop-in animation.
class _AnimatedCartIcon extends StatefulWidget {
  final VoidCallback? onTap;

  const _AnimatedCartIcon({this.onTap});

  @override
  State<_AnimatedCartIcon> createState() => _AnimatedCartIconState();
}

class _AnimatedCartIconState extends State<_AnimatedCartIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _jumpAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    // Quick pulse: 1.0 -> 1.3 -> 0.9 -> 1.0
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.3,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.3,
          end: 0.9,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.9,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
    ]).animate(_controller);

    // Small upward jump then settle back down.
    _jumpAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: -8.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: -8.0,
          end: 2.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 2.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playAddedAnimation() {
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartViewModel, AddCartStates>(
      bloc: CartViewModel.get(context),
      listener: (context, state) {
        // Fires only when an item is actually added successfully — not on
        // loading or error states, so the icon doesn't jump on a failed add.
        if (state is AddCartSuccessState) {
          _playAddedAnimation();
        }
      },
      builder: (context, state) {
        final int itemsCount = CartViewModel.get(context).numOfCartItems;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: SizedBox(
            width: 44.w,
            height: 44.w,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _jumpAnimation.value),
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: AppColors.primaryColor,
                    size: 26.sp,
                  ),
                  Positioned(
                    top: -2.h,
                    right: -4.w,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.elasticOut,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder: (child, animation) => ScaleTransition(
                        scale: animation,
                        child: FadeTransition(opacity: animation, child: child),
                      ),
                      child: itemsCount > 0
                          ? Container(
                              key: ValueKey<int>(itemsCount),
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 1.h,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 17.w,
                                minHeight: 17.w,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.redColor,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: AppColors.whiteColor,
                                  width: 1.2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                itemsCount > 99 ? '99+' : '$itemsCount',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.normal16White.copyWith(
                                  fontSize: 10.sp,
                                  height: 1,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(key: ValueKey('empty-badge')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
