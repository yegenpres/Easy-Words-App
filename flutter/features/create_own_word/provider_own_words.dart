import 'package:wordsapp/architect/interfaces/interfaces.dart';
import 'package:wordsapp/features/create_own_word/empty_word.dart';
import 'package:wordsapp/features/create_own_word/model_own_words.dart';
import 'package:wordsapp/features/create_own_word/word_parts_enum.dart';
import 'package:wordsapp/features/http_client.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';

class OwnWordsProvider implements DataProviderAsync<ModelOwnWords> {
  @override
  Future<ModelOwnWords> fetch() async {
    var model = ModelOwnWords();
    assert(model.wordsParts.first == WordParts.initialData.name,
        "initial data in ModelWordsOwn in wordsPart shoul be {initialData}");

    final words = await _fetchEmptyWords();
    return model.copyWith(emptyWords: words);
  }

  Future<Set<EmptyWord>> _fetchEmptyWords() async {
    final wordsMap = await NetworkClient.ownWords.fetchEmptyWords();

    return wordsMap.isNotEmpty
        ? Set<EmptyWord>.from(wordsMap.map((word) => EmptyWord.fromJson(word)))
        : {};
  }

  @override
  Future save(ModelOwnWords object) async {
    lv6("save() no implemented in OwnWordsProvider");
  }
}
