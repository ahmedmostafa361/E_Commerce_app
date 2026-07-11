import 'package:e_commerce_flutter_app/core/utlis/app_colors%20.dart';
import 'package:e_commerce_flutter_app/core/utlis/app_text%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 26.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 26.w,
                  height: 26.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.primaryBlue,
                  ),
                ),
                SizedBox(width: 16.w),
                Flexible(
                  child: Text(message, style: AppTextStyle.normal18Grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? title,
    String? posActionName,
    VoidCallback? posAction,
    String? negActionName,
    VoidCallback? negAction,
    TextStyle? textStyle,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.r),
          ),
          titlePadding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
          contentPadding: EdgeInsets.fromLTRB(24.w, 4.h, 24.w, 12.h),
          actionsPadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
          title: title != null
              ? Text(
            title,
            style: (textStyle ?? AppTextStyle.normal18Grey).copyWith(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          )
              : null,
          content: Text(
            message,
            style: (textStyle ?? AppTextStyle.normal18Grey).copyWith(
                fontSize: 15.sp),
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            if (negActionName != null)
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  negAction?.call();
                },
                child: Text(
                  negActionName,
                  style: AppTextStyle.normal18Grey.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (posActionName != null)
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: AppColors.whiteColor,
                  padding: EdgeInsets.symmetric(
                      horizontal: 18.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  posAction?.call();
                },
                child: Text(
                  posActionName,
                  style: AppTextStyle.normal18White.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}