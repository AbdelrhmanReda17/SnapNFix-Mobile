import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageBuilder {
  /// Checks if an image path is valid
  /// Returns true for valid remote URLs
  static bool isValidImagePath(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return false;
    return _isNetworkUrl(imagePath);
  }

  /// Builds the appropriate image widget based on the image name/path
  /// [imageName] can be a URL
  /// [fit] determines how the image should be displayed (e.g. BoxFit.cover)
  /// [colorScheme] is used for styling the error placeholder
  static Widget buildImage({
    required String? imageName,
    required BoxFit fit,
    required ColorScheme colorScheme,
    Widget Function(BuildContext, ColorScheme)? errorBuilder,
    Widget Function(ColorScheme)? loadingBuilder,
    double? width,
    double? height,
  }) {
    // Handle null or empty image path
    if (imageName == null || imageName.isEmpty) {
      return Builder(
        builder:
            (context) => _buildErrorWidget(context, colorScheme, errorBuilder),
      );
    }

    // Check if the image is a network URL
    if (_isNetworkUrl(imageName)) {
      return _buildNetworkImage(
        imageName,
        fit,
        colorScheme,
        errorBuilder,
        loadingBuilder,
        width,
        height,
      );
    }

    // Fallback to error widget for unrecognized paths
    return Builder(
      builder:
          (context) => _buildErrorWidget(context, colorScheme, errorBuilder),
    );
  }

  // Helper methods for better organization
  static bool _isNetworkUrl(String path) {
    return path.startsWith('http://') || path.startsWith('https://');
  }

  static Widget _buildNetworkImage(
    String imageUrl,
    BoxFit fit,
    ColorScheme colorScheme,
    Widget Function(BuildContext, ColorScheme)? errorBuilder,
    Widget Function(ColorScheme)? loadingBuilder,
    double? width,
    double? height,
  ) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder:
          (context, url) =>
              loadingBuilder?.call(colorScheme) ??
              _defaultLoadingPlaceholder(colorScheme),
      errorWidget: (context, url, error) {
        debugPrint('Network image error: $error');
        if (_isNetworkError(error)) {
          return _buildNetworkErrorWidget(context, colorScheme, errorBuilder);
        }
        return _buildErrorWidget(context, colorScheme, errorBuilder);
      },
    );
  }

  static Widget _defaultLoadingPlaceholder(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.surfaceContainerHighest,
      child: Center(
        child: CircularProgressIndicator(
          color: colorScheme.primary,
          strokeWidth: 2,
        ),
      ),
    );
  }

  static Widget _defaultErrorPlaceholder(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.primary.withValues(alpha: 0.05),
      child: Center(
        child: Icon(Icons.broken_image, color: colorScheme.primary),
      ),
    );
  }

  static Widget _defaultNetworkErrorPlaceholder(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    return Container(
      color: colorScheme.primary.withValues(alpha: 0.05),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_wifi_off,
              color: colorScheme.onSurfaceVariant,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              AppLocalizations.of(context)!.networkError,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildErrorWidget(
    BuildContext context,
    ColorScheme colorScheme,
    Widget Function(BuildContext, ColorScheme)? customBuilder,
  ) {
    return customBuilder?.call(context, colorScheme) ??
        _defaultErrorPlaceholder(colorScheme);
  }

  static Widget _buildNetworkErrorWidget(
    BuildContext context,
    ColorScheme colorScheme,
    Widget Function(BuildContext, ColorScheme)? customBuilder,
  ) {
    return customBuilder?.call(context, colorScheme) ??
        _defaultNetworkErrorPlaceholder(context, colorScheme);
  }

  static bool _isNetworkError(Object error) {
    return error is SocketException ||
        error is HttpException ||
        error.toString().contains('SocketException') ||
        error.toString().contains('ClientException') ||
        error.toString().contains('Failed host lookup') ||
        error.toString().contains('No address associated with hostname');
  }
}
