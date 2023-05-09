import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordsapp/router.dart';
import 'package:wordsapp/view/my_words/page_progress_list.dart';
import 'package:wordsapp/view/own/create_own_word.dart';
import 'package:wordsapp/view/today/main_today.dart';
import 'package:wordsapp/view_model/debuging_features/show_debuging_actions.dart'
    as debuging;
import 'package:wordsapp/view_model/navigation.dart';

import 'generated/l10n.dart';

class MaterialApplication extends ConsumerWidget {
  const MaterialApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      useInheritedMediaQuery: kDebugMode ? true : false,
      locale: kDebugMode ? DevicePreview.locale(context) : null,
      themeMode: ThemeMode.system,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

class AppMaterial extends ConsumerStatefulWidget {
  const AppMaterial({Key? key}) : super(key: key);

  @override
  ConsumerState<AppMaterial> createState() => _AppMaterial();
}

class _AppMaterial extends ConsumerState<AppMaterial> {
  Routes? route;

  int _currentIndex = 0;

  final List<Widget> _scrins = [
    const Today(),
    const CreateOwnPage(),
    const ProgressList()
  ];

  @override
  Widget build(BuildContext context) {
    final today = S.of(context).Today;
    final progress = S.of(context).Progress;
    final create = S.of(context).Create;

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
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: today, tooltip: today),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onLongPress: () => debuging.shodDebugActions(ref, context),
                  child: const Icon(Icons.add)),
              label: create,
              tooltip: create),
          BottomNavigationBarItem(
              icon: const Icon(Icons.list), label: progress, tooltip: progress),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _scrins,
      ),
    );
  }
}
