import 'package:flutter/widgets.dart';
import 'package:weather_app/core/utils/custom_button.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    var appStrings = AppLocalizations.of(context)!;
    var appColors = AppColors.of(context);
    var appStyles = AppStyles.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, style: appStyles.s16w400Grey),
          const SizedBox(height: 12),
          AppButton(onPressed: onRetry, text: appStrings.retry),
        ],
      ),
    );
  }
}
