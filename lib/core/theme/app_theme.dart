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
      iconTheme: IconThemeData(color: AppColors.tempBlack),
    );
  }

  static ButtonThemeData get _buttonTheme {
    return const ButtonThemeData();
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
