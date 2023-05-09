import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/features/create_own_word/empty_word.dart';
import 'package:wordsapp/view/own/text_fields.dart';
import 'package:wordsapp/view/own/words_tamplates_selector.dart';
import 'package:wordsapp/view_model/create_own_state.dart';

class CreatingForm extends ConsumerStatefulWidget {
  const CreatingForm({Key? key}) : super(key: key);

  @override
  ConsumerState<CreatingForm> createState() => _CreatingFormState();
}

class _CreatingFormState extends ConsumerState<CreatingForm> {
  Set<EmptyWord> words = {};
  int currentIndex = -1;

  EmptyWord? _selectWord() {
    if (currentIndex > words.length - 1 || currentIndex < 0) {
      return null;
    }

    return words.elementAt(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(CreateOwnViewModel.emptyWords).maybeMap(
          templatesForCreate: (words) => this.words = words.words,
          orElse: () => words = {},
        );

    return Column(
      children: [
        TextFields(
          word: _selectWord(),
          onSave: (word) {
            ref.read(CreateOwnViewModel.userActionCreate)(word);
          },
        ),
        WordsTemplatesSelector(
          backButton: () {
            setState(() {
              currentIndex--;
            });
          },
          clearButton: () {
            setState(() {
              currentIndex = -1;
            });
          },
          nextButton: () {
            setState(() {
              currentIndex++;
            });
          },
        ),
      ],
    );
  }
}
