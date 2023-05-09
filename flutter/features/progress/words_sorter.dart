import 'package:wordsapp/config.dart';
import 'package:wordsapp/features/progress/model_progress.dart';
import 'package:wordsapp/features/word/word.dart';

class WordsSorter<T extends ProgressData> {
  const WordsSorter();

  Set<Word> _sortListByinterval(List<Word> list,
      [Set<int> config = repeatedInterval]) {
    List<int> currentConfig = [...config];

    if (currentConfig.isEmpty) return list.toSet();

    list.sort((Word word, Word word2) {
      if (_differentInDayes(word) == config.elementAt(0)) return 1;
      return -1;
    });

    currentConfig.removeAt(0);

    return _sortListByinterval(list, currentConfig.toSet());
  }

  List<Word> selectByInterval(List<Word> words) {
    List<Word> userStory = _sortListByinterval([
      ...words.toList(),
    ]).toList();

    List<Word> select(List<Word> list, [config = repeatedInterval]) {
      List conf = [...config];

      if (conf.isEmpty && list.isEmpty) return _theLastDayWords(userStory);
      if (conf.isEmpty) return list;

      List<Word> branch = userStory.where((Word word) {
        return _differentInDayes(word) == conf[0];
      }).toList();

      conf.remove(conf[0]);

      return select([...list, ...branch.toList()], conf);
    }

    return select([]);
  }

  List<Word> _theLastDayWords(List<Word> wordsList) {
    if (wordsList.isEmpty) return [];
    final date = wordsList.first.date;
    return wordsList.where((element) => element.date == date).toList();
  }

  int _differentInDayes(Word word) {
    final now = DateTime.now();
    final worddate = DateTime.parse(word.date);
    return now.difference(worddate).inDays;
  }
}
