import 'package:flutter/material.dart';
import 'package:wordsapp/_widgets/cards/widget_card.dart';
import 'package:wordsapp/_widgets/utils.dart';
import 'package:wordsapp/extensions.dart';
import 'package:wordsapp/features/word/word.dart';
import 'package:wordsapp/view/today/today_choosen/words_for_choose/available_today_for_choose.dart';

class TodayChosen extends StatefulWidget {
  final bool allWordsChosen;
  final Set<Word> chosenWords;
  const TodayChosen(
      {super.key, required this.allWordsChosen, required this.chosenWords});

  @override
  State<TodayChosen> createState() => _TodayChosenState();
}

class _TodayChosenState extends State<TodayChosen>
    with CustomAnimatedListDelegate {
  final _controller = ScrollController();
  Set<Word> data = {};

  Set<Word> newItems(Set<Word> newData) {
    final diff = newData.difference(data);
    data = newData;
    return diff;
  }

  void updateItems() {
    for (final newWord in newItems(widget.chosenWords)) {
      insertItemAt(
        index: widget.allWordsChosen ? 0 : 1,
        item: CardWord.big(word: newWord),
        duration: const Duration(seconds: 2),
      );
    }
  }

  @override
  void didUpdateWidget(covariant TodayChosen oldWidget) {
    if (oldWidget.allWordsChosen != widget.allWordsChosen &&
        widget.allWordsChosen) {
      removeItemAt(
          index: 0,
          builder: (context, animation) {
            return IOSScrollSafeArea(
              key: ValueKey(items[0]),
              isReversed: true,
              index: 0,
              lenght: items.length,
              child: BouncedWrapper(
                card: _ListItemWidget(
                  item: items.removeAt(0),
                  animation: animation,
                ),
              ),
            );
          }).then((value) => updateItems());
    } else {
      if (oldWidget.chosenWords.length < widget.chosenWords.length) {
        updateItems();
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    data = widget.chosenWords;
    items = [
      const AvailableTodayForChoose(),
      ...widget.chosenWords.map((word) => CardWord.big(word: word)),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScrollBar(
      controller: _controller,
      child: AnimatedList(
          controller: _controller,
          reverse: true,
          key: listKey,
          initialItemCount: items.length,
          itemBuilder: (context, index, animation) {
            return IOSScrollSafeArea(
              isReversed: true,
              index: index,
              lenght: items.length,
              child: BouncedWrapper(
                card: _ListItemWidget(
                  item: items[index],
                  animation: animation,
                ),
              ),
            );
          }),
    );
  }
}

class _ListItemWidget extends StatefulWidget {
  final Widget item;
  final Animation<double> animation;
  const _ListItemWidget({
    required this.item,
    required this.animation,
  });

  @override
  State<_ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<_ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: PhysicalModel(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        shadowColor: context.appColors.shadows,
        elevation: 6.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizeTransition(
            sizeFactor: widget.animation.drive(
              CurveTween(
                curve: Curves.decelerate,
              ),
            ),
            child: widget.item,
          ),
        ),
      ),
    );
  }
}

class _ListItemScale extends StatefulWidget {
  final Widget item;
  final Animation<double> animation;
  const _ListItemScale({
    required this.item,
    required this.animation,
  });

  @override
  State<_ListItemScale> createState() => _ListItemScaleState();
}

class _ListItemScaleState extends State<_ListItemScale> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: PhysicalModel(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
            shadowColor: context.appColors.shadows,
            elevation: 6.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizeTransition(
                sizeFactor: widget.animation.drive(
                  CurveTween(
                    curve: Curves.decelerate,
                  ),
                ),
                child: child,
              ),
            ),
          ),
        );
      },
      child: widget.item,
    );
  }
}
