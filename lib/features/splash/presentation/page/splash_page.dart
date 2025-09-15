import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/core/constant/app_edge_insets.dart';
import 'package:weather_app/core/constant/app_extentions.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/core/utils/custom_button.dart';
import 'package:weather_app/core/utils/custom_text.dart';
import 'package:weather_app/core/utils/custom_image_view.dart';
import 'package:weather_app/core/utils/permission_utills.dart';
import 'package:weather_app/features/home/presentation/pages/location_permission_page.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/l10n/app_localizations.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  onSplash({required BuildContext context})async{
    try{
      final status = await Permission.location.status;
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if(status.isGranted&&serviceEnabled){
        await  fetchCurrentLocation(context);
      }else{
        Future.delayed(Duration(seconds: 3),() {
          LocationPermissionPage.toRoute(context: context);
        },);
      }
    }catch(e){
      Future.delayed(Duration(seconds: 3),() {
        LocationPermissionPage.toRoute(context: context);
      },);
    }

  }

  @override
  Widget build(BuildContext context) {
    var appStyles = AppStyles.of(context);
    var appColors = AppColors.of(context);
    var appStrings = AppLocalizations.of(context)!;
    onSplash(context: context);
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
              20.heightBox,
              CenterText(appStrings.weatherApp, style: appStyles.s20w600black),

            ],
          ),
        ),
      ),
    );
  }
}
