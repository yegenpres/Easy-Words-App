import 'dart:io';

import 'package:wordsapp/config.dart';
import 'package:wordsapp/features/http_client.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';

void setDeviceToken(String token) async {
  String deviceType = "";

  if (Platform.isAndroid) deviceType = "Android";
  if (Platform.isIOS) deviceType = "Ios";
  if (Platform.isLinux) deviceType = "Linux";
  if (Platform.isFuchsia) deviceType = "Fuchsia";
  if (Platform.isMacOS) deviceType = "MacOS";
  if (Platform.isWindows) deviceType = "Windows";

  lv6({"DeviceToken": token, "DeviceType": deviceType}.toString());
  try {
    await NetworkClient.dio.post(ApiHTTP.setDeviceToken,
        data: {"DeviceToken": token, "DeviceType": deviceType});
  } catch (e) {
    lv6(e.toString());
  }
}
