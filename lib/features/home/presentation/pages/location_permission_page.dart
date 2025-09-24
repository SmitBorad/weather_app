import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constant/app_edge_insets.dart';
import 'package:weather_app/core/constant/app_extentions.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/core/utils/custom_button.dart';
import 'package:weather_app/core/utils/custom_text.dart';
import 'package:weather_app/core/utils/custom_image_view.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import '../cubit/location_permission/location_cubit.dart';
import '../cubit/location_permission/location_state.dart';

class LocationPermissionPage extends StatelessWidget {
  const LocationPermissionPage({super.key});

  static const String routeName = '/location-permission';

  @override
  Widget build(BuildContext context) {
    final appStyles = AppStyles.of(context);
    final appColors = AppColors.of(context);
    final appStrings = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const AppEdgeInsets.h16(),
          child: BlocConsumer<LocationCubit, LocationState>(
            listener: (context, state) {
              if (state.isPermanentlyDenied) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: AppText(
                      appStrings.locationPermissionPermanentlyDenied,
                      style: appStyles.s14w400Grey,
                    ),
                    action: SnackBarAction(
                      label: appStrings.openSettings,
                      onPressed: openAppSettings,
                    ),
                  ),
                );
              }

              if (state.isError && state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: AppText(
                      state.errorMessage!,
                      style: appStyles.s14w400Grey,
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: appColors.primary,
                    child: Center(
                      child: CustomImageView(
                        imagePath: Assets.img.imgSunClouldWind.path,
                        height: 100,
                      ),
                    ),
                  ),
                  16.heightBox,
                  CenterText(
                    appStrings.locationPermissionNeeded,
                    style: appStyles.s20w600black,
                  ),
                  4.heightBox,
                  CenterText(
                    appStrings.locationPermissionNeededDis,
                    style: appStyles.s14w400Grey,
                  ),
                  30.heightBox,
                  state.isLoading
                      ? const CircularProgressIndicator()
                      : state.isServiceDisabled
                      ? AppButton(
                          onPressed: () {
                            context.read<LocationCubit>().enableLocation(
                              context,
                            );
                          },
                          text: appStrings.enableLocation,
                        )
                      : AppButton(
                          onPressed: () {
                            context.read<LocationCubit>().requestLocation(
                              context,
                            );
                          },
                          text: appStrings.allowLocation,
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
