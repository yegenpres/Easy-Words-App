import 'package:hive/hive.dart';
import 'package:wordsapp/architect/interfaces/interfaces.dart';
import 'package:wordsapp/config.dart';
import 'package:wordsapp/features/session/session.dart';

enum _SessionParams { theLastUpdate, isRepeated }

class SessionProvider extends DataProviderSync<SessionData> {
  @override
  SessionData fetch() {
    Box box = Hive.box(HiveBoxes.sessionBox.name);

    if (box.isNotEmpty) {
      return SessionData(
        theLastUpdate: box.get(_SessionParams.theLastUpdate.name),
      );
    }

    return SessionData();
  }

  @override
  void save(SessionData object) async {
    Box box = Hive.box(HiveBoxes.sessionBox.name);

    box.putAll({
      _SessionParams.theLastUpdate.name: object.theLastUpdate,
      _SessionParams.isRepeated.name: object.isRepeated,
    });
  }
}
