import 'dart:developer';
import 'dart:typed_data';

import 'package:wordsapp/architect/interfaces/interfaces.dart';
import 'package:wordsapp/features/http_client.dart';
import 'package:wordsapp/features/word/word.dart';
import 'package:wordsapp/features/words_for_choose/model_words_for_choose.dart';

class WordsForChooseProvider
    extends FetchableWordsProviderAsync<WordsForChooseData> {
  @override
  Future<Uint8List?> fetchImage(ImagedWordable word) async =>
      NetworkClient.wordsForChoose.fetchImage(word);

  @override
  Future<WordsForChooseData> fetch() async {
    final wordsMap = await NetworkClient.wordsForChoose.fetch(300);

    final Set<Word> words = wordsMap.isNotEmpty
        ? Set<Word>.from(wordsMap.map((word) => Word.fromJson(word)))
        : {};

    for (var word in words) {
      word.imageProvider = fetchImage;
    }

    final sorted = words.toList()
      ..sort((word1, word2) => word2.isImaged ? 1 : -1);

    return WordsForChooseData(words: sorted.toSet());
  }

  @override
  Future save(WordsForChooseData object) async {
    log("save words for choose");
  }
}
