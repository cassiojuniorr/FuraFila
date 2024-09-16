import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:device_info_plus/device_info_plus.dart';

Future<String> checkDevice() async {
  if (kIsWeb) {
    print("O aplicativo está rodando na Web.");
    return "web";
  } else {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print('Rodando em um dispositivo Android: ${androidInfo.model}');
        return "android";
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        print('Rodando em um dispositivo iOS: ${iosInfo.utsname.machine}');
        return "ios";
      } else if (defaultTargetPlatform == TargetPlatform.windows) {
        WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
        print('Rodando em um dispositivo Windows: ${windowsInfo.computerName}');
        return "windows";
      } else if (defaultTargetPlatform == TargetPlatform.linux) {
        LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
        print('Rodando em um dispositivo Linux: ${linuxInfo.name}');
        return "linux";
      } else if (defaultTargetPlatform == TargetPlatform.macOS) {
        MacOsDeviceInfo macInfo = await deviceInfo.macOsInfo;
        print('Rodando em um MacOS: ${macInfo.model}');
        return "mac";
      }
    } catch (e) {
      print("Erro ao identificar o dispositivo: $e");
      return "unknown";
    }
  }
  return "unknown";
}
