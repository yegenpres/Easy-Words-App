import 'dart:io';

import 'package:auth_buttons/auth_buttons.dart'
    show AppleAuthButton, GoogleAuthButton, AuthButtonStyle;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/view_model/autetification_state.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';

class WidgetSignInWith extends ConsumerStatefulWidget {
  const WidgetSignInWith({super.key});

  @override
  WidgetSignInWithState createState() => WidgetSignInWithState();
}

class WidgetSignInWithState extends ConsumerState<WidgetSignInWith> {
  bool isLoading = false;
  _handler(BuildContext context, AutentificationState state) => state.maybeMap(
        noLogedIn: (NoLogedIn noLogedIn) {
          setState(() {
            isLoading = false;
          });
        },
        systemError: (SystemError systemError) {
          setState(() {
            isLoading = false;
          });
        },
        errorPasswordOrEmail: (ErrorPasswordOrEmail value) {
          setState(() {
            isLoading = false;
          });
        },
        orElse: () => null,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!Platform.isIOS)
              GoogleAuthButton(
                isLoading: isLoading,
                style: const AuthButtonStyle(
                  width: double.infinity,
                ),
                onLongPress: () {
                  SignInWithState.testLogIn(ref);
                },
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });

                  ref
                      .read(SignInWithState.google)
                      .then((state) => _handler(context, state));
                },
              ),
            if (Platform.isIOS)
              AppleAuthButton(
                themeMode: ThemeMode.light,
                isLoading: isLoading,
                onLongPress: () {
                  SignInWithState.testLogIn(ref);
                },
                style: const AuthButtonStyle(
                  borderRadius: 4,
                  height: 45,
                  width: double.infinity,
                ),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  ref
                      .read(SignInWithState.apple)
                      .then((state) => _handler(context, state));
                },
              ),
          ]),
    );
  }
}
