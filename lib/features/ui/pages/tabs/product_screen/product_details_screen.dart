import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_routes%20.dart';
import 'package:e_commerce_flutter_app/widget/custom_app_bar/custom_app_bar_cart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/cache_save_data/cart_variant_storage_for_size_color.dart';
import '../../../../../core/utlis/app_colors .dart';
import '../../../../../core/utlis/app_text .dart';
import '../../../../../domain/entinties/response/products/product.dart';
import '../../../../../widget/toast_bar_message.dart';
import '../../cart_screen/cubit/cart_states.dart';
import '../../cart_screen/cubit/cart_view_model.dart';
import '../whishlist_screen/cubit/whish_list_states.dart';
import '../whishlist_screen/cubit/whish_list_view_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  int _quantity = 1;
  int _selectedSizeIndex = 2; // default matches design (size "40" pre-selected)
  int _selectedColorIndex =
  1; // default matches design (2nd color pre-selected)
  bool _isFavourite = false;
  bool _isDescriptionExpanded = false;

  bool _isFirstLoad = true;
  // TODO: replace with real data once API sends size/color options
  static const List<String> fakeSizes = ['38', '39', '40', '41', '42'];
  static const List<Color> fakeColors = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.pinkAccent,
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    if (_isFirstLoad) {
      final wishListViewModel = WhishListViewModel.get(context);
      _isFavourite =
          wishListViewModel.whishList.any((item) => item.id == product.id);
      _isFirstLoad = false;
    }
    final images = (product.images != null && product.images!.isNotEmpty)
        ? product.images!
        : [product.imageCover ?? ''];

    final realPrice = product.price ?? 0;
    final totalPrice = realPrice * _quantity;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBarCart(
              titleText: 'Product Details',
              onCartTap: () {
                Navigator.of(context).pushNamed(AppRoutes.cartScreen);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14.h),
                    _buildImageSlider(images, product),
                    SizedBox(height: 20.h),
                    _buildTitleAndPrice(product, realPrice),
                    SizedBox(height: 16.h),
                    _buildSoldRatingAndQuantity(product),
                    SizedBox(height: 24.h),
                    _buildDescription(product),
                    SizedBox(height: 24.h),
                    _buildSizeSelector(),
                    SizedBox(height: 24.h),
                    _buildColorSelector(),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            _buildBottomBar(totalPrice),
          ],
        ),
      ),
    );
  }

  // ---------------- Image slider ----------------
  Widget _buildImageSlider(List<String> images, Product productId) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: SizedBox(
              height: 320.h,
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                itemCount: images.length,
                onPageChanged: (index) =>
                    setState(() => _currentImageIndex = index),
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(
                          color: Colors.grey.shade200,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.redColor,
                            ),
                          ),
                        ),
                    errorWidget: (context, url, error) =>
                        Container(
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.error_outline,
                            color: AppColors.redColor,
                            size: 32.sp,
                          ),
                        ),
                  );
                },
              ),
            ),
          ),
        ),
        // favourite icon
        Positioned(
          top: 14.h,
          right: 14.w,
          child: GestureDetector(
            onTap: () => _toggleFavourite(productId),
            // `productId` param is actually the Product
            child: Container(
              padding: EdgeInsets.all(9.w),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  _isFavourite ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey<bool>(_isFavourite),
                  color: AppColors.primaryBlue,
                  size: 24.sp,
                ),
              ),
            ),
          ),
        ),
        // page indicator dots
        if (images.length > 1)
          Positioned(
            bottom: 14.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                final isActive = index == _currentImageIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: isActive ? 22.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color:
                    isActive ? AppColors.primaryBlue : Colors.white.withOpacity(
                        0.8),
                    borderRadius: BorderRadius.circular(5.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }

  Future<void> _toggleFavourite(Product product) async {
    final productId = product.id ?? '';
    if (productId.isEmpty) return;

    final whishListViewModel = WhishListViewModel.get(context);

    // ---- LIVE DELETION PATH ----
    if (_isFavourite) {
      setState(() => _isFavourite = false); // Optimistic UI flip

      await whishListViewModel.deleteItemsWhishList(productId);

      if (!mounted) return;
      if (whishListViewModel.state is DeleteItemInWhishListErrorState) {
        setState(() => _isFavourite = true); // Rollback on failure
      }
      return;
    }

    // ---- LIVE ADDITION PATH ----
    setState(() => _isFavourite = true);

    await whishListViewModel.addToWhishList(productId);

    if (!mounted) return;

    if (whishListViewModel.state is AddWhishListErrorState) {
      setState(() => _isFavourite = false);
    }
  }

  Widget _buildTitleAndPrice(Product product, int realPrice) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: AutoSizeText(
            product.title ?? 'No title',
            style: AppTextStyle.bold14black.copyWith(fontSize: 22.sp),
            maxLines: 2,
            minFontSize: 16,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 10.w),
        AutoSizeText(
          'EGP $realPrice',
          style: AppTextStyle.bold14black.copyWith(
            fontSize: 22.sp,
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.w800,
          ),
          maxLines: 1,
          minFontSize: 14,
        ),
      ],
    );
  }

  // ---------------- Sold + rating + quantity ----------------
  Widget _buildSoldRatingAndQuantity(Product product) {
    return Row(
      children: [
        // sold pill
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.06),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: AutoSizeText(
            '${product.sold ?? 0} Sold',
            style: AppTextStyle.normal12grey.copyWith(fontSize: 14.sp),
            maxLines: 1,
          ),
        ),
        SizedBox(width: 12.w),
        // rating
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.12),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, size: 18.sp, color: Colors.amber),
                SizedBox(width: 4.w),
                Flexible(
                  child: AutoSizeText(
                    '${product.ratingsAverage?.toStringAsFixed(1) ??
                        '0.0'} (${product.ratingsQuantity ?? 0})',
                    style: AppTextStyle.normal12grey.copyWith(fontSize: 14.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        // quantity stepper
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryBlue, AppColors.primaryBlue.withOpacity(
                  0.8)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlue.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _quantityButton(
                icon: Icons.remove,
                onTap: () {
                  if (_quantity > 1) setState(() => _quantity--);
                },
              ),
              SizedBox(width: 12.w),
              Text(
                '$_quantity',
                style: AppTextStyle.normal18White.copyWith(fontSize: 16.sp),
              ),
              SizedBox(width: 12.w),
              _quantityButton(
                icon: Icons.add,
                onTap: () {
                  final maxQuantity = product.quantity ?? 999;
                  if (_quantity < maxQuantity) setState(() => _quantity++);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // registers taps across the whole box, not just the icon glyph
      onTap: onTap,
      child: SizedBox(
        width: 28.w,
        height: 28.w,
        child: Icon(icon, color: Colors.white, size: 20.sp),
      ),
    );
  }

  // ---------------- Description ----------------
  Widget _buildDescription(Product product) {
    final description = product.description ?? 'No description available.';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppTextStyle.bold14black.copyWith(fontSize: 20.sp),
        ),
        SizedBox(height: 8.h),
        RichText(
          maxLines: _isDescriptionExpanded ? null : 2,
          overflow: _isDescriptionExpanded
              ? TextOverflow.visible
              : TextOverflow.ellipsis,
          text: TextSpan(
            style: AppTextStyle.normal12grey.copyWith(
              fontSize: 16.sp,
              height: 1.5,
            ),
            children: [
              TextSpan(text: description),
              TextSpan(
                text: _isDescriptionExpanded ? '  Show less' : '  Read More',
                style: AppTextStyle.bold14black.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.primaryBlue,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(
                          () =>
                      _isDescriptionExpanded = !_isDescriptionExpanded,
                    );
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------- Size selector ----------------
  // TODO: replace fakeSizes with product.sizes once API supports it
  Widget _buildSizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size', style: AppTextStyle.bold14black.copyWith(fontSize: 20.sp)),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: List.generate(fakeSizes.length, (index) {
            final isSelected = index == _selectedSizeIndex;
            return GestureDetector(
              onTap: () => setState(() => _selectedSizeIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 52.w,
                height: 52.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.primaryBlue : Colors
                      .transparent,
                  border: Border.all(
                    color:
                    isSelected ? AppColors.primaryBlue : Colors.grey.shade300,
                    width: 1.5,
                  ),
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: AppColors.primaryBlue.withOpacity(0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                      : null,
                ),
                child: AutoSizeText(
                  fakeSizes[index],
                  style: isSelected
                      ? AppTextStyle.normal18White.copyWith(fontSize: 18.sp)
                      : AppTextStyle.bold14black.copyWith(fontSize: 18.sp),
                  maxLines: 1,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ---------------- Color selector ----------------
  // TODO: replace fakeColors with product.colors once API supports it
  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: AppTextStyle.bold14black.copyWith(fontSize: 20.sp),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 14.w,
          runSpacing: 12.h,
          children: List.generate(fakeColors.length, (index) {
            final isSelected = index == _selectedColorIndex;
            return GestureDetector(
              onTap: () => setState(() => _selectedColorIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(isSelected ? 3.w : 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: fakeColors[index], width: 2)
                      : null,
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: fakeColors[index].withOpacity(0.45),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                      : null,
                ),
                child: Container(
                  width: 42.w,
                  height: 42.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: fakeColors[index],
                  ),
                  child: isSelected
                      ? Icon(Icons.check, color: Colors.white, size: 20.sp)
                      : null,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // --- Add these inside _ProductDetailsScreenState, alongside your existing
  // methods. Only the onPressed body of the button changed — everything else
  // in your _buildBottomBar is untouched. ---

  Future<void> _handleAddToCart(BuildContext context, Product product) async {
    final cartViewModel = CartViewModel.get(context);
    await cartViewModel.addToCart(product.id ?? '');
    await cartViewModel.updateItemsInCart(product.id ?? '', _quantity);
    if (!context.mounted) return;

    final state = cartViewModel.state;
    if (state is AddCartSuccessState) {
      // Real backend call succeeded — now remember the chosen color/size
      // locally (on-device only) so the Cart screen can display it, since
      // the API itself doesn't accept or return variant data.
      await CartVariantsStorage.saveVariant(
        productId: product.id ?? '',
        colorValue: fakeColors[_selectedColorIndex].value,
        size: fakeSizes[_selectedSizeIndex],
      );

      if (context.mounted) {
        AppToast.success(context, 'Item added successfully');
      }
    } else if (state is AddCartErrorState) {
      AppToast.error(context, state.message);
    }
  }

  Widget _buildBottomBar(int totalPrice) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total price',
                    style: AppTextStyle.normal12grey.copyWith(fontSize: 14.sp),
                  ),
                  AutoSizeText(
                    'EGP $totalPrice',
                    style: AppTextStyle.bold14black.copyWith(
                      fontSize: 20.sp,
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              flex: 2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withOpacity(0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () => _handleAddToCart(context, product),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                  ),
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 22.sp,
                  ),
                  label: AutoSizeText(
                    'Add to cart',
                    style: AppTextStyle.normal18White.copyWith(fontSize: 17.sp),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}