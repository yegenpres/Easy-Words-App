import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:l/l.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:wordsapp/view_model/debuging_features/logger.dart';

part 'notifications_initiator.dart';

class Notifications extends _NotificationsInitiator {
  static init(BuildContext ctx) => _NotificationsInitiator.init(ctx);

  static sendNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _NotificationsInitiator.flutterLocalNotificationsPlugin
        .show(id, title, body, notificationDetails, payload: 'item x');
  }

  static sendSchedulerNotifications({
    required int id,
    required String title,
    required String body,
    required Duration fromNaw,
  }) async {
    await _NotificationsInitiator.flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(
        fromNaw,
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static setPeriodicNotification({
    required int id,
    required String title,
    required String body,
    required RepeatInterval interval,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'repeating channel id', 'repeating channel name',
            channelDescription: 'repeating description');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _NotificationsInitiator.flutterLocalNotificationsPlugin
        .periodicallyShow(
      id,
      title,
      body,
      interval,
      notificationDetails,
      androidAllowWhileIdle: true,
    );
  }

  static initDailyRemainder(
      {required String title, required String body}) async {
    setPeriodicNotification(
      id: 17112022,
      title: title,
      body: body,
      interval: RepeatInterval.daily,
    );
  }

  static cancelAll() async {
    await _NotificationsInitiator.flutterLocalNotificationsPlugin.cancelAll();
  }

  static cancel(int id) async {
    await _NotificationsInitiator.flutterLocalNotificationsPlugin.cancel(id);
  }
}
