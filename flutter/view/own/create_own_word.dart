import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/iterables.dart';
import 'package:wordsapp/_widgets/cards/card_container.dart';
import 'package:wordsapp/_widgets/utils.dart';
import 'package:wordsapp/features/word/word.dart';
import 'package:wordsapp/generated/l10n.dart';
import 'package:wordsapp/view/own/create_own_buttom.dart';
import 'package:wordsapp/view_model/create_own_state.dart';

class CreateOwnPage extends ConsumerWidget {
  const CreateOwnPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Word> words = [];

    ref.watch(CreateOwnViewModel.createdWords).maybeMap(
          successData: (data) => words = data.words.toList(),
          orElse: () => words = [],
        );

    final List<List<Word>> groupedWords = partition(words, 6).toList();
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          if (Platform.isIOS || Platform.isMacOS)
            CupertinoSliverNavigationBar(
              largeTitle: Text(S.of(context).Create_own_title),
              trailing: const CreateOwnButton(),
            ),
          if (Platform.isAndroid || Platform.isWindows)
            SliverAppBar(
              title: Text(S.of(context).Create_own_title),
              actions: const [CreateOwnButton()],
            )
        ];
      },
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return IOSScrollSafeArea(
            index: index,
            lenght: groupedWords.length,
            child: CardsContainer(
              isAllExpanded: false,
              words: [
                ...groupedWords[index].map(
                  (word) => word,
                )
              ],
              title: groupedWords[index].first.date,
            ),
          );
        },
        itemCount: groupedWords.length,
      ),
    );
  }
}
