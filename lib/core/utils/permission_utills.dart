// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:go_router/go_router.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:weather_app/core/theme/app_theme.dart';
// import 'package:weather_app/core/utils/custom_button.dart';
// import 'package:weather_app/core/utils/custom_text.dart';
// import 'package:weather_app/features/home/presentation/pages/home_page.dart';
// import 'package:weather_app/l10n/app_localizations.dart';
//
// /// Entry point: Request permission and fetch current location.
// Future<Position?> handleLocationPermission(BuildContext context) async {
//   // Check current permission status
//   final status = await Permission.location.status;
//
//   if (status.isGranted) {
//     await fetchCurrentLocation(context);
//   }
//
//   if (status.isDenied) {
//     // Ask for permission once
//     final result = await Permission.location.request();
//
//     if (result.isGranted) {
//       await fetchCurrentLocation(context);
//     } else if (result.isDenied) {
//       // Just denied again
//       _showSnackBar(
//         context,
//         AppLocalizations.of(context)!.locationPermissionPermanentlyDenied,
//       );
//     } else if (result.isPermanentlyDenied) {
//       // Can't ask again, must open settings
//       _showPermissionDeniedSnackBar(context);
//     }
//
//     return null;
//   }
//
//   if (status.isPermanentlyDenied) {
//     _showPermissionDeniedSnackBar(context);
//     return null;
//   }
//
//   return null;
// }
//
// /// Fetch current position, assuming permission is granted.
// Future<Position?> fetchCurrentLocation(BuildContext context) async {
//   final serviceEnabled = await Geolocator.isLocationServiceEnabled();
//
//   if (!serviceEnabled) {
//     _showLocationServicesDialog(context); // Ask user to enable GPS
//     return null;
//   }
//
//   try {
//     final position = await Geolocator.getCurrentPosition();
//     String city = await getCityFromPosition(position) ?? '--';
//     context.read<WeatherCubit>().setCurrentLocation(
//       position.latitude,
//       position.longitude,
//       city,
//     );
//
//     context.goNamed(HomePage.routeName);
//   } catch (e) {
//     _showSnackBar(context, "Failed to get location: $e");
//     return null;
//   }
//   return null;
// }
//
// /// Show a snackbar when permission is permanently denied.
// void _showPermissionDeniedSnackBar(BuildContext context) {
//   if (!context.mounted) return;
//   var appStrings = AppLocalizations.of(context)!;
//   var appStyles = AppStyles.of(context);
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       backgroundColor: AppColors.tempSecondary,
//       content: AppText(
//         appStrings.locationPermissionPermanentlyDenied,
//         style: appStyles.s14w400Grey,
//         maxLines: 2,
//       ),
//       action: SnackBarAction(
//         label: appStrings.openSettings,
//         textColor: AppColors.tempWhite,
//         backgroundColor: AppColors.tempPrimary,
//         onPressed: openAppSettings,
//       ),
//     ),
//   );
// }
//
// /// Show dialog to ask user to enable location (GPS) services.
// void _showLocationServicesDialog(BuildContext context) {
//   if (!context.mounted) return;
//   var appStrings = AppLocalizations.of(context)!;
//   var appStyles = AppStyles.of(context);
//   var appColors = AppColors.of(context);
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       backgroundColor: appColors.white,
//       title: CenterText(
//         appStrings.locationPermissionNeeded,
//         style: appStyles.s16w500black,
//       ),
//       content: Text(
//         AppLocalizations.of(context)!.locationPermissionNeededDis,
//         style: appStyles.s14w400Grey,
//       ),
//       actions: [
//         AppButton(
//           onPressed: () async {
//             Navigator.of(context).pop();
//             await Geolocator.openLocationSettings(); //
//           },
//           text: appStrings.openSettings,
//         ),
//       ],
//     ),
//   );
// }
//
// /// Generic snackbar helper
// void _showSnackBar(BuildContext context, String message) {
//   if (!context.mounted) return;
//
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: AppText(message, style: AppStyles.of(context).s14w400Grey),
//     ),
//   );
// }
//
// Future<String?> getCityFromPosition(Position position) async {
//   try {
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//       position.latitude,
//       position.longitude,
//     );
//
//     if (placemarks.isNotEmpty) {
//       Placemark place = placemarks.first;
//       return place.locality.toString();
//     }
//   } catch (e) {
//     print('Error getting city $e');
//   }
//   return 'Error getting city';
// }
