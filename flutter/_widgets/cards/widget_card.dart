import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordsapp/_widgets/cards/Image_container.dart';
import 'package:wordsapp/_widgets/cards/adaptive_colors.dart';
import 'package:wordsapp/_widgets/utils.dart';
import 'package:wordsapp/extensions.dart';
import 'package:wordsapp/features/word/word.dart';

enum _Size { big, medium, small }

class CardWord extends StatefulWidget {
  final Word word;
  final double height;
  final _Size _size;

  CardWord.big({Key? key, required this.word, height})
      : _size = _Size.big,
        height = word.isImaged ? 4.9 : 2.5,
        super(key: key ?? ValueKey(word.wordID));

  CardWord.small({Key? key, required this.word, height})
      : _size = _Size.small,
        height = word.isImaged ? 4.9 : 2.5,
        super(key: key ?? ValueKey(word.wordID));

  CardWord.medium({Key? key, required this.word, height})
      : _size = _Size.medium,
        height = word.isImaged ? 4.9 : 2.5,
        super(key: key ?? ValueKey(word.wordID));

  @override
  State<CardWord> createState() => _CardWordState();
}

class _CardWordState extends State<CardWord>
    with AutomaticKeepAliveClientMixin<CardWord> {
  static TextStyle _wordStyle(_Size size) => TextStyle(
        color: CupertinoColors.white,
        fontSize: size == _Size.medium
            ? 18
            : size == _Size.small
                ? 14
                : 30,
        fontWeight: FontWeight.w700,
      );

  late final Color backgroundColor;

  @override
  void initState() {
    backgroundColor = AdaptiveColors.getOrdered(widget.word.wordID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PhysicalModel(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(20),
      color: Colors.transparent,
      shadowColor: context.appColors.shadows,
      elevation: 6.0,
      child: AspectRatio(
        aspectRatio: 4 / widget.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topCenter,
                    stops: const [0.3, 1],
                    colors: [
                      backgroundColor,
                      context.appColors.backgroundCardCorner,
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: CupertinoBlure(
                child: ImageContainer(
                  key: ValueKey("${widget.word.wordID}imagedContainerStatic"),
                  word: widget.word,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.word.english,
                                      style: _wordStyle(widget._size)),
                                  Text(widget.word.ruTranslate,
                                      style: _wordStyle(widget._size))
                                ]),
                          )),
                      if (widget._size != _Size.small)
                        SizedBox(
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.zero,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10,
                              ),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: context.appColors.cardColor),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 2, 10, 10),
                                  child: _AssociationText(
                                    assotiation: widget.word.assotiation,
                                    size: widget._size,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _AssociationText extends StatelessWidget {
  final String assotiation;
  final _Size size;
  List<TextSpan> parsedAssociation = [];

  List<TextSpan> parse(BuildContext context) {
    final associationArr = assotiation.split('');
    List<TextSpan> parsedAssociation = [];

    for (int i = 0; i < associationArr.length; i++) {
      final letter = associationArr[i];

      RegExp regExp = RegExp(r'^[А-Я]$');
      bool isCapital = regExp.hasMatch(letter);

      late final TextSpan result;

      if (isCapital) {
        result = TextSpan(
          text: letter,
          style: TextStyle(color: context.coloredPrimaryText),
        );
      } else {
        result = TextSpan(
          text: i == 0 ? letter.toUpperCase() : letter,
          style: TextStyle(color: Colors.grey.shade600),
        );
      }
      parsedAssociation.add(result);
    }

    return parsedAssociation;
  }

  _AssociationText({required this.assotiation, required this.size});

  @override
  Widget build(BuildContext context) {
    if (size == _Size.medium) {
      return RichText(
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        text: TextSpan(
          children: parse(context),
        ),
      );
    }

    return RichText(
      text: TextSpan(
        children: parse(context),
      ),
    );
  }
}
