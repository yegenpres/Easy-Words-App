import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/features/progress/progress_controller.dart';
import 'package:wordsapp/features/user/user_controller.dart';
import 'package:wordsapp/features/word/word.dart';

void testSetUserData(WidgetRef ref) {
  final controller = ref.read(UserController.stateProvider.notifier);
  controller.set(id: "testID", email: "test@dmail.com");
}

void addProgress(WidgetRef ref) {
  final controller = ref.read(ProgressController.stateProvider.notifier);

  for (var i = 0; i < 10; i++) {
    final word = Word(
      wordID: "$i",
      english: "english$i",
      ruTranslate: "ruTranslate$i",
      engTranscription: "engTranscription",
      assotiation:
          "assotiation assotiation assotiation assotiation assotiation assotiationassotiation assotiation assotiation assotiation assotiation assotiationassotiation assotiation assotiation assotiation assotiation assotiationassotiation assotiation assotiation assotiation assotiation assotiationassotiation assotiation assotiation assotiation assotiation assotiation",
      ruTranscription: "ruTranscription",
      isImaged: i % 2 == 0 ? true : false,
      date: DateTime(2021, 1, 1).toString().split(' ')[0],
    );

    controller.addWord(word);
  }
}
