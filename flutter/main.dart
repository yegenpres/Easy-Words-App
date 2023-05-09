import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:wordsapp/config.dart';
import 'package:wordsapp/cupertino_aplication.dart';
import 'package:wordsapp/features/notifications/notifications.dart';
import 'package:wordsapp/features/subscription/purchase_api.dart';
import 'package:wordsapp/features/user/user_controller.dart';
import 'package:wordsapp/features/word/word.dart';
import 'package:wordsapp/firebase_options.dart';
import 'package:wordsapp/material_aplication.dart';
import 'package:wordsapp/state_config.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';


Future initDB() async {
  await Hive.initFlutter();

  Hive.registerAdapter(WordAdapter());
  Hive.openBox<bool>(HiveBoxes.isFirstLaunch.name);
  await Hive.openLazyBox(HiveBoxes.imagesBox.name);
  await Hive.openBox<Word>(HiveBoxes.ownWordsBox.name);
  await Hive.openBox(HiveBoxes.ownWordsSearch.name);

  await Hive.openBox<Word>(HiveBoxes.wordBox.name);
  await Hive.openBox(HiveBoxes.searchKeshBox.name);

  await Hive.openBox(HiveBoxes.userBox.name);
  await Hive.openBox(HiveBoxes.sessionBox.name);

  return;
}

Future initServices({required bool isDebug}) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance;

  await PurchaseApi.init(isDebug: isDebug);
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }
}

void main() {
  if (kReleaseMode) {
    releaseRun();
  } else {
    debugRun();
  }
}

void debugRun() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDB();
  await initServices(isDebug: true);

  runApp(
    RestartWidget(
      builder: (BuildContext context) {
        return Phoenix(
          child: DevicePreview(
            enabled: false,
            builder: (context) {
              initProviders(context);

              return ProviderScope(
                observers: [Logger()],
                child: const MyApp(),
              );
            },
          ),
        );
      },
    ),
  );
}

void releaseRun() async {
  Isolate.current
      .addErrorListener(RawReceivePort((List<StackTrace?> pair) async {
    final List<StackTrace?> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
    );
  }).sendPort);

  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initDB();
    await initServices(isDebug: false);

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(
      RestartWidget(
        builder: (BuildContext context) {
          initProviders(context);
          return Phoenix(
            child: const ProviderScope(
              child: MyApp(),
            ),
          );
        },
      ),
    );
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {

  void checkSubscription() async {
    final hasAccess = await PurchaseApi.hasAccess();

    ref
        .read(UserController.stateProvider.notifier)
        .set(isSubscribed: hasAccess);
  }

  @override
  void initState() {
    checkSubscription();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Notifications.init(context);
    Notifications.initDailyRemainder(
      title: "Easy words",
      body: "Lets repeat a few words \u{1F601}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Platform.isIOS
            ? const CupertinoApplication()
            : const MaterialApplication();
        // : const CupertinoApplication();
      },
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? const AppCupertino() : const AppMaterial();
  }
}

class RestartWidget extends StatefulWidget {
  final Widget Function(BuildContext) builder;

  const RestartWidget({super.key, required this.builder});

  static void restartApp(BuildContext context) {
    context.findRootAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.builder(context),
    );
  }
}
