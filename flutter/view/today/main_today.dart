import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/_widgets/cards/widget_card.dart';
import 'package:wordsapp/_widgets/utils.dart';
import 'package:wordsapp/features/word/word.dart';
import 'package:wordsapp/view/today/for_repeat/page_for_repeat.dart';
import 'package:wordsapp/view/today/today_choosen/today_choosen.dart';
import 'package:wordsapp/view_model/today_state.dart';

class Today extends ConsumerWidget {
  const Today({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(todayAutoAction).when(
      chooseNewWords: (bool allWordsChosen, Set<Word> chosenWords) {
        return TodayChosen(
            allWordsChosen: allWordsChosen, chosenWords: chosenWords);
      },
      wordsForRepeat: (
        Set<Word> words,
        bool isNewAvailable,
        void Function() onRepeat,
      ) {
        return WordsForRepeatList(
          newWordsAvailable: isNewAvailable,
          onRepeatCallback: onRepeat,
          children: [
            for (var i = 0; i < words.length; i++)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: BouncedWrapper(
                  card: CardWord.big(
                    word: words.elementAt(i),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
