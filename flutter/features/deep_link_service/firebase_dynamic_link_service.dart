import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';

const _token = "id";

class FirebaseDynamicLincService {
  static Future<String> createDynamicLink(String token) async {
    final pcgInfo = await PackageInfo.fromPlatform();
    lv6("pcgInfo.packageName ${pcgInfo.packageName}");

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      link: Uri.parse("https://www.wordsapp.com/id?$_token=$token"),
      uriPrefix: "https://wordsapp.page.link",
      androidParameters: AndroidParameters(
        packageName: pcgInfo.packageName,
        // packageName: "com.yevheniiappsyegenpress.wordsapp",
      ),
      iosParameters: IOSParameters(
        bundleId: pcgInfo.packageName,
        // bundleId: "com.yevheniiappsyegenpress.wordsapp",
        appStoreId: "1619003625",
      ),
    );

    final Uri shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(parameters);
    return shortDynamicLink.toString();
  }

  static Future _initTermiatedHandler({
    required Function(String? token) onInit,
  }) async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final userId = initialLink?.link.queryParameters[_token];
    onInit(userId);
  }

  static void _initBackgroundHandler({
    required Function(String? token) onLink,
    required Function(Error) onError,
  }) {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final userId = dynamicLinkData.link.queryParameters[_token];
      onLink(userId);
    }).onError((error) {
      onError(error);
    });
  }

  static Future initHandlers({
    required Function(String? token) onInit,
    required Function(String? token) onLink,
    required Function(Error) onError,
  }) async {
    await _initTermiatedHandler(onInit: onInit);
    _initBackgroundHandler(onError: onError, onLink: onLink);
  }
}
