import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:sizer/sizer.dart';
import 'package:wordsapp/extensions.dart';
import 'package:wordsapp/features/word/word.dart';

class WordsForChoose extends StatefulWidget {
  final Function(Word) tapHandler;
  List<List<Word>> _wordsForSelect = [];
  final double alignHeight;
  final bool isEmpty;

  WordsForChoose({
    super.key,
    Set<Word> words = const {},
    required this.tapHandler,
    this.alignHeight = 1.0,
  })  : _wordsForSelect = partition(words, 6).toList(),
        isEmpty = false;

  WordsForChoose.empty({
    super.key,
    this.tapHandler = print,
  })  : alignHeight = 1.0,
        isEmpty = true {
    _wordsForSelect = [
      [
        Word(
            wordID: "wordID",
            english: "english",
            ruTranslate: "ruTranslate",
            engTranscription: "engTranscription",
            assotiation: "assotiation",
            ruTranscription: "ruTranscription",
            isImaged: false)
      ]
    ];
  }

  @override
  State<WordsForChoose> createState() => _WordsForChooseState();
}

class _WordsForChooseState extends State<WordsForChoose> {
  final AlwaysScrollableScrollPhysics physics =
      const AlwaysScrollableScrollPhysics();

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: widget.alignHeight,
      child: AspectRatio(
        aspectRatio: 10 / 6,
        child: Container(
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.primaryContrastingColors,
            // color: theme.primaryContrastingColor,
          ),
          child: PageView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            physics: physics,
            itemCount: widget._wordsForSelect.length,
            itemBuilder: (_, index) => _Page(
              isEmpty: widget.isEmpty,
              tapHandler: widget.tapHandler,
              key: ValueKey("Page$index"),
              children: widget._wordsForSelect[index],
            ),
          ),
        ),
      ),
    );
  }
}

class _Page extends StatefulWidget {
  final bool isEmpty;
  final Function(Word) tapHandler;
  final List<Word> children;
  const _Page({
    super.key,
    required this.children,
    required this.tapHandler,
    this.isEmpty = false,
  });

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  late Set<Word> words;

  @override
  void initState() {
    words = {...widget.children};
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _Page oldWidget) {
    var newWord =
        widget.children.toSet().difference(oldWidget.children.toSet());
    if (newWord.isNotEmpty) {
      var oldWord = words.difference(widget.children.toSet());
      final indexShift = words.toList().indexOf(oldWord.single);

      var result = words.toList();
      result.remove(oldWord.single);
      result.insert(indexShift, newWord.single);

      words = result.toSet();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _BackgroundCell(),
        Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          children: widget.isEmpty
              ? [
                  for (int i = 0; i < 7; i++)
                    _Button(
                        isEmpty: widget.isEmpty,
                        word: words.first,
                        tapHandler: (word) {}),
                ]
              : [
                  for (int i = 0; i < words.length; i++)
                    _Button(
                      isEmpty: widget.isEmpty,
                      word: words.elementAt(i),
                      tapHandler: widget.tapHandler,
                    )
                ],
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final bool isEmpty;

  final Function(Word) tapHandler;
  final Word word;
  const _Button({
    required this.word,
    required this.tapHandler,
    this.isEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 2.2;
    return FractionallySizedBox(
      heightFactor: 0.3,
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                behavior: HitTestBehavior.deferToChild,
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: isEmpty
                        ? [
                            platformSelector(
                              material: const CircularProgressIndicator(),
                              cupertino: const CupertinoActivityIndicator(),
                            ),
                          ]
                        : [
                            if (word.isImaged) const _ImageIndicator(),
                            Text(word.english,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: context.coloredPrimaryText)),
                            ...word.ruTranslate
                                .split(',')[0]
                                .split(' ')
                                .map((span) => Text(
                                      span,
                                      style: TextStyle(
                                          fontSize:
                                              context.appGeometry.textSize,

                                          // fontSize: 12,
                                          color: context.coloredPrimaryText),
                                    )),
                          ],
                  ),
                ),
                onTap: () {
                  tapHandler(word);
                })
          ],
        ),
      ),
    );
  }
}

class _BackgroundCell extends StatelessWidget {
  const _BackgroundCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(
            flex: 5,
            child: SizedBox(),
          ),
          _Separator(),
          Expanded(
            flex: 15,
            child: SizedBox(),
          ),
          _Separator(),
          Expanded(
            flex: 5,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 100,
      child: FractionallySizedBox(
        heightFactor: 0.33,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: .5,
                color: context.appColors.separator,
              ),
              bottom: BorderSide(
                color: context.appColors.separator,
                width: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageIndicator extends StatelessWidget {
  const _ImageIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      child: Text(
        "Imaged",
        style: TextStyle(fontSize: 7.sp, color: CupertinoColors.systemGreen),
        textAlign: TextAlign.left,
      ),
    );
  }
}
