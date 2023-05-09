import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/_widgets/widget_words_for_choose.dart';
import 'package:wordsapp/view_model/available_today_for_choose_state.dart';

class AvailableTodayForChoose extends ConsumerWidget {
  const AvailableTodayForChoose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(forChooseAytoAction).when(
      empty: () {
        return WordsForChoose.empty(
          key: UniqueKey(),
        );
      },
      loaded: (words) {
        return WordsForChoose(
          words: words,
          tapHandler: ref.read(forChooseUserAction),
        );
      },
    );
  }
}
