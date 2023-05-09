import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordsapp/features/user/user_controller.dart';
import 'package:wordsapp/router.dart';
import 'package:wordsapp/view/my_words/page_progress_list.dart';
import 'package:wordsapp/view/own/create_own_word.dart';
import 'package:wordsapp/view/today/main_today.dart';
import 'package:wordsapp/view_model/debuging_features/show_debuging_actions.dart'
    as debuging;
import 'package:wordsapp/view_model/navigation.dart';

import 'generated/l10n.dart';

class CupertinoApplication extends ConsumerWidget {
  const CupertinoApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MediaQuery.fromWindow(
      child: CupertinoApp.router(
        useInheritedMediaQuery: true,
        locale: kDebugMode ? DevicePreview.locale(context) : null,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: CupertinoThemeData(
          primaryColor: const CupertinoDynamicColor.withBrightness(
            color: CupertinoColors.activeBlue,
            darkColor: CupertinoColors.systemOrange,
          ),
          primaryContrastingColor: const CupertinoDynamicColor.withBrightness(
            color: CupertinoColors.secondarySystemGroupedBackground,
            darkColor: CupertinoColors.darkBackgroundGray,
          ),
          barBackgroundColor: CupertinoDynamicColor.withBrightness(
            color: CupertinoColors.lightBackgroundGray.withOpacity(0.8),
            darkColor: CupertinoColors.black.withOpacity(0.8),
          ),
          scaffoldBackgroundColor: const CupertinoDynamicColor.withBrightness(
            color: CupertinoColors.lightBackgroundGray,
            darkColor: CupertinoColors.black,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}

class AppCupertino extends ConsumerStatefulWidget {
  const AppCupertino({Key? key}) : super(key: key);

  @override
  ConsumerState<AppCupertino> createState() => _AppCupertinoState();
}

final test = Provider<bool>((ref) {
  return ref.watch(UserController.stateProvider).isSubscribed;
});

class _AppCupertinoState extends ConsumerState<AppCupertino> {
  Routes? route;

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      final provider = ref.watch(AppNavigation.state);
      provider.when(
        loading: () {},
        error: (err, stack) => {},
        data: (newRout) {
          if (route != newRout) {
            route = newRout;
            context.go(route!.name);
          }
        },
      );
    });

    final today = S.of(context).Today;
    final progress = S.of(context).Progress;
    final create = S.of(context).Create;

    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.book),
              label: today,
            ),
            BottomNavigationBarItem(
              icon: Material(
                color: Colors.transparent,
                child: GestureDetector(
                    onLongPress: () => debuging.shodDebugActions(ref, context),
                    child: const Icon(CupertinoIcons.add_circled)),
              ),
              label: create,
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.archivebox),
              label: progress,
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              switch (index) {
                case 0:
                  return const SafeArea(
                    top: false,
                    bottom: false,
                    child: CupertinoPageScaffold(
                      child: Center(
                        child: Today(),
                      ),
                    ),
                  );
                case 1:
                  return const SafeArea(
                    top: false,
                    bottom: false,
                    child: CupertinoPageScaffold(
                      child: Center(
                        child: CreateOwnPage(),
                      ),
                    ),
                  );
                default:
                  return const SafeArea(
                    top: false,
                    bottom: false,
                    child: CupertinoPageScaffold(
                      child: Center(
                        child: ProgressList(),
                      ),
                    ),
                  );
              }
            },
          );
        });
  }
}
