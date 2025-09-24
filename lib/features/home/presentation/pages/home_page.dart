import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/constant/app_container.dart';
import 'package:weather_app/core/constant/app_edge_insets.dart';
import 'package:weather_app/core/constant/app_extentions.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/core/utils/custom_image_view.dart';
import 'package:weather_app/core/utils/custom_text.dart';
import 'package:weather_app/features/home/domain/entities/weather.dart';
import 'package:weather_app/features/home/presentation/cubit/home_weather/weather_cubit.dart';
import 'package:weather_app/features/home/presentation/pages/location_search_page.dart';
import 'package:weather_app/features/home/presentation/pages/weather_map_page.dart';
import 'package:weather_app/features/home/presentation/widgets/error_widget.dart';
import 'package:weather_app/features/home/presentation/widgets/weather_temperature_chart.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import '../cubit/home_weather/weather_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    var appStrings = AppLocalizations.of(context)!;
    var appColors = AppColors.of(context);
    var appStyles = AppStyles.of(context);

    return Scaffold(
      appBar: AppBar(
        title: AppText(
          appStrings.discoverTheWeather,
          style: appStyles.s18w500black,
        ),
        actionsPadding: AppEdgeInsets.h16(),
        actions: [
          GestureDetector(
            onTap: () {
              context.goNamed(LocationSearchPage.routeName);
            },
            child: AppContainer.circle(
              context: context,
              child: CustomImageView(
                imagePath: Assets.svg.icSearch,
                height: 20,
                width: 20,
              ),
            ),
          ),
          12.widthBox,
          GestureDetector(
            onTap: () {
              context.goNamed(WeatherMapPage.routeName);
            },
            child: AppContainer.circle(
              context: context,
              child: CustomImageView(
                imagePath: Assets.svg.icGlobal,
                height: 20,
                width: 20,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            final currentWeather = state.currentWeather;
            final forecast = state.forecast;

            return SingleChildScrollView(
              padding: AppEdgeInsets.all16(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ---- CURRENT WEATHER CARD ----
                  AppContainer.primary(
                    context: context,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    appStrings.currentLocation,
                                    style: appStyles.s16w400Grey.copyWith(
                                      color: AppColors.tempWhite,
                                    ),
                                  ),
                                  4.heightBox,
                                  AppText(
                                    context.read<WeatherCubit>().currentCity ??
                                        '--',
                                    style: appStyles.s20w600black.copyWith(
                                      color: AppColors.tempWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomImageView(
                              imagePath:
                                  'https://openweathermap.org/img/wn/${currentWeather.icon}.png',
                              height: 60,
                              width: 60,
                            ),
                          ],
                        ),
                        8.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              appStrings.windSpeed(
                                currentWeather.windSpeed.toStringAsFixed(2),
                              ),
                              style: appStyles.s16w400Grey.copyWith(
                                color: AppColors.tempWhite,
                              ),
                            ),
                            AppText(
                              '${currentWeather.temperature.toStringAsFixed(1)} ℃',
                              style: appStyles.s18w500black.copyWith(
                                color: AppColors.tempWhite,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  16.heightBox,

                  AppText(appStrings.upcoming, style: appStyles.s18w500black),
                  8.heightBox,
                  Row(
                    children: List.generate(forecast.length, (index) {
                      final dayWeather = forecast[index];

                      return DayForcastCard(
                        context,
                        dayWeather,
                        appStyles,
                        appColors,
                      );
                    }),
                  ),
                  16.heightBox,
                  AppText(
                    appStrings.temperatureChart,
                    style: appStyles.s18w500black,
                  ),
                  8.heightBox,
                  WeatherTemperatureChart(
                    weatherData: [currentWeather] + forecast,
                  ),
                ],
              ),
            );
          } else if (state is WeatherError) {
            return ErrorView(
              message: state.message,
              onRetry: () {
                context.read<WeatherCubit>().retryHomeData();
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Expanded DayForcastCard(
    BuildContext context,
    Weather dayWeather,
    AppStyles appStyles,
    AppColors appColors,
  ) {
    return Expanded(
      child: Padding(
        padding: AppEdgeInsets.h4(),
        child: AppContainer.primary(
          context: context,
          child: Column(
            children: [
              AppText(
                DateFormat(
                  'dd MMM',
                ).format(DateTime.parse(dayWeather.dateTime)),
                style: appStyles.s16w500black.copyWith(
                  fontSize: 12,
                  color: appColors.white,
                ),
              ),
              4.heightBox,
              CustomImageView(
                imagePath:
                    'https://openweathermap.org/img/wn/${dayWeather.icon}.png',
                height: 50,
                width: 50,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImageView(
                    imagePath: Assets.svg.icWind,
                    color: appColors.white,
                    height: 20,
                  ),
                  4.widthBox,
                  AppText(
                    dayWeather.windSpeed.toStringAsFixed(1).toString(),
                    style: appStyles.s16w500black.copyWith(
                      fontSize: 12,
                      color: appColors.white,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  CustomImageView(
                    imagePath: Assets.svg.icTemperature,
                    color: appColors.white,
                    height: 20,
                  ),
                  4.widthBox,
                  AppText(
                    dayWeather.temperature.toStringAsFixed(1),
                    style: appStyles.s16w500black.copyWith(
                      fontSize: 12,
                      color: appColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
