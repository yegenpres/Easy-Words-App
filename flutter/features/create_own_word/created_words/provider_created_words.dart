import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordsapp/architect/interfaces/interfaces.dart';
import 'package:wordsapp/config.dart';
import 'package:wordsapp/features/create_own_word/created_words/model_created_words.dart';
import 'package:wordsapp/features/http_client.dart';
import 'package:wordsapp/features/word/word.dart';

class CreatedWordsProvider implements DataProviderSync<CreatedWords> {
  final nameBox = HiveBoxes.ownWordsBox.name;

  @override
  CreatedWords fetch() {
    final store = Hive.box<Word>(nameBox);
    final Set<Word> words = store.values.toSet();

    return CreatedWords(words: words);
  }

  Future<bool> send(Word word) async => await NetworkClient.ownWords.send(word);

  @override
  void save(CreatedWords object) {
    final item = object.words.last;
    Box box = Hive.box<Word>(nameBox);
    box.add(item);

    send(item);

    Box kesh = Hive.box(HiveBoxes.ownWordsSearch.name);
    List value = [item.english, item.ruTranslate, item.date];
    kesh.add(value);
  }
}
