import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snapnfix/l10n/assets.gen.dart';

class ImageBuilder {
  /// Checks if an image path is valid
  /// Returns true for valid remote URLs or existing local files
  static bool isValidImagePath(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return false;
    
    // Remote URLs are considered valid
    if (_isNetworkUrl(imagePath)) {
      return true;
    }
    
    // Check if the file exists locally
    return _isValidLocalFile(imagePath);
  }
  
  /// Builds the appropriate image widget based on the image name/path
  /// [imageName] can be a URL, local file path, or asset path
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
        builder: (context) => _buildErrorWidget(context, colorScheme, errorBuilder),
      );
    }

    // Check if the image is a network URL
    if (_isNetworkUrl(imageName)) {
      return _buildNetworkImage(
        imageName, fit, colorScheme, errorBuilder, loadingBuilder, width, height
      );
    }

    // For local files
    if (_shouldTreatAsLocalFile(imageName)) {
      return _buildLocalFileImage(
        imageName, fit, colorScheme, errorBuilder, width, height
      );
    }

    // Fallback to error widget for unrecognized paths
    return Builder(
      builder: (context) => _buildErrorWidget(context, colorScheme, errorBuilder),
    );
  }

  // Helper methods for better organization
  static bool _isNetworkUrl(String path) {
    return path.startsWith('http://') || path.startsWith('https://');
  }

  static bool _isValidLocalFile(String path) {
    try {
      final file = File(path);
      return file.existsSync();
    } catch (e) {
      return false;
    }
  }

  static bool _shouldTreatAsLocalFile(String path) {
    return path.contains('/') || _isValidLocalFile(path);
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
      placeholder: (context, url) => loadingBuilder?.call(colorScheme) ?? 
                   _defaultLoadingPlaceholder(colorScheme),
      errorWidget: (context, url, error) => 
                   _buildErrorWidget(context, colorScheme, errorBuilder),
    );
  }

  static Widget _buildLocalFileImage(
    String imagePath,
    BoxFit fit,
    ColorScheme colorScheme,
    Widget Function(BuildContext, ColorScheme)? errorBuilder,
    double? width,
    double? height,
  ) {
    try {
      final file = File(imagePath);
      if (file.existsSync()) {
        return Image.file(
          file,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) => 
            _buildErrorWidget(context, colorScheme, errorBuilder),
        );
      }
    } catch (e) {
      // Fall through to error widget
    }
    
    return Builder(
      builder: (context) => _buildErrorWidget(context, colorScheme, errorBuilder),
    );
  }

  /// Default loading placeholder
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

  /// Default error placeholder to show when an image fails to load
  static Widget _defaultErrorPlaceholder(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.primary.withValues(alpha: 0.05),
      child: Center(
        child: Icon(Icons.broken_image, color: colorScheme.primary),
      ),
    );
  }

  static Widget _buildErrorWidget(
    BuildContext context, 
    ColorScheme colorScheme, 
    Widget Function(BuildContext, ColorScheme)? customBuilder
  ) {
    return customBuilder?.call(context, colorScheme) ?? 
           _defaultErrorPlaceholder(colorScheme);
  }
}
