import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:l/l.dart' hide LogLevel;
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wordsapp/features/http_client.dart';
import 'package:wordsapp/features/subscription/app_flyre.dart';
import 'package:wordsapp/features/subscription/exeptions.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';

class PurchaseApi {
  static late final AppFlyreAnalytic _analyticSdk;
  static bool _isInited = false;
  static final _apiKey = Platform.isAndroid
      ? 'goog_ZUzgVjTzlzvhWRmwftYtdpZkbfo'
      : Platform.isIOS
          ? 'appl_cHfEVirFFyrDbSauHDbCDtLCdnW'
          : '';

  static Future<bool> _sendSubscription() async =>
      await NetworkClient.subscriptions.sendSubscription();

  static Future init({bool isDebug = false}) async {
    if (_isInited) {
      return;
    }
    _analyticSdk = AppFlyreAnalytic(isDebug: isDebug);

    await Purchases.setLogLevel(LogLevel.debug);

    final config = PurchasesConfiguration(_apiKey);

    await Purchases.configure(config);

    _isInited = true;
  }

  static Future<List<Offering>> _fetchOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;

      return current == null ? [] : [current];
    } on PlatformException catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<bool> restorePurchase(String appUserID) async {
    try {
      Purchases.logIn(appUserID);

      CustomerInfo customerInfo = await Purchases.restorePurchases();
      return customerInfo.entitlements.active.isNotEmpty;
    } on PlatformException catch (e) {
      lv6(e.toString());
      return false;
    }
  }

  static Future<bool> purchasePackage(Package package) async {
    try {
      await Purchases.purchasePackage(package);
      await _sendSubscription();
      _analyticSdk.logEvent("Subscribed");
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Package>> fetchSubscvription(BuildContext context) async {
    final offering = await _fetchOffers();

    if (offering.isNotEmpty) {
      final packages = offering
          .map((e) => e.availablePackages)
          .expand((pair) => pair)
          .toList();
      return packages;
    }
    return [];
  }

  static Future<String> expiredData() async {
    try {
      CustomerInfo purchaserInfo = await Purchases.getCustomerInfo();
      if (purchaserInfo.entitlements.all.containsKey("Monthly access")) {
        return purchaserInfo
                .entitlements.all["Monthly access"]!.expirationDate ??
            "";
      }

      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<bool> hasAccess() async {
    late bool hasAccess;

    try {
      final subscribed = await isSubscribed();
      lv6("main is subscribed ${subscribed ? "ok" : "no"}");
      hasAccess = subscribed;
    } on NoInternetException {
      return true;
    }

    if (hasAccess) return true;

    return await isFreeAccess();
  }

  static Future<bool> isFreeAccess() async {
    late bool hasAccess;

    try {
      final countFreeDays = await NetworkClient.subscriptions.countFreeDays();

      hasAccess = countFreeDays > 0;
    } catch (e) {
      hasAccess = true;
    }

    return hasAccess;
  }

  static Future<bool> isSubscribed() async {
    try {
      CustomerInfo purchaserInfo = await Purchases.getCustomerInfo();
      l.d(purchaserInfo.toString());
      if (purchaserInfo.entitlements.all.containsKey("Monthly access")) {
        return purchaserInfo.entitlements.all["Monthly access"]!.isActive;
      }

      return false;
    } catch (e) {
      log(e.toString());
      throw NoInternetException(e.toString());
    }
  }

  static Future<LogInResult?> logIn(String id) async {
    try {
      return await Purchases.logIn(id);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

class SubscriptionsDate {
  final String? expiresDate;
  final int? freeDays;

  SubscriptionsDate({this.expiresDate, this.freeDays});
}
