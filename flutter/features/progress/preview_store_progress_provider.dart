import 'dart:typed_data';

import 'package:wordsapp/architect/interfaces/interfaces.dart';
import 'package:wordsapp/features/progress/model_progress.dart';
import 'package:wordsapp/test_words.dart';

class PreviewStoreProgressProvider
    extends FetchableWordsProviderSync<ProgressData> {
  @override
  Future<Uint8List?> fetchImage(ImagedWordable word) async {
    final result = await word.fetchImage();

    if (result == null) {
      return null;
    }
    return result;
  }

  @override
  ProgressData fetch() {
    return ProgressData(
      userStore: {...testWords, ...testWordsWithoutImage},
      todayChoosen: const {},
    );
  }

  @override
  void save(ProgressData object) {}
}
