import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/features/subscription/purchase_api.dart';
import 'package:wordsapp/router.dart';
import 'package:wordsapp/view_model/autetification_state.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';
import 'package:wordsapp/view_model/first_launch.dart';

class AppNavigation {
  static final state = FutureProvider<Routes>((ref) async {
    final isFirsLaunch = ref.watch(FirstLaunchDetector.value);
    if (isFirsLaunch) return Routes.presentation;

    bool isLogedIn = false;
    bool isSubscribed = await PurchaseApi.isSubscribed();

    ref.watch(autentificationAutoAction).maybeMap(
          orElse: () => isLogedIn = false,
          logedIn: (_) => isLogedIn = true,
          registered: (_) => isLogedIn = true,
        );

    if (!isLogedIn) {
      SignInWithState.deviceIdAuthentication(ref);
    }

    if (isSubscribed) return Routes.home;

    return Routes.subscription;
  });
}
