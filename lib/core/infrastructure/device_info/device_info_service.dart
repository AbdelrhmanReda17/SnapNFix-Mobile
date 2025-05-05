import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<Map<String, dynamic>> withDeviceInfo([Object? baseObject]) async {
    // Get device info
    final deviceInfo = await getDeviceInfo();

    // Create base map from object if provided
    final Map<String, dynamic> result =
        baseObject != null ? _convertToMap(baseObject) : {};

    // Add device info fields
    result['deviceId'] = deviceInfo['deviceId'];
    result['deviceName'] = deviceInfo['deviceName'];
    result['deviceType'] = deviceInfo['deviceType'];
    result['platform'] = deviceInfo['platform'];

    return result;
  }

  Map<String, dynamic> _convertToMap(Object object) {
    // If object already has a toJson method, use it
    if (object is Map<String, dynamic>) {
      return object;
    } else if (object.runtimeType.toString().contains('DTO') ||
        object.runtimeType.toString().contains('Model')) {
      // Try to access toJson method via reflection (if it exists)
      try {
        final toJsonMethod = (object as dynamic).toJson;
        return toJsonMethod();
      } catch (e) {
        // Fall back to default
        return {'data': object.toString()};
      }
    }

    // Default fallback for objects without toJson
    return {'data': object.toString()};
  }

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
