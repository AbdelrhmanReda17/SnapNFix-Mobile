import 'dart:io';

class MediaDTO {
  final File imagePath;
  final String category;
  final double threshold;

  MediaDTO({
    required this.imagePath,
    required this.category,
    required this.threshold,
  });

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'category': category,
      'threshold': threshold,
    };
  }

  factory MediaDTO.fromJson(Map<String, dynamic> json) {
    return MediaDTO(
      imagePath: json['imagePath'],
      category: json['category'],
      threshold: json['threshold'],
    );
  }
}
