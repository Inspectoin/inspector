import 'dart:convert';
import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';


@injectable
class DeviceInfo {
  late DeviceInfoPlugin deviceInfoPlugin;

  Future<Map<String, dynamic>> getDeviceInfo() async {
    deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      return await _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      return _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }
    return {};
  }



  Future<Map<String, dynamic>> _readAndroidBuildData(
      AndroidDeviceInfo build) async {
    const _androidIdPlugin = AndroidId();

    return <String, dynamic>{
      'device_id': await _androidIdPlugin.getId() ?? 'Unknown ID',
      "operating_system": "Android",
      'device_model_name': build.device,
      'device_brand': build.brand,
    };
  }

  Future<Map<String, dynamic>> _readIosDeviceInfo(IosDeviceInfo data) async {

    var isIpad = await isIOSIpad();

    return <String, dynamic>{
      'device_id': data.identifierForVendor,
      "operating_system": "IOS",
      'device_model_name': data.model,
      'device_brand': isIpad ? "Ipad" : "Iphone",

    };
  }

  Future<bool> isIOSIpad() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo info = await deviceInfo.iosInfo;
    if (info.model.toLowerCase().contains("ipad")) {
      return true;
    }
    return false;
  }

  createFingerPrint() async{

   var fingerPrintData =await  getDeviceInfo();


    // Generate a consistent fingerprint by hashing the device info
    String fingerprint = base64Encode(utf8.encode(jsonEncode(fingerPrintData)));

    return fingerprint;
  }
}
