import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordsapp/config.dart';

class FirstLaunchDetector {
  static final value = StateProvider<bool>(
    (ref) {
      final box = Hive.box<bool>(HiveBoxes.isFirstLaunch.name);
      final isFirstLaunch =
          box.get(HiveBoxes.isFirstLaunch.name, defaultValue: true);

      return isFirstLaunch ?? true;
    },
  );

  static final firstLaunchComplete = Provider<void Function()>((ref) => () {
        final box = Hive.box<bool>(HiveBoxes.isFirstLaunch.name);
        box.put(HiveBoxes.isFirstLaunch.name, false);
        ref.watch(value.notifier).state = false;
      });
}
