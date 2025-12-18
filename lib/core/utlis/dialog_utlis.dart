import 'package:e_commerce_flutter_app/core/utlis/app_text%20.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message, style: AppTextStyle.normal18Grey),
              ),
            ],
          ),
        );
      },
    );
  }
  static void hideLoading(BuildContext context) {
    Navigator.pop(context);}

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
              title: title != null
                  ? Text(title, style: textStyle ?? AppTextStyle.normal18Grey)
                  : null,
              content: Text(message, style: textStyle ?? AppTextStyle.normal18Grey),
              actions: [
              if (negActionName != null)
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              negAction?.call();
            },
            child: Text(negActionName),
          ),
          if (posActionName != null)
          TextButton(
          onPressed: () {
          Navigator.pop(context);
          posAction?.call();
          },
          child: Text(posActionName),
          ),
              ],
          );
        },
    );
  }
}