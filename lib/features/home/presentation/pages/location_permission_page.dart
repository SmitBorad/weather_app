import 'package:flutter/material.dart';
import 'package:weather_app/core/constant/app_edge_insets.dart';
import 'package:weather_app/core/constant/app_extentions.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/core/utils/custom_button.dart';
import 'package:weather_app/core/utils/custom_text.dart';
import 'package:weather_app/core/utils/custom_image_view.dart';
import 'package:weather_app/core/utils/permission_utills.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/l10n/app_localizations.dart';

class LocationPermissionPage extends StatelessWidget {
  const LocationPermissionPage({super.key});
  static Future<void> toRoute({required BuildContext context}) {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LocationPermissionPage()));
  }
  @override
  Widget build(BuildContext context) {
    var appStyles = AppStyles.of(context);
    var appColors = AppColors.of(context);
    var appStrings = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const AppEdgeInsets.h16(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: appColors.primary,
                child: Center(child: CustomImageView(imagePath: Assets.img.imgSunClouldWind.path, height: 100)),
              ),
              16.heightBox,
              CenterText(appStrings.locationPermissionNeeded, style: appStyles.s20w600black),
              4.heightBox,

              CenterText(appStrings.locationPermissionNeededDis, style: appStyles.s14w400Grey),
              30.heightBox,
              AppButton(
                onPressed: () async {
                  await handleLocationPermission(context);
                },
                text: appStrings.allowLocation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
