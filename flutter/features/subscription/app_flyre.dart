import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:wordsapp/.variables.dart';
import 'package:wordsapp/extensions.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';

class AppFlyreAnalytic {
  late final AppsflyerSdk sdk;

  AppFlyreAnalytic({required bool isDebug}) {
    AppsFlyerOptions opt = platformSelector(material: () {
      return AppsFlyerOptions(
        afDevKey: appFlyerANdriodKey,
        showDebug: isDebug,
        timeToWaitForATTUserAuthorization: 50,
      );
    }, cupertino: () {
      return AppsFlyerOptions(
        afDevKey: appFlyerIosKey,
        appId: appId,
        showDebug: isDebug,
        timeToWaitForATTUserAuthorization: 50,
      );
    })();

    sdk = AppsflyerSdk(opt);
    sdk.initSdk();
  }

  void logEvent(String eventName) async {
    bool? result;
    try {
      result = await sdk.logEvent(eventName, null);
    } on Exception catch (e) {
      lv6(e.toString());
    }
    lv6("Result logEvent: $result");
  }
}
