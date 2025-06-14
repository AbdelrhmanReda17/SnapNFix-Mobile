// Create a new device_info_module.dart
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/device_info/device_info_service.dart';
import 'package:snapnfix/core/infrastructure/messaging/fcm_service.dart';

@module
abstract class DeviceInfoModule {
  @preResolve
  @singleton
  Future<DeviceInfoService> provideDeviceInfoService(
    FCMService fcmService,
  ) async {
    final deviceInfo = DeviceInfoPlugin();

    String deviceId = '';
    String deviceName = '';
    String deviceType = '';
    String platform = '';

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
        deviceName = androidInfo.model;
        deviceType = 'mobile';
        platform = 'android';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? '';
        deviceName = iosInfo.name;
        deviceType = 'mobile';
        platform = 'ios';
      }
    } catch (e) {
      deviceId = 'unknown';
      deviceName = 'unknown';
      deviceType = 'mobile';
      platform = Platform.operatingSystem;
    }

    // Get FCM token once during initialization
    final fcmToken = await fcmService.getCachedToken();

    return DeviceInfoService(
      deviceId: deviceId,
      deviceName: deviceName,
      deviceType: deviceType,
      platform: platform,
      fcmToken: fcmToken,
    );
  }
}
