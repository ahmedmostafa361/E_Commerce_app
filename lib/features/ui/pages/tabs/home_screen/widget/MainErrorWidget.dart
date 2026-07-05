import 'package:e_commerce_flutter_app/core/utlis/app_text%20.dart';
import 'package:flutter/material.dart';

class MainErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onPressed;

  const MainErrorWidget({
    super.key,
    required this.errorMessage,
    this.onPressed,
  });

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(errorMessage, style: AppTextStyle.bold16Red),
          onPressed != null
              ? ElevatedButton(
                  onPressed: onPressed,
                  child: Text('Try Again', style: AppTextStyle.normal16Grey),
                )
              : Container(),
        ],
      ),
    );
  }
}
