import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/networking/api_constants.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/core/infrastructure/networking/dio_factory.dart';

@module
abstract class RegisterModule {
  @singleton
  Dio get dio => DioFactory.getDio();

  @singleton
  ApiService get apiService => ApiService(dio, baseUrl: ApiConstants.apiBaseUrl);
} 