// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImgGen {
  const $AssetsImgGen();

  /// File path: assets/img/img_Sunny.png
  AssetGenImage get imgSunny => const AssetGenImage('assets/img/img_Sunny.png');

  /// File path: assets/img/img_clear.png
  AssetGenImage get imgClear => const AssetGenImage('assets/img/img_clear.png');

  /// File path: assets/img/img_rainy.png
  AssetGenImage get imgRainy => const AssetGenImage('assets/img/img_rainy.png');

  /// File path: assets/img/img_sunClouldWind.png
  AssetGenImage get imgSunClouldWind =>
      const AssetGenImage('assets/img/img_sunClouldWind.png');

  /// File path: assets/img/img_thunder.png
  AssetGenImage get imgThunder =>
      const AssetGenImage('assets/img/img_thunder.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    imgSunny,
    imgClear,
    imgRainy,
    imgSunClouldWind,
    imgThunder,
  ];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/ic_global.svg
  String get icGlobal => 'assets/svg/ic_global.svg';

  /// File path: assets/svg/ic_search.svg
  String get icSearch => 'assets/svg/ic_search.svg';

  /// File path: assets/svg/ic_temperature.svg
  String get icTemperature => 'assets/svg/ic_temperature.svg';

  /// File path: assets/svg/ic_wind.svg
  String get icWind => 'assets/svg/ic_wind.svg';

  /// List of all assets
  List<String> get values => [icGlobal, icSearch, icTemperature, icWind];
}

class Assets {
  const Assets._();

  static const $AssetsImgGen img = $AssetsImgGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
