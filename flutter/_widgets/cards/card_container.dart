import 'package:flutter/cupertino.dart';
import 'package:wordsapp/_widgets/cards/card_delegate.dart';
import 'package:wordsapp/_widgets/cards/card_expanded/widget_expanded_card.dart';
import 'package:wordsapp/features/word/word.dart';

class CardsContainer extends StatefulWidget {
  final Iterable<Word> words;
  final String title;
  final bool isAllExpanded;

  const CardsContainer({
    Key? key,
    required this.words,
    required this.title,
    required this.isAllExpanded,
  }) : super(key: key);

  @override
  State<CardsContainer> createState() => _CardsContainerState();
}

class _CardsContainerState extends State<CardsContainer> {
  List<CardDelegate> config = [];

  void _changeConfig(int index) {
    final newIsExpanded = !config[index].isExpanded;

    if (newIsExpanded) {
      config[index].expand();
    } else {
      config[index].shrink();
    }

    for (var conf in config) {
      if (conf.index == index - 1) {
        if (conf.isExpanded) {
          config[index].topBorder = true;
        } else {
          conf.bottomBorder = newIsExpanded;
        }
      }
      if (conf.index == index + 1) {
        if (conf.isExpanded) {
          config[index].bottomBorder = true;
        } else {
          conf.topBorder = newIsExpanded;
        }
      }
    }

    setState(() {});
  }

  void _initExpandedConfig() {
    for (var i = 0; i < widget.words.length; i++) {
      if (widget.words.length == 1) {
        config.add(
          CardDelegate.expanded(
              index: 0,
              position: Position.single,
              handler: () {
                _changeConfig(i);
              }),
        );
        return;
      }
      if (i == 0) {
        config.add(
          CardDelegate.expanded(
              index: i,
              position: Position.first,
              handler: () {
                _changeConfig(i);
              }),
        );
      } else if (i == widget.words.length - 1) {
        config.add(
          CardDelegate.expanded(
              index: i,
              position: Position.last,
              handler: () {
                _changeConfig(i);
              }),
        );
      } else {
        config.add(CardDelegate.expanded(
            position: Position.middle,
            index: i,
            handler: () {
              _changeConfig(i);
            }));
      }
    }
  }

  void _initShrinkedConfig() {
    for (var i = 0; i < widget.words.length; i++) {
      if (widget.words.length == 1) {
        config.add(
          CardDelegate.shrinked(
              index: 0,
              position: Position.single,
              handler: () {
                _changeConfig(i);
              }),
        );
        return;
      }
      if (i == 0) {
        config.add(CardDelegate.shrinked(
            index: i,
            position: Position.first,
            handler: () {
              _changeConfig(i);
            }));
      } else if (i == widget.words.length - 1) {
        config.add(CardDelegate.shrinked(
            index: i,
            position: Position.last,
            handler: () {
              _changeConfig(i);
            }));
      } else {
        config.add(CardDelegate.shrinked(
            position: Position.middle,
            index: i,
            handler: () {
              _changeConfig(i);
            }));
      }
    }
  }

  @override
  void didUpdateWidget(covariant CardsContainer oldWidget) {
    if (oldWidget.isAllExpanded != widget.isAllExpanded) {
      for (var conf in config) {
        if (widget.isAllExpanded == true) {
          conf.expand();
        } else {
          conf.shrink();
        }
      }
    }

    if (oldWidget.words.length != widget.words.length) {
      config = [];
      if (widget.isAllExpanded) {
        _initExpandedConfig();
      } else {
        _initShrinkedConfig();
      }

      super.didUpdateWidget(oldWidget);
    }
  }

  @override
  void initState() {
    if (widget.isAllExpanded) {
      _initExpandedConfig();
    } else {
      _initShrinkedConfig();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Text(
                widget.title,
                style: const TextStyle(),
              )),
          for (var i = 0; i < widget.words.length; i++)
            ExpandedCard.grouped(
              delegate: config[i],
              word: widget.words.elementAt(i),
            )
        ],
      ),
    );
  }
}
