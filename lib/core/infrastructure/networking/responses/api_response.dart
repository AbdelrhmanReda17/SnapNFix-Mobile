import 'package:json_annotation/json_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final T? data;
  final String message;
  final bool success;
  final List<String> errors;

  const ApiResponse({
    this.data,
    required this.message,
    required this.success,
    this.errors = const [],
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?)? fromJsonT,
  ) {
    return ApiResponse<T>(
      data:
          fromJsonT != null && json['data'] != null
              ? fromJsonT(json['data'])
              : null,
      message: json['message'] as String? ?? '',
      success: json['success'] as bool? ?? true,
      errors:
          (json['errorList'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  bool get hasError => !success || errors.isNotEmpty;

  ApiError? get error =>
      hasError ? ApiError(message: message, details: errors) : null;
}
