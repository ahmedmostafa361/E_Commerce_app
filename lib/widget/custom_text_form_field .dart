import 'package:flutter/material.dart';

import '../core/utlis/app_colors .dart';
import '../core/utlis/app_text .dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Color borderSideColor;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final TextStyle? style; // 1. ضفنا المتغير ده هنا للخط اللي بيتكتب
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final String obscuringCharacter;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    this.fillColor,
    this.controller,
    this.maxLines,
    this.borderSideColor = AppColors.transparentColor,
    this.prefixIcon,
    this.labelText,
    this.hintText,
    this.style, // 2. مررناه جوه الـ Constructor
    this.hintStyle,
    this.labelStyle,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.obscuringCharacter = '*', this.suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // 3. التعديل السحري: لو بعت ستايل هيقبله، لو مبعتش هياخد الـ Theme الافتراضي بتاعك
      style: style ?? Theme
          .of(context)
          .textTheme
          .headlineSmall,
      maxLines: maxLines ?? 1,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      obscuringCharacter: obscuringCharacter,
      decoration: InputDecoration(
        border: outlineInputBorder(borderSideColor: borderSideColor),
        enabledBorder: outlineInputBorder(borderSideColor: borderSideColor),
        focusedBorder: outlineInputBorder(borderSideColor: borderSideColor),
        errorBorder: outlineInputBorder(borderSideColor: AppColors.redColor),
        focusedErrorBorder: outlineInputBorder(
          borderSideColor: AppColors.redColor,
        ),
        fillColor: fillColor ?? AppColors.whiteColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        hintText: hintText,
        hintStyle: hintStyle ?? AppTextStyle.normal18Grey,
        labelText: labelText,
        labelStyle: labelStyle ?? AppTextStyle.normal18Grey,
      ),
    );
  }

  OutlineInputBorder outlineInputBorder({required Color borderSideColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: borderSideColor,
        width: 1,
        style: BorderStyle.solid,
      ),
    );
  }
}