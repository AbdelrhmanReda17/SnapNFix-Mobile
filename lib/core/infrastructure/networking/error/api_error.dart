class ApiError {
  final String message;
  final List<String> details;
  final String? code;
  final int? statusCode;

  const ApiError({
    required this.message,
    this.details = const [],
    this.code,
    this.statusCode,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      message: json['message'] as String? ?? 'Unknown error occurred',
      details: _parseErrorDetails(json['errorList']),
      code: json['code'] as String?,
      statusCode: json['statusCode'] as int?,
    );
  }

  static List<String> _parseErrorDetails(dynamic errors) {
    if (errors == null) return [];

    if (errors is List) {
      return errors
          .map((error) => _extractErrorMessage(error))
          .where((message) => message.isNotEmpty)
          .toList();
    }

    if (errors is Map<String, dynamic>) {
      return errors.entries
          .expand((entry) => _parseMapValue(entry.value))
          .where((message) => message.isNotEmpty)
          .toList();
    }

    return [errors.toString()];
  }

  static String _extractErrorMessage(dynamic error) {
    if (error is Map && error.containsKey('message')) {
      return error['message']?.toString() ?? '';
    }
    return error?.toString() ?? '';
  }

  static List<String> _parseMapValue(dynamic value) {
    if (value is List) {
      return value.map((v) => v.toString()).toList();
    }
    return [value.toString()];
  }

  String get fullMessage {
    if (details.isEmpty) return message;
    return 'Details: ${details.join('\n')}';
  }

  @override
  String toString() => fullMessage;
}
