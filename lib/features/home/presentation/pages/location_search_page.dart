import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constant/app_container.dart';
import 'package:weather_app/core/constant/app_edge_insets.dart';
import 'package:weather_app/core/constant/app_extentions.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/core/utils/custom_image_view.dart';
import 'package:weather_app/core/utils/custom_text.dart';
import 'package:weather_app/features/home/presentation/bloc/location_search_cubit.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/l10n/app_localizations.dart';

import '../bloc/weather_cubit.dart';

class LocationSearchPage extends StatelessWidget {
  const LocationSearchPage({super.key});

  /// Navigation method with route result
  static Future toRoute({required BuildContext context}) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LocationSearchPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appStrings = AppLocalizations.of(context)!;
    final appColors = AppColors.of(context);
    final appStyles = AppStyles.of(context);

    return Scaffold(
      appBar: AppBar(leading:  Padding(
        padding: const EdgeInsets.all(6),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: AppContainer.circle(context: context,child: Center(child: Icon(Icons.arrow_back,color: appColors.black,size: 20,)),),
        ),
      ),
        title: AppText(appStrings.searchLocation, style: appStyles.s18w500black),
      ),
      body: Padding(
        padding: AppEdgeInsets.all16(),
        child: Column(
          children: [
            TextField(
              onChanged: (query) {
                context.read<LocationSearchCubit>().search(query);
              },
              decoration: InputDecoration(
                hintText: appStrings.search,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefix:CustomImageView(imagePath:Assets.svg.icSearch),
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
                      return Center(child: AppText(appStrings.noResultsFound, style: appStyles.s14w400Grey,));
                    }

                    return ListView.separated(
                      itemCount: locations.length,
                      separatorBuilder: (_, __) => 12.heightBox,
                      itemBuilder: (_, index) {
                        final location = locations[index];
                        return GestureDetector(
                          onTap: () {
                            context.read<WeatherCubit>().setCurrentLocation(location.latitude,location.longitude,location.city);
                            Navigator.pop(context);
                          },
                          child:

                          AppContainer.secondary(
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
                    return Center(child: AppText(state.message, style: appStyles.s16w400Grey));
                  }

                  return Center(child: AppText(appStrings.startTypingToSearch, style: appStyles.s16w400Grey));


                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
