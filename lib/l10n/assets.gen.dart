/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// Directory path: assets/icons/active
  $AssetsIconsActiveGen get active => const $AssetsIconsActiveGen();

  /// File path: assets/icons/favicon.ico
  String get favicon => 'assets/icons/favicon.ico';

  /// File path: assets/icons/home.svg
  String get home => 'assets/icons/home.svg';

  /// File path: assets/icons/map.svg
  String get map => 'assets/icons/map.svg';

  /// File path: assets/icons/settings.svg
  String get settings => 'assets/icons/settings.svg';

  /// File path: assets/icons/user_reports.svg
  String get userReports => 'assets/icons/user_reports.svg';

  /// List of all assets
  List<String> get values => [favicon, home, map, settings, userReports];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/SNF.png
  AssetGenImage get snf => const AssetGenImage('assets/images/SNF.png');

  /// File path: assets/images/SnapNFix.png
  AssetGenImage get snapNFix =>
      const AssetGenImage('assets/images/SnapNFix.png');

  /// File path: assets/images/facebook_icon.png
  AssetGenImage get facebookIcon =>
      const AssetGenImage('assets/images/facebook_icon.png');

  /// File path: assets/images/google_icon.png
  AssetGenImage get googleIcon =>
      const AssetGenImage('assets/images/google_icon.png');

  /// File path: assets/images/onboarding-1.png
  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/images/onboarding-1.png');

  /// File path: assets/images/onboarding-2.png
  AssetGenImage get onboarding2 =>
      const AssetGenImage('assets/images/onboarding-2.png');

  /// File path: assets/images/onboarding-3.png
  AssetGenImage get onboarding3 =>
      const AssetGenImage('assets/images/onboarding-3.png');

  /// File path: assets/images/splashFrame.png
  AssetGenImage get splashFrame =>
      const AssetGenImage('assets/images/splashFrame.png');

  /// File path: assets/images/text.png
  AssetGenImage get text => const AssetGenImage('assets/images/text.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    snf,
    snapNFix,
    facebookIcon,
    googleIcon,
    onboarding1,
    onboarding2,
    onboarding3,
    splashFrame,
    text,
  ];
}

class $AssetsIconsActiveGen {
  const $AssetsIconsActiveGen();

  /// File path: assets/icons/active/home.svg
  String get home => 'assets/icons/active/home.svg';

  /// File path: assets/icons/active/map.svg
  String get map => 'assets/icons/active/map.svg';

  /// File path: assets/icons/active/settings.svg
  String get settings => 'assets/icons/active/settings.svg';

  /// File path: assets/icons/active/user_reports.svg
  String get userReports => 'assets/icons/active/user_reports.svg';

  /// List of all assets
  List<String> get values => [home, map, settings, userReports];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
