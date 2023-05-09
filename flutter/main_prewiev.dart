import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordsapp/config.dart';
import 'package:wordsapp/cupertino_aplication.dart';
import 'package:wordsapp/features/progress/model_progress.dart';
import 'package:wordsapp/features/progress/progress_controller.dart';
import 'package:wordsapp/features/progress/progress_provider.dart';
import 'package:wordsapp/features/search/search_controller.dart';
import 'package:wordsapp/features/session/session.dart';
import 'package:wordsapp/features/session/session_controller.dart';
import 'package:wordsapp/features/session/session_provider.dart';
import 'package:wordsapp/features/user/user_controller.dart';
import 'package:wordsapp/features/user/user_model.dart';
import 'package:wordsapp/features/user/user_provider.dart';
import 'package:wordsapp/features/word/word.dart';
import 'package:wordsapp/features/words_for_choose/controller_words_for_choose.dart';
import 'package:wordsapp/features/words_for_choose/model_words_for_choose.dart';
import 'package:wordsapp/features/words_for_choose/provider_words_for_choose.dart';
import 'package:wordsapp/material_aplication.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';


Future initDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WordAdapter());
  await Hive.openBox<Word>(HiveBoxes.wordBox.name);
  await Hive.openBox(HiveBoxes.userBox.name);
  await Hive.openBox(HiveBoxes.searchKeshBox.name);
  await Hive.openBox(HiveBoxes.sessionBox.name);

  assert(
      Hive.box<Word>(HiveBoxes.wordBox.name).length ==
          Hive.box(HiveBoxes.searchKeshBox.name).length,
      'Something happend with saved words in db, kesh length and words length is nou equal');
  log('words count ${Hive.box<Word>(HiveBoxes.wordBox.name).length}');

  return;
}

void main() async {
  WordsForChooseController.stateProvider =
      StateNotifierProvider<WordsForChooseController, WordsForChooseData>(
          (ref) {
    return WordsForChooseController(provider: WordsForChooseProvider());
  });

  ProgressController.stateProvider =
      StateNotifierProvider<ProgressController, ProgressData>((ref) {
    return ProgressController(provider: ProgressProvider());
  });

  SessionController.stateProvider =
      StateNotifierProvider<SessionController, SessionData>((ref) {
    return SessionController(provider: SessionProvider());
  });
  UserController.stateProvider =
      StateNotifierProvider<UserController, UserData>(
          name: Controllers.user.name, (ref) {
    return UserController(
      provider: UserProvider(),
    );
  });
  Search.provider = ChangeNotifierProvider<Search>((ref) {
    return Search();
  });

  debugRun();
}

void debugRun() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDB();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) =>
          ProviderScope(observers: [Logger()], child: const MyApp()),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoApplication()
        : const MaterialApplication();
  }
}
