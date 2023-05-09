import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordsapp/_widgets/cards/card_container.dart';
import 'package:wordsapp/_widgets/cards/widget_card.dart';
import 'package:wordsapp/_widgets/utils.dart';
import 'package:wordsapp/features/search/sliver_search_app_bar.dart';
import 'package:wordsapp/generated/l10n.dart';
import 'package:wordsapp/router.dart';
import 'package:wordsapp/view/my_words/widget_animated_icon_expande.dart';
import 'package:wordsapp/view_model/progress_state.dart';

class ProgressList extends ConsumerStatefulWidget {
  const ProgressList({super.key});

  @override
  ProgressListState createState() => ProgressListState();
}

class ProgressListState extends ConsumerState<ProgressList> {
  bool isExpanded = false;

  void _toggleIsExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = S.of(context).My_words_title;
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          if (Platform.isIOS || Platform.isMacOS)
            CupertinoSliverNavigationBar(
              leading: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {
                    context.go(Routes.profile.name);
                  },
                  child: const Icon(CupertinoIcons.profile_circled),
                ),
              ),
              largeTitle: Text(title),
              trailing: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: _toggleIsExpanded,
                  child: AnimatedIconExpand(isExpanded),
                ),
              ),
            ),
          if (Platform.isAndroid || Platform.isWindows)
            SliverAppBar(
              title: Text(title),
              actions: [
                IconButton(
                  icon: const Icon(CupertinoIcons.profile_circled),
                  onPressed: () {
                    context.go(Routes.profile.name);
                  },
                ),
                IconButton(
                  icon: AnimatedIconExpand(isExpanded),
                  onPressed: _toggleIsExpanded,
                ),
              ],
            ),
          SliverPersistentHeader(
              floating: true,
              delegate: SliverPersistensSearchAppBar(expandedHeight: 35))
        ];
      },
      body: Content(
        isExpanded: isExpanded,
      ),
    );
  }
}

class Content extends ConsumerWidget {
  final bool isExpanded;
  const Content({super.key, required this.isExpanded});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(progressAutoAction).when(
      foundedWords: (foundWords) {
        return AdaptiveScrollBar(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: CardWord.big(word: foundWords.elementAt(index)),
              );
            },
            itemCount: foundWords.length,
          ),
        );
      },
      userProgress: (userProgress, titles) {
        return AdaptiveScrollBar(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return CardsContainer(
                isAllExpanded: isExpanded,
                words: [
                  ...userProgress[titles[index]]!.map(
                    (word) => word,
                  )
                ],
                title: titles[index],
              );
            },
            itemCount: titles.length,
          ),
        );
      },
    );
  }
}

// UnconstrainedBox some = OverflowBox()
