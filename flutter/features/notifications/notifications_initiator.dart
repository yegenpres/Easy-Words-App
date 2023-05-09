part of "notifications.dart";

abstract class _NotificationsInitiator {
  static BuildContext? context;

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  static const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  static const LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  static const InitializationSettings initializationSettings =
      InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
          linux: initializationSettingsLinux);

  static init(BuildContext ctx) async {
    if (context != null) return;
    context = ctx;

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
    _initIosMackOs();
    _initAndroid();

    _initTimeZone();
  }

  static _initTimeZone() async {
    try {
      tz.initializeTimeZones();
      final String timeZoneName =
          await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      l.e(e);
    }
  }

  static _initAndroid() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  static _initIosMackOs() {
    if (Platform.isIOS) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
    if (Platform.isMacOS) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  static void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title ?? ""),
        content: Text(body ?? ""),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            isDestructiveAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              lv6("onDidReceiveLocalNotification");
            },
          )
        ],
      ),
    );
  }

  static void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      lv6('notification payload: $payload');
    }
    lv6(notificationResponse.toString());
  }
}
