import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final String? message;
  @JsonKey(name: 'errorList')
  final dynamic errors;

  ApiErrorModel({this.message, this.errors});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
  
  String getAllErrorMessages() {
    log("Message: $message");
    log("Error List: $errors");

    // Return just the message if errors is null or empty
    if (errors == null) {
      return message ?? "Unknown Error occurred";
    }

    // Handle List of Maps with propertyName and message
    if (errors is List) {
      final errorsList = errors as List;
      if (errorsList.isEmpty) {
        return message ?? "Unknown Error occurred";
      }

      // Check if the list contains maps with propertyName and message
      if (errorsList.first is Map) {
        return errorsList
            .map((error) {
              if (error is Map) {
                // Access propertyName and message safely
                final propertyName = error['propertyName']?.toString() ?? '';
                final errorMessage = error['message']?.toString() ?? '';
                return errorMessage;
              }
              return error.toString();
            })
            .join('\n');
      }

      // Simple list of strings or values
      return errorsList.join('\n');
    }

    // Handle Map structure
    if (errors is Map<String, dynamic>) {
      final errorMessage = (errors as Map<String, dynamic>).entries
          .map((entry) {
            final value = entry.value;
            if (value is List) {
              return value.join(',');
            }
            return value.toString();
          })
          .join('\n');

      return errorMessage;
    }

    // Fallback to default message
    return message ?? "Unknown Error occurred";
  }
}
