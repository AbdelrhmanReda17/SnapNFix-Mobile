import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snapnfix/l10n/assets.gen.dart';

class ImageBuilder {
  /// Checks if an image path is valid
  /// Returns true for valid remote URLs, asset references, or existing local files
  static bool isValidImagePath(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return false;
    
    // Remote URLs are considered valid
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return true;
    }
    
    // Check if it's a known asset
    if (imagePath == "issue1.jpg" || 
        imagePath == "issue2.jpg" || 
        imagePath == "issue3.jpg") {
      return true;
    }

    // Check if the file exists locally
    try {
      final file = File(imagePath);
      return file.existsSync();
    } catch (e) {
      return false;
    }
  }
  
  /// Builds the appropriate image widget based on the image name/path
  /// [imageName] can be a URL or a local asset name (e.g. "issue1.jpg")
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
        builder: (context) {
          return errorBuilder != null
              ? errorBuilder(context, colorScheme)
              : _defaultErrorPlaceholder(colorScheme);
        },
      );
    }

    // Check if the image is a URL
    if (imageName.startsWith('http://') || imageName.startsWith('https://')) {
      return CachedNetworkImage(
        imageUrl: imageName,
        fit: fit,
        width: width,
        height: height,
        placeholder:
            (context, url) =>
                loadingBuilder != null
                    ? loadingBuilder(colorScheme)
                    : _defaultLoadingPlaceholder(colorScheme),
        errorWidget:
            (context, url, error) => Builder(
              builder: (context) {
                return errorBuilder != null
                    ? errorBuilder(context, colorScheme)
                    : _defaultErrorPlaceholder(colorScheme);
              },
            ),
      );
    }

    // For local files that aren't assets
    if (imageName.contains('/')) {
      try {
        final file = File(imageName);
        if (file.existsSync()) {
          return Image.file(
            file,
            fit: fit,
            width: width,
            height: height,
            errorBuilder: (context, error, stackTrace) => 
              errorBuilder != null
                ? errorBuilder(context, colorScheme)
                : _defaultErrorPlaceholder(colorScheme),
          );
        }
      } catch (e) {
        return Builder(
          builder: (context) {
            return errorBuilder != null
                ? errorBuilder(context, colorScheme)
                : _defaultErrorPlaceholder(colorScheme);
          },
        );
      }
    }

    // Otherwise use the generated asset images
    switch (imageName) {
      case "issue1.jpg":
        return Assets.images.issue1.image(
          fit: fit,
          width: width,
          height: height,
        );
      case "issue2.jpg":
        return Assets.images.issue2.image(
          fit: fit,
          width: width,
          height: height,
        );
      case "issue3.jpg":
        return Assets.images.issue3.image(
          fit: fit,
          width: width,
          height: height,
        );
      default:
        return Builder(
          builder: (context) {
            return errorBuilder != null
                ? errorBuilder(context, colorScheme)
                : _defaultErrorPlaceholder(colorScheme);
          },
        );
    }
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
}
