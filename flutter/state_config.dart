import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/config.dart';
import 'package:wordsapp/features/create_own_word/controller_own_words.dart';
import 'package:wordsapp/features/create_own_word/created_words/controller_created_words.dart';
import 'package:wordsapp/features/create_own_word/created_words/model_created_words.dart';
import 'package:wordsapp/features/create_own_word/created_words/provider_created_words.dart';
import 'package:wordsapp/features/create_own_word/model_own_words.dart';
import 'package:wordsapp/features/create_own_word/provider_own_words.dart';
import 'package:wordsapp/features/http_client.dart';
import 'package:wordsapp/features/progress/model_progress.dart';
import 'package:wordsapp/features/progress/progress_controller.dart';
import 'package:wordsapp/features/progress/progress_provider.dart';
import 'package:wordsapp/features/search/search_controller.dart';
import 'package:wordsapp/features/session/session.dart';
import 'package:wordsapp/features/session/session_controller.dart';
import 'package:wordsapp/features/session/session_provider.dart';
import 'package:wordsapp/features/set_device_token.dart';
import 'package:wordsapp/features/user/user_controller.dart';
import 'package:wordsapp/features/user/user_model.dart';
import 'package:wordsapp/features/user/user_provider.dart';
import 'package:wordsapp/features/words_for_choose/controller_words_for_choose.dart';
import 'package:wordsapp/features/words_for_choose/model_words_for_choose.dart';
import 'package:wordsapp/features/words_for_choose/provider_words_for_choose.dart';
import 'package:wordsapp/main.dart';

import 'view_model/debuging_features/logger.dart';

void initProviders(BuildContext context) {
  initUserProviders(context);
  _initIndependentProviders();
  _initUserDependProviders();
}

void _initIndependentProviders() {
  ControllerCreatedWords.stateProvider =
      StateNotifierProvider<ControllerCreatedWords, CreatedWords>((ref) {
    return ControllerCreatedWords(provider: CreatedWordsProvider());
  });

  OwnWordsController.stateProvider =
      StateNotifierProvider<OwnWordsController, ModelOwnWords>((ref) {
    return OwnWordsController(provider: OwnWordsProvider());
  });

  ProgressController.stateProvider =
      StateNotifierProvider<ProgressController, ProgressData>((ref) {
    return ProgressController(provider: ProgressProvider());
  });

  SessionController.stateProvider =
      StateNotifierProvider<SessionController, SessionData>((ref) {
    return SessionController(provider: SessionProvider());
  });

  Search.provider = ChangeNotifierProvider<Search>((ref) {
    return Search();
  });
}

void _initUserDependProviders() {
  WordsForChooseController.stateProvider =
      StateNotifierProvider<WordsForChooseController, WordsForChooseData>(
          (ref) {
    return WordsForChooseController(provider: WordsForChooseProvider());
  });
}

void initUserProviders(BuildContext context) {
  UserController.stateProvider =
      StateNotifierProvider<UserController, UserData>(name: "User", (ref) {
    return UserController(
      provider: UserProvider(),
      initialHandler: (user) {

        final ouserId = user.id ?? "";

        if (ouserId.isNotEmpty) {
          NetworkClient.setUserId(ouserId);
          ApiHTTP.setUserID(ouserId);
        }


        FirebaseCrashlytics.instance
            .setUserIdentifier(user.id ?? "not registered");

        FirebaseMessaging.instance.getToken().then((value) {
          lv6("token__ $value");
          if (value != null && !user.isLogedIn) {
            setDeviceToken(value);
          }
        });
        _initUserDependProviders();
      },
      onSetUserID: (ouserId) {

        if (ouserId.isNotEmpty) {
          NetworkClient.setUserId(ouserId);
          ApiHTTP.setUserID(ouserId);
        }

        FirebaseCrashlytics.instance.setUserIdentifier(ouserId);

        FirebaseMessaging.instance.getToken().then((value) {
          if (value != null) {
            setDeviceToken(value);
          }
        });

        RestartWidget.restartApp(context);
      },
    );
  });
}
