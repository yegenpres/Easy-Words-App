import 'dart:developer';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:wordsapp/config.dart';
import 'package:wordsapp/features/autentifications/firebase_controller.dart';
import 'package:wordsapp/features/user/user_controller.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';

part 'autetification_state.freezed.dart';

@freezed
class AutentificationState with _$AutentificationState {
  const factory AutentificationState.logedIn() = LogedIn;
  const factory AutentificationState.noLogedIn() = NoLogedIn;
  const factory AutentificationState.registered() = Registered;
  const factory AutentificationState.errorPasswordOrEmail() =
      ErrorPasswordOrEmail;
  const factory AutentificationState.systemError() = SystemError;
}

final autentificationAutoAction = Provider<AutentificationState>(((ref) {
  final isLogedIn = ref.watch(UserController.stateProvider).isLogedIn;

  if (isLogedIn) {
    return const AutentificationState.logedIn();
  } else {
    return const AutentificationState.noLogedIn();
  }
}));

class SignInWithState {
  static Future<bool> _sendUserID(String id) async {
    final Dio dio = Dio();

    try {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      var response = await dio.post(ApiHTTP.postNewUserID(id));

      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<String> gatUniqueDeviceId() async {
    String? identifier;
    try {
      identifier = await UniqueIdentifier.serial;
    } on PlatformException {
      rethrow;
    }

    return identifier ?? 'Failed to get Unique Identifier';
  }

  static Future<AutentificationState> deviceIdAuthentication(
      FutureProviderRef ref) async {
    final setId = ref.read(UserController.stateProvider.notifier).set;
    var id = "";
    try {
      id = await gatUniqueDeviceId();
      await _sendUserID(id);
    } catch (e) {
      return const AutentificationState.systemError();
    }

    setId(id: id);
    return const AutentificationState.logedIn();
  }

  static testLogIn(WidgetRef ref) {
    if (!kDebugMode) return;
    final setId = ref.read(UserController.stateProvider.notifier).set;

    setId(
      id: "testId",
      email: "test@mail.com",
      isLogedIn: true,
    );
  }

  static Future<AutentificationState> _handlerSignIn(
      ProviderRef<Future<AutentificationState>> ref, String platform) async {
    final AuthenticationService service = AuthenticationService();
    final setId = ref.read(UserController.stateProvider.notifier).set;

    UserCredential? response;
    try {
      switch (platform) {
        case "apple":
          response = await service.signInWithApple();
          break;
        case "google":
          response = await service.signInwithGoogle();
          break;
      }
    } catch (e) {
      return const AutentificationState.systemError();
    }

    if (response?.user != null) {
      bool isRegistered = await _sendUserID(response!.user!.uid);

      if (!isRegistered) return const AutentificationState.systemError();

      setId(
        id: response.user?.uid,
        email: response.user?.email,
        isLogedIn: true,
      );

      return const AutentificationState.logedIn();
    } else {
      return const AutentificationState.errorPasswordOrEmail();
    }
  }

  static final logInWithEmail =
      Provider.family<Future<AutentificationState>, List<String>>(
    (ref, list) async {
      final service = AuthenticationService();
      final setUserParams = ref.read(UserController.stateProvider.notifier).set;
      try {
        final result = await service.logInWithEmail(
          email: list.first,
          password: list.last,
        );

        if (result?.user?.uid != null) {
          setUserParams(
            id: result?.user?.uid,
            email: result?.user?.email,
            isLogedIn: true,
          );
          return const AutentificationState.logedIn();
        } else {
          return const AutentificationState.errorPasswordOrEmail();
        }
      } catch (e) {
        return const AutentificationState.systemError();
      }
    },
  );

  static final signInWithEmail =
      Provider.family<Future<AutentificationState>, List<String>>(
    (ref, list) async {
      final service = AuthenticationService();
      final setUserParams = ref.read(UserController.stateProvider.notifier).set;

      try {
        final result = await service.signInWithEmail(
          email: list.first,
          password: list.last,
        );

        if (result?.user?.uid != null) {
          setUserParams(
            id: result?.user?.uid,
            email: result?.user?.email,
            isLogedIn: true,
          );

          bool isRegistered = await _sendUserID(result!.user!.uid);

          if (!isRegistered) return const AutentificationState.systemError();

          return const AutentificationState.registered();
        } else {
          return const AutentificationState.errorPasswordOrEmail();
        }
      } catch (e) {
        return const AutentificationState.systemError();
      }
    },
  );

  static final apple = Provider<Future<AutentificationState>>(
    (ref) async {
      return await _handlerSignIn(ref, "apple");
    },
  );
  static final google = Provider<Future<AutentificationState>>(
    (ref) async {
      return await _handlerSignIn(ref, "google");
    },
  );

  static final resetPassword =
      Provider.family<Future<AutentificationState>, String>(
    (ref, email) async {
      final service = AuthenticationService();
      try {
        final result = await service.resetPassword(
          email: email,
        );

        if (result) {
          return const AutentificationState.registered();
        } else {
          return const AutentificationState.errorPasswordOrEmail();
        }
      } catch (e) {
        log(e.toString());
        return const AutentificationState.systemError();
      }
    },
  );
  static final logOut = Provider<void Function()>(
    (ref) {
      return () {
        AuthenticationService().signOut();
        ref
            .read(UserController.stateProvider.notifier)
            .set(isLogedIn: false, isSubscribed: false);
      };
    },
  );
}
