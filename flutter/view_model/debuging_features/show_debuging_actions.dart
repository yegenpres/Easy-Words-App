import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:wordsapp/_widgets/inviting_congretulation.dart';
import 'package:wordsapp/_widgets/utils.dart';
import 'package:wordsapp/_widgets/widget_words_for_choose.dart';
import 'package:wordsapp/features/notifications/notifications.dart';
import 'package:wordsapp/features/progress/model_progress.dart';
import 'package:wordsapp/features/progress/preview_store_progress_provider.dart';
import 'package:wordsapp/features/progress/progress_controller.dart';
import 'package:wordsapp/features/subscription/paywall_widget.dart';
import 'package:wordsapp/features/word/word.dart';
import 'package:wordsapp/main.dart';
import 'package:wordsapp/view_model/debuging_features/test_actions.dart';

import 'logger.dart';

void shodDebugActions(WidgetRef ref, BuildContext context) {
  if (kReleaseMode) {
    return;
  }

  context.go('/debug');
}

class DebugPage extends ConsumerStatefulWidget {
  const DebugPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DebugPage> createState() => DebugPageState();
}

class DebugPageState extends ConsumerState<DebugPage> {
  @override
  Widget build(BuildContext context) {
    return adaptivePage(
      appBar: AppBar(
        title: const Text('Debug'),
      ),
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Debug'),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const FeaturesTable(),
              SafeArea(
                bottom: false,
                child: ElevatedButton(
                  onPressed: () {
                    clearWordsStore();
                    Phoenix.rebirth(context);
                  },
                  child: const Text("clearWordsStore"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.go('/ads');
                },
                child: const Text("go to ads previews"),
              ),
              ElevatedButton(
                  onPressed: () {
                    ProgressController.stateProvider =
                        StateNotifierProvider<ProgressController, ProgressData>(
                            (ref) {
                      return ProgressController(
                          provider: PreviewStoreProgressProvider());
                    });

                    RestartWidget.restartApp(context);
                  },
                  child: const Text("set preview Data")),
              ElevatedButton(
                  onPressed: () async {
                    invitingCongretulationView(context);
                  },
                  child: const Text("test inviting view")),
              ElevatedButton(
                onPressed: () {
                  addProgress(ref);
                },
                child: const Text("Fill progress"),
              ),
              ElevatedButton(
                onPressed: () {
                  testSetUserData(ref);
                },
                child: const Text("Print state"),
              ),
              ElevatedButton(
                onPressed: () {
                  var word1 = const SizedBox(
                    key: ValueKey('1996'),
                  );
                  var word2 = const SizedBox(
                    key: ValueKey('1996'),
                  );

                  List<Widget> list = [word1, word2];
                  List<Widget> list2 = [word1, word2];
                  lv6(word1.key == word2.key);
                  lv6(list[0] == list2[0]);
                  lv6((const ValueKey('1996') == const ValueKey('1997'))
                      .toString());
                },
                child: const Text("equal words"),
              ),
              ElevatedButton(
                onPressed: () {
                  Notifications.cancelAll();
                },
                child: const Text("cancelAll!"),
              ),
              const WordsForChooseTest(),
              ClipPath(
                clipper: TsClip1(),
                child: Container(
                  width: double.infinity,
                  height: 500,
                  color: Colors.amberAccent,
                ),
              ),
              ClipPath(
                clipper: TsClip2(),
                child: Container(
                  width: double.infinity,
                  height: 400,
                  color: Colors.redAccent,
                ),
              ),
              FractionalTranslation(
                  translation: const Offset(.5, .5),
                  child: Container(
                      color: Colors.greenAccent, width: 100, height: 100)),
              Container(color: Colors.blue, width: 100, height: 100),
              FractionalTranslation(
                  translation: const Offset(-.5, -.5),
                  child:
                      Container(color: Colors.yellow, width: 100, height: 100)),
              FractionalTranslation(
                  translation: const Offset(0, -.5),
                  child:
                      Container(color: Colors.purple, width: 100, height: 100)),
              const AboutDialog(
                applicationName: "applicationName",
                applicationVersion: "applicationVersion",
                applicationIcon: Icon(Icons.ac_unit),
                applicationLegalese: "applicationLegalese",
                children: [
                  Text("children"),
                ],
              ),
              CupertinoFormSection.insetGrouped(children: [
                CupertinoFormRow(
                  child: Container(color: Colors.blue, width: 100, height: 100),
                ),
                CupertinoFormRow(
                  child: Container(color: Colors.blue, width: 100, height: 100),
                ),
              ]),
              SizedBox(height: 80.h, child: const TestList()),
              OutlinedButton(
                  onPressed: () {}, child: const Text("showOverlay")),
            ],
          ),
        ),
      ),
    );
  }
}

class TestList extends StatefulWidget {
  const TestList({Key? key}) : super(key: key);

  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70.h,
          child: const ColoredBox(
            color: Colors.white,
            child: CustomAnimatedList(),
          ),
        ),
      ],
    );
  }
}

class CustomAnimatedList extends StatefulWidget {
  const CustomAnimatedList({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAnimatedList> createState() => CustomAnimatedListState();
}

class CustomAnimatedListState extends State<CustomAnimatedList>
    with CustomAnimatedListDelegate {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            insertItemAt(
              index: 0,
              item: Container(
                color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0),
                width: 30,
                height: 30,
              ),
            );
          },
          child: const Text("insertItem"),
        ),
        ElevatedButton(
          onPressed: () async {
            await removeItemAt(
              duration: const Duration(milliseconds: 70),
              index: items.length - 1,
              builder: (context, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: items.removeAt(items.length - 1),
                );
              },
            );

          },
          child: const Text("removeItem"),
        ),
        ElevatedButton(
          onPressed: () async {
            await deleteAll(
              builder: (index, child, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: child,
                );
              },
              durations: (i, len) => const Duration(milliseconds: 10),
            );
          },
          child: const Text("removeAllrecursive"),
        ),
        ElevatedButton(
          onPressed: () {
            addFew();
          },
          child: const Text("addFew"),
        ),
        ElevatedButton(
          onPressed: () async {
            await deleteAll(
              builder: (index, child, animation) => SizeTransition(
                sizeFactor: animation,
                child: child,
              ),
              durations: (i, len) => const Duration(milliseconds: 100),
            );
            [
              Container(
                color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0),
                width: 30,
                height: 30,
              ),
              Container(
                color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0),
                width: 30,
                height: 30,
              ),
              Container(
                color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0),
                width: 30,
                height: 30,
              ),
              Container(
                color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0),
                width: 30,
                height: 30,
              ),
              Container(
                color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0),
                width: 30,
                height: 30,
              ),
            ];

            for (var item in items) {
              insertItemAt(index: 0, item: item);
            }
          },
          child: const Text("emulate scenarii"),
        ),
        SizedBox(
          height: 40.h,
          child: ColoredBox(
            color: Colors.white,
            child: AnimatedList(
              initialItemCount: items.length,
              key: listKey,
              itemBuilder: (context, index, animation) {
                animation.addStatusListener((status) {});
                return SizeTransition(
                  sizeFactor: animation,
                  child: items[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class TsClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final h = size.height;
    final w = size.width;
    var p = Path();

    p.lineTo(0, size.height - 100);
    p.lineTo(size.width / 2, size.height);
    p.lineTo(size.width, size.height - 100);
    p.lineTo(size.width, 0);

    const rx = .9;
    const ry = .1;

    p.quadraticBezierTo(
      w * (rx + (1 - rx) / 1),
      h * .1,
      w * rx,
      h * ry,
    );
    p.lineTo(w * (1 - rx), h * ry);
    p.quadraticBezierTo(
      w * ((1 - rx) - (1 - rx) / 1),
      h * .1,
      0,
      0,
    );
    p.close();
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class TsClip1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    path.quadraticBezierTo(
        size.width / 3, size.height - 300, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WordsForChooseTest extends StatefulWidget {
  const WordsForChooseTest({Key? key}) : super(key: key);

  @override
  State<WordsForChooseTest> createState() => _WordsForChooseTestState();
}

class _WordsForChooseTestState extends State<WordsForChooseTest> {
  final words = {
    for (var i = 0; i < 100; i++)
      Word(
          wordID: "testword$i",
          english: "english$i",
          ruTranslate: "ruTranslate",
          engTranscription: "engTranscription",
          assotiation: "assotiation",
          ruTranscription: "ruTranscription",
          isImaged: false)
  };
  var choosen = <Word>[];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var word in choosen) Text(word.wordID),
        WordsForChoose(
            words: words,
            tapHandler: (word) {
              setState(() {
                choosen.add(word);
                words.remove(word);
              });
            }),
      ],
    );
  }
}
