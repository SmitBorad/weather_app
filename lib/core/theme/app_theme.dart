import 'package:flutter/material.dart';

part 'app_colors.dart';
part 'app_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    extensions: const [AppColors(), AppStyles()],
    scaffoldBackgroundColor: AppColors.tempWhite,
    buttonTheme: _buttonTheme,
    appBarTheme: _appBarTheme,
    fontFamily: _kOutfitFontFamily,
    inputDecorationTheme: _inputDecorationTheme,
    bottomSheetTheme: _bottomSheetTheme,
    progressIndicatorTheme: _progressIndicatorTheme,
    iconTheme: const IconThemeData(color: AppColors.tempBlack),
  );

  static ProgressIndicatorThemeData get _progressIndicatorTheme {
    return const ProgressIndicatorThemeData(color: AppColors.tempPrimary);
  }

  static BottomSheetThemeData get _bottomSheetTheme {
    return const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.tempSecondary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.tempGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.tempGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.tempPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      hintStyle: AppStyles().s14w400Grey,
      labelStyle: AppStyles().s16w500black,
      errorStyle: const Outfit(
        color: Colors.red,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static AppBarTheme get _appBarTheme {
    return const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.tempWhite,
      titleTextStyle: Outfit(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }

  static ButtonThemeData get _buttonTheme {
    return const ButtonThemeData();
  }

  static ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    extensions: const [
      AppColors(
        primary: AppColors.tempPrimary,
        secondary: AppColors.tempDarkSecondary,
        secondaryGrey: AppColors.tempDarkGrey,
        white: AppColors.tempBlack,
        black: AppColors.tempWhite,
      ),
      AppStyles(
        s20w600black: Outfit(
          color: AppColors.tempWhite,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        s18w500black: Outfit(
          color: AppColors.tempWhite,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        s16w500black: Outfit(
          color: AppColors.tempWhite,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        s18w500Grey: Outfit(
          color: AppColors.tempDarkGrey,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        s16w400Grey: Outfit(
          color: AppColors.tempDarkGrey,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        s14w400Grey: Outfit(
          color: AppColors.tempDarkGrey,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    ],
    scaffoldBackgroundColor: AppColors.tempDarkSecondary,
    buttonTheme: _buttonTheme,
    appBarTheme: _darkAppBar,
    fontFamily: _kOutfitFontFamily,
    inputDecorationTheme: _darkInputDecorationTheme,
    bottomSheetTheme: _darkBottomSheetTheme,
    progressIndicatorTheme: _darkProgressIndicatorTheme,

    iconTheme: const IconThemeData(color: AppColors.tempBlack),
  );

  static InputDecorationTheme get _darkInputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.tempDarkSecondary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.tempDarkGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.tempDarkGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.tempPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      hintStyle: AppStyles().s14w400Grey,
      labelStyle: AppStyles().s16w500black,
      errorStyle: const Outfit(
        color: Colors.red,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static AppBarTheme get _darkAppBar {
    return const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.tempDarkSecondary,
      titleTextStyle: Outfit(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.tempWhite,
      ),
    );
  }

  static BottomSheetThemeData get _darkBottomSheetTheme {
    return const BottomSheetThemeData(
      backgroundColor: AppColors.tempDarkSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  static ProgressIndicatorThemeData get _darkProgressIndicatorTheme {
    return const ProgressIndicatorThemeData(color: AppColors.tempPrimary);
  }
}

class TextFieldStyleProvider extends InheritedWidget {
  const TextFieldStyleProvider({
    super.key,
    required this.style,
    required super.child,
  });

  final TextStyle style;

  static final styleKey = GlobalKey();

  static TextStyle? get styleOf {
    return styleKey.currentContext
        ?.dependOnInheritedWidgetOfExactType<TextFieldStyleProvider>()
        ?.style;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is! TextFieldStyleProvider) return false;

    return style != oldWidget.style;
  }
}
