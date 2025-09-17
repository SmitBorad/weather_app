part of 'app_theme.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color primary;
  final Color secondary;
  final Color secondaryGrey;
  final Color white;
  final Color black;
  const AppColors({this.primary = tempPrimary, this.secondary = tempSecondary,this.secondaryGrey = tempGrey, this.white = tempWhite, this.black = tempBlack});

  // light
  static const Color tempPrimary = Color(0xff6151C3);
  static const Color tempSecondary = Color(0xffF7F6FC);
  static const Color tempWhite = Color(0xffFFFFFF);
  static const Color tempBlack = Color(0xff080713);
  static const Color tempGrey = Color(0xff6B6A71);

  // dark
  static const Color tempDarkSecondary =  Color(0xFF1C1B1F);
  static const Color tempDarkGrey =  Color(0xFFB3B3B3);


  static AppColors of(BuildContext context) {
    return Theme.of(context).extension<AppColors>()!;
  }

  @override
  ThemeExtension<AppColors> copyWith() {
    return this;
  }

  @override
  ThemeExtension<AppColors> lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return other;
  }
}
