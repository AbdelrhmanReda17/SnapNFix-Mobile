import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<Map<String, String>> getDeviceInfo() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return {
        'deviceId': androidInfo.id,
        'deviceName': androidInfo.model,
        'deviceType': 'Android',
        'platform': 'Android ${androidInfo.version.release}',
      };
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return {
        'deviceId': iosInfo.identifierForVendor ?? '',
        'deviceName': iosInfo.name,
        'deviceType': 'iOS',
        'platform': '${iosInfo.systemName} ${iosInfo.systemVersion}',
      };
    }
    return {
      'deviceId': 'unknown',
      'deviceName': 'unknown',
      'deviceType': 'unknown',
      'platform': 'unknown',
    };
  }
}