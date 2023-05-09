import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordsapp/_widgets/utils.dart';
import 'package:wordsapp/extensions.dart';
import 'package:wordsapp/features/subscription/paywall_widget.dart';
import 'package:wordsapp/generated/l10n.dart';
import 'package:wordsapp/router.dart';
import 'package:wordsapp/view/privacy_policy.dart';
import 'package:wordsapp/view_model/autetification_state.dart';
import 'package:wordsapp/view_model/profile_state.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(ProfileState.provider).value;
    return adaptivePage(
      appBar: AppBar(
        title: Text(
          S.of(context).profileTitle,
        ),
      ),
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          S.of(context).profileTitle,
        ),
      ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SubscriptionData(
            expiredData: data?.expiredData ?? "Does not subscribed",
          ),
          const PolicyasAndTerms(),
          const RestoreButton(),
        ],
      )),
    );
  }
}

class SubscriptionData extends StatelessWidget {
  final String expiredData;

  const SubscriptionData({super.key, required this.expiredData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        child: Text(
          "${S.of(context).expired_data} $expiredData",
        ),
      ),
    );
  }
}

class FreePeriodDays extends StatelessWidget {
  final int count;

  const FreePeriodDays({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        child: Row(
          children: [const Text("Free days: "), Text(count.toString())],
        ),
      ),
    );
  }
}

class LoginPageButton extends ConsumerWidget {
  const LoginPageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Flexible(
            child: Text(
                "Please log in to save Your progress is safe. Ia allow You return content if app will be deleted")),
        platformSelector(
          material: ElevatedButton(
              onPressed: () {
                context.go(Routes.home.name);
              },
              child: const Text("Log in")),
          cupertino: CupertinoButton(
            child: const Text("Log in"),
            onPressed: () {
              context.go(Routes.login.name);
            },
          ),
        ),
      ],
    );
  }
}

class LogOutButton extends ConsumerWidget {
  final void Function() handler;

  const LogOutButton({Key? key, required this.handler}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return platformSelector(
      material: ElevatedButton(
          onPressed: () {
            ref.read(SignInWithState.logOut)();
          },
          child: const Text("Log out")),
      cupertino: CupertinoButton(
        child: const Text("Log out"),
        onPressed: () {
          ref.read(SignInWithState.logOut)();
        },
      ),
    );
  }
}
