import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordsapp/features/subscription/purchase_api.dart';
import 'package:wordsapp/features/subscription/sudscription_widget.dart';
import 'package:wordsapp/features/user/user_controller.dart';
import 'package:wordsapp/main.dart';
import 'package:wordsapp/router.dart';
import 'package:wordsapp/view_model/subscription_state.dart';

class SubscriptionPage extends ConsumerWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (kDebugMode)
              ElevatedButton(
                onPressed: () {
                  testSudscribe(ref);
                  context.go(Routes.home.name);
                  RestartWidget.restartApp(context);
                },
                child: const Text("test subscribe"),
              ),
            SubscriptionWidget(
              onSubscribeCallback: (isSubscribed) {
                ref
                    .read(UserController.stateProvider.notifier)
                    .set(isSubscribed: isSubscribed);

                final userId = ref.read(UserController.stateProvider).id;
                assert(userId != null, "user id on purchase log in is null");
                PurchaseApi.logIn(userId!);

                if (isSubscribed) context.go(Routes.home.name);
                RestartWidget.restartApp(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
