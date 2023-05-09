import 'package:hive/hive.dart';
import 'package:wordsapp/architect/interfaces/interfaces.dart';
import 'package:wordsapp/config.dart';
import 'package:wordsapp/features/user/user_model.dart';

enum _UserParams { id, email }

class UserProvider implements DataProviderSync<UserData> {
  @override
  UserData fetch() {
    Box box = Hive.box(HiveBoxes.userBox.name);

    bool isLogedIn = false;

    if (box.get(_UserParams.id.name) != null) {
      isLogedIn = true;
    }

    if (box.isNotEmpty) {
      return UserData(
          id: box.get(_UserParams.id.name),
          email: box.get(_UserParams.email.name),
          isLogedIn: isLogedIn);
    }

    return UserData();
  }

  @override
  void save(UserData user) async {
    Box box = Hive.box(HiveBoxes.userBox.name);

    box.putAll({
      _UserParams.id.name: user.id,
      _UserParams.email.name: user.email,
    });
  }
}
