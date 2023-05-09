import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:upgrader/upgrader.dart';
import 'package:wordsapp/_widgets/utils.dart';
import 'package:wordsapp/extensions.dart';
import 'package:wordsapp/main.dart';
import 'package:wordsapp/test_for_ads.dart';
import 'package:wordsapp/view/log_in_sign_in/page_autentification.dart';
import 'package:wordsapp/view/log_in_sign_in/page_registration.dart';
import 'package:wordsapp/view/log_in_sign_in/presentation_widget.dart';
import 'package:wordsapp/view/profile_page.dart';
import 'package:wordsapp/view/subscription/subscription_page.dart';
import 'package:wordsapp/view_model/debuging_features/show_debuging_actions.dart';

enum Routes {
  home,
  profile,
  subscription,
  registration,
  debuging,
  resetPassword,
  privacyPolicy,
  presentation,
  termsOfUse,
  login;

  String get name {
    switch (this) {
      case Routes.home:
        return '/';
      case Routes.presentation:
        return '/presentation';
      case Routes.profile:
        return '/profile';
      case Routes.subscription:
        return '/subscription';
      case Routes.registration:
        return '/login/registration';
      case Routes.login:
        return '/login';

      case Routes.debuging:
        return '/debuging';
      case Routes.resetPassword:
        return '/login/resetPassword';
      case Routes.privacyPolicy:
        return '/privacyPolicy';
      case Routes.termsOfUse:
        return '/termsOfUse';
    }
  }
}

// GoRouter configuration
final router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => UpgradeAlert(
        upgrader: Upgrader(
          dialogStyle: platformSelector(
            material: UpgradeDialogStyle.material,
            cupertino: UpgradeDialogStyle.cupertino,
          ),
          debugDisplayAlways: kDebugMode,
        ),
        child: const App(),
      ),
      routes: [
        GoRoute(
          path: "profile",
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: "presentation",
          builder: (context, state) => WillPopScope(
            onWillPop: () async => false,
            child: const PresentationWidget(),
          ),
        ),
        GoRoute(
          path: "login",
          builder: (context, state) => adaptivePage(
            child: const PageAutentification(),
          ),
          routes: [
            GoRoute(
              path: 'registration',
              builder: (context, state) => adaptivePage(
                child: const PageRegistration(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'subscription',
          builder: (context, state) => adaptivePage(
            child: WillPopScope(
                onWillPop: () async => false, child: const SubscriptionPage()),
          ),
        ),
        GoRoute(
          path: 'debug',
          builder: (context, state) => const DebugPage(),
        ),
        GoRoute(
          path: 'ads',
          builder: (context, state) => const TestAds(),
        ),
      ],
    ),
  ],
);
