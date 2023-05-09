import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:wordsapp/architect/interfaces/interfaces.dart';
import 'package:wordsapp/config.dart';
import 'package:wordsapp/features/progress/model_progress.dart';
import 'package:wordsapp/features/word/word.dart';

class ProgressProvider extends FetchableWordsProviderSync<ProgressData> {
  @override
  Future<Uint8List?> fetchImage(ImagedWordable word) async {
    final storeLazy = Hive.lazyBox(HiveBoxes.imagesBox.name);
    final Uint8List bytes =
        await storeLazy.get(word.wordID, defaultValue: Uint8List(0));
    if (bytes.isNotEmpty) return bytes;
    return null;
  }

  Future _saveImage(ImagedWordable word) async {
    if (!word.isImaged) return;

    final bytes = await word.fetchImage();

    if (bytes == null) return;

    final storeLazy = Hive.lazyBox(HiveBoxes.imagesBox.name);
    await storeLazy.put(word.wordID, bytes);
  }

  @override
  ProgressData fetch() {
    final store = Hive.box<Word>(HiveBoxes.wordBox.name);
    final DateTime today = DateTime.now();
    final Set<Word> finalStore = store.values.toSet();

    for (var word in finalStore) {
      word.imageProvider = fetchImage;
    }

    final userStore = finalStore
        .where((word) => word.date != today.toString().split(' ')[0])
        .toSet();

    final todayChoosen = finalStore
        .where((word) => word.date == today.toString().split(' ')[0])
        .toSet();

    return ProgressData(
      userStore: userStore,
      todayChoosen: todayChoosen,
    );
  }

  @override
  void save(ProgressData object) {
    final item = object.todayChoosen.last;
    _saveImage(item);
    Box box = Hive.box<Word>(HiveBoxes.wordBox.name);
    box.add(item);

    Box kesh = Hive.box(HiveBoxes.searchKeshBox.name);
    List value = [item.english, item.ruTranslate, item.date];
    kesh.add(value);
  }
}
