import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  final T data;
  final String message;
  @JsonKey(name: 'errorList')
  final List<String> errors;

  const BaseResponse({
    required this.data,
    required this.message,
    required this.errors,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    debugPrint("ana hread mn hna " + json.toString());
    return _$BaseResponseFromJson(json, fromJsonT);
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}
