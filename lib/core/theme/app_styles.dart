part of 'app_theme.dart';

const _kOutfitFontFamily = 'Outfit';

class Outfit extends TextStyle {
  const Outfit({
    super.fontSize,
    super.color,
    super.decoration,
    super.fontWeight,
    super.overflow,
    super.decorationColor,
    super.height,
  }) : super(fontFamily: _kOutfitFontFamily);
}

class AppStyles extends ThemeExtension<AppStyles> {
  const AppStyles({
    this.defaultTextStyle = const Outfit(),
    this.s20w600black = const Outfit(color: AppColors.tempBlack, fontWeight: FontWeight.w600, fontSize: 20),
    this.s18w500black = const Outfit(color: AppColors.tempBlack, fontWeight: FontWeight.w500, fontSize: 18),
    this.s16w500black = const Outfit(color: AppColors.tempBlack, fontWeight: FontWeight.w500, fontSize: 16),
    this.s18w500Grey = const Outfit(color: AppColors.tempGrey, fontWeight: FontWeight.w500, fontSize: 18),
    this.s16w400Grey = const Outfit(color: AppColors.tempGrey, fontWeight: FontWeight.w400, fontSize: 16),
    this.s14w400Grey = const Outfit(color: AppColors.tempGrey, fontWeight: FontWeight.w400, fontSize: 14),
  });

  final TextStyle defaultTextStyle;
  final TextStyle s20w600black;
  final TextStyle s18w500black;
  final TextStyle s16w500black;

  final TextStyle s18w500Grey;
  final TextStyle s16w400Grey;
  final TextStyle s14w400Grey;

  static AppStyles of(BuildContext context) {
    return Theme.of(context).extension<AppStyles>()!;
  }

  @override
  ThemeExtension<AppStyles> copyWith() {
    return this;
  }

  @override
  ThemeExtension<AppStyles> lerp(covariant ThemeExtension<AppStyles>? other, double t) {
    if (other is! AppStyles) {
      return this;
    }

    return other;
  }
}
