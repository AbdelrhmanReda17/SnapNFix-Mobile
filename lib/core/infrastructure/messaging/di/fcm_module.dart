import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/messaging/fcm_service.dart';

@module
abstract class FCMModule {
  @singleton
  FCMService provideFCMService() => FCMService();
}