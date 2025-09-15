import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_theme.dart';

class AppContainer extends Container {
  AppContainer.circle({
    super.key,
    super.child,
    double size = 45.0,
    Color borderColor = AppColors.tempGrey,
    double borderWidth = 1.0,
    Color backgroundColor = AppColors.tempSecondary,
    EdgeInsets padding = const EdgeInsets.all(12),
  }) : super(
         width: size,
         height: size,
         padding: padding,
         decoration: BoxDecoration(
           shape: BoxShape.circle,
           color: backgroundColor,
           border: Border.all(color: borderColor, width: borderWidth),
         ),
       );

  AppContainer.primary({
    super.key,
    super.child,
    super.height,
    super.width,
    Color backgroundColor = AppColors.tempPrimary,
    EdgeInsets super.padding = const EdgeInsets.all(16),
  }) : super(
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: backgroundColor),
       );
}
