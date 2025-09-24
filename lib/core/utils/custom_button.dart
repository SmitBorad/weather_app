import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_theme.dart';

class AppButton extends MaterialButton {
  AppButton({
    super.key,
    required VoidCallback onPressed,
    required String text,
    Color backgroundColor = AppColors.tempPrimary, // Purple
    TextStyle textStyle = const TextStyle(color: AppColors.tempWhite, fontSize: 16, fontWeight: FontWeight.w500),
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    double borderRadius = 30,
  }) : super(
         onPressed: onPressed,
         color: backgroundColor,
         padding: padding,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
         child: Text(text, style: textStyle),
       );
}
