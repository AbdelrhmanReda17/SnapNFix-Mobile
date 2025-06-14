import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceInfoService {
  String deviceId;
  String deviceName;
  String deviceType;
  String platform;
  String? fcmToken; // Add FCM token

  DeviceInfoService({
    required this.deviceId,
    required this.deviceName,
    required this.deviceType,
    required this.platform,
    this.fcmToken, // Add FCM token parameter
  });

  Future<void> initializeDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
      deviceName = androidInfo.model;
      deviceType = 'Android';
      platform = 'Android';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor!;
      deviceName = iosInfo.name;
      deviceType = 'iOS';
      platform = 'iOS';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  /// Update FCM token
  void updateFCMToken(String? newToken) {
    fcmToken = newToken;
  }
}
