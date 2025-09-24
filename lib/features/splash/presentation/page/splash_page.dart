import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constant/app_edge_insets.dart';
import 'package:weather_app/core/constant/app_extentions.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/core/utils/custom_image_view.dart';
import 'package:weather_app/core/utils/custom_text.dart';
import 'package:weather_app/features/home/presentation/cubit/location_permission/location_cubit.dart';
import 'package:weather_app/features/home/presentation/cubit/location_permission/location_state.dart';
import 'package:weather_app/features/home/presentation/pages/home_page.dart';
import 'package:weather_app/features/home/presentation/pages/location_permission_page.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String routeName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      context.read<LocationCubit>().onSplash(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appStyles = AppStyles.of(context);
    final appColors = AppColors.of(context);
    final appStrings = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocListener<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state.isFetched || state.isGranted) {
            context.goNamed(HomePage.routeName);
          } else if (state.isDenied ||
              state.isPermanentlyDenied ||
              state.isServiceDisabled) {
            context.goNamed(LocationPermissionPage.routeName);
          }
        },
        child: Center(
          child: Padding(
            padding: const AppEdgeInsets.h16(),
            child: Column(
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
                20.heightBox,
                CenterText(
                  appStrings.weatherApp,
                  style: appStyles.s20w600black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
