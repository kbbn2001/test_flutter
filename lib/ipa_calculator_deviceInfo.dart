import 'dart:async';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  static Future<dynamic> getAndroidId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo info = await deviceInfo.androidInfo;
    return info.androidId;
  }
}