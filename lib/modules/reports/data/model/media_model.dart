import 'package:json_annotation/json_annotation.dart';
import 'package:snapnfix/modules/reports/domain/entities/media.dart';

part 'media_model.g.dart';

@JsonSerializable()
class MediaModel extends Media {
  const MediaModel({
    required super.image,
    super.category,
    super.threshold,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return _$MediaModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MediaModelToJson(this);

  MediaModel copyWith({
    String? image,
    String? category,
    double? threshold,
  }) {
    return MediaModel(
      image: image ?? this.image,
      category: category ?? this.category,
      threshold: threshold ?? this.threshold,
    );
  }
}
