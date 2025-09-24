import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constant/app_container.dart';
import 'package:weather_app/core/constant/app_edge_insets.dart';
import 'package:weather_app/core/constant/app_extentions.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/core/utils/custom_image_view.dart';
import 'package:weather_app/core/utils/custom_text.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import '../cubit/search_location/location_search_cubit.dart';
import '../cubit/home_weather/weather_cubit.dart';
import '../cubit/search_location/location_search_state.dart';

class LocationSearchPage extends StatelessWidget {
  const LocationSearchPage({super.key});
  static const String routeName = '/location-search';

  @override
  Widget build(BuildContext context) {
    final appStrings = AppLocalizations.of(context)!;
    final appColors = AppColors.of(context);
    final appStyles = AppStyles.of(context);

    return Scaffold(
      appBar: AppBar(
        title: AppText(
          appStrings.searchLocation,
          style: appStyles.s18w500black,
        ),
      ),
      body: Padding(
        padding: AppEdgeInsets.all16(),
        child: Column(
          children: [
            TextField(
              onChanged: (query) {
                context.read<LocationSearchCubit>().search(query, appStrings);
              },
              decoration: InputDecoration(
                hintText: appStrings.search,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 42,
                  minHeight: 30,
                  maxWidth: 42,
                  minWidth: 30,
                ),
                prefixIcon: Center(
                  child: CustomImageView(
                    imagePath: Assets.svg.icSearch,
                    color: appColors.primary,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            ),
            16.heightBox,
            Expanded(
              child: BlocBuilder<LocationSearchCubit, LocationSearchState>(
                builder: (context, state) {
                  if (state is LocationSearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LocationSearchLoaded) {
                    final locations = state.locations;

                    if (locations.isEmpty) {
                      return Center(
                        child: AppText(
                          appStrings.noResultsFound,
                          style: appStyles.s14w400Grey,
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: locations.length,
                      separatorBuilder: (_, __) => 12.heightBox,
                      itemBuilder: (_, index) {
                        final location = locations[index];
                        return GestureDetector(
                          onTap: () {
                            context.read<WeatherCubit>().setCurrentLocation(
                              location.latitude,
                              location.longitude,
                              location.city,
                            );
                            Navigator.pop(context);
                          },
                          child: AppContainer.secondary(
                            context: context,
                            padding: AppEdgeInsets.all12(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AppText(
                                    location.name,
                                    style: appStyles.s16w500black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is LocationSearchError) {
                    return Center(
                      child: AppText(
                        state.message,
                        style: appStyles.s16w400Grey,
                      ),
                    );
                  }

                  return Center(
                    child: AppText(
                      appStrings.startTypingToSearch,
                      style: appStyles.s16w400Grey,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
