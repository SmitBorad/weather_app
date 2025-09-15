import 'package:flutter/material.dart';

part 'app_colors.dart';
part 'app_styles.dart';

// TextTheme textTheme = Get.theme.textTheme;
// ColorScheme colorScheme = Get.theme.colorScheme;

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
  );

  static ProgressIndicatorThemeData get _progressIndicatorTheme {
    return const ProgressIndicatorThemeData();
  }

  static BottomSheetThemeData get _bottomSheetTheme {
    return const BottomSheetThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return const InputDecorationTheme(
      contentPadding: EdgeInsets.all(8),
      // TODO: Add ErrorStyle
      // errorStyle: ,
      // TODO: Add hintStyle
      // hintStyle: ,
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
}

class TextFieldStyleProvider extends InheritedWidget {
  const TextFieldStyleProvider({super.key, required this.style, required super.child});

  final TextStyle style;

  static final styleKey = GlobalKey();

  static TextStyle? get styleOf {
    return styleKey.currentContext?.dependOnInheritedWidgetOfExactType<TextFieldStyleProvider>()?.style;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is! TextFieldStyleProvider) return false;

    return style != oldWidget.style;
  }
}
