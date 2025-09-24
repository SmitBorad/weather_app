import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_theme.dart';

class AppContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  final BoxShape shape;
  final double radius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;

  const AppContainer._({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.shape = BoxShape.rectangle,
    this.radius = 12,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
  });

  factory AppContainer.circle({
    Key? key,
    required BuildContext context,
    Widget? child,
    double size = 45.0,
    EdgeInsets padding = const EdgeInsets.all(12),
    Color? backgroundColor,
    Color? borderColor,
    double borderWidth = 1.0,
  }) {
    final colors = AppColors.of(context);
    return AppContainer._(
      key: key,
      width: size,
      height: size,
      padding: padding,
      shape: BoxShape.circle,
      backgroundColor: backgroundColor ?? colors.secondary,
      borderColor: borderColor ?? colors.secondaryGrey,
      borderWidth: borderWidth,
      child: child,
    );
  }

  factory AppContainer.secondary({
    Key? key,
    required BuildContext context,
    Widget? child,
    EdgeInsets padding = const EdgeInsets.all(12),
    double radius = 12,
    Color? backgroundColor,
    Color? borderColor,
    double borderWidth = 1.0,
  }) {
    final colors = AppColors.of(context);
    return AppContainer._(
      key: key,
      padding: padding,
      radius: radius,
      backgroundColor: backgroundColor ?? colors.secondary,
      borderColor: borderColor ?? colors.secondaryGrey,
      borderWidth: borderWidth,
      child: child,
    );
  }

  factory AppContainer.primary({
    Key? key,
    required BuildContext context,
    Widget? child,
    double? height,
    double? width,
    EdgeInsets padding = const EdgeInsets.all(16),
    Color? backgroundColor,
  }) {
    final colors = AppColors.of(context);
    return AppContainer._(
      key: key,
      height: height,
      width: width,
      padding: padding,
      radius: 16,
      backgroundColor: backgroundColor ?? colors.primary,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: shape,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth,
        ),
        borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
