import 'package:equatable/equatable.dart';

class Media extends Equatable {
  final String image;
  final String? category;
  final double? threshold;

  const Media({required this.image, this.category, this.threshold});

  @override
  List<Object?> get props => [image, category, threshold];
}
