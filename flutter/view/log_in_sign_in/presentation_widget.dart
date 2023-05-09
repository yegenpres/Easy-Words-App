import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:sizer/sizer.dart';
import 'package:wordsapp/_widgets/cards/widget_card.dart';
import 'package:wordsapp/_widgets/utils.dart';
import 'package:wordsapp/extensions.dart';
import 'package:wordsapp/features/word/word.dart';
import 'package:wordsapp/generated/l10n.dart';
import 'package:wordsapp/test_words.dart';
import 'package:wordsapp/view/privacy_policy.dart';
import 'package:wordsapp/view_model/first_launch.dart';

class PresentationWidget extends StatelessWidget {
  const PresentationWidget({super.key});

  static Word word(int i) {
    return testWords.elementAt(i);
  }

  static Widget card(int i, bool isImaged) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CardWord.big(
        word: Word(
            wordID: word(i).wordID,
            english: word(i).english,
            ruTranslate: word(i).ruTranslate,
            engTranscription: word(i).engTranscription,
            assotiation: word(i).assotiation,
            ruTranscription: word(i).ruTranscription,
            isImaged: isImaged,
            imageProvider: word(i).imageProvider),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      child: Material(
        color: Colors.transparent,
        child: InViewNotifierList(
          initialInViewIds: const ["0", "1"],
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double vpHeight) {
            return deltaTop < (0.8 * vpHeight) && deltaBottom > (0 * vpHeight);
          },
          itemCount: testWords.length + 1,
          builder: (BuildContext context, int index) {
            if (index == 0) {
              return Intro(
                words: testWords.map((e) => e.english).toList(),
              );
            }
            if (index == testWords.length) {
              return const UserInviting();
            }
            return InViewNotifierWidget(
              id: '$index',
              builder: (BuildContext context, bool isInView, Widget? child) {
                return AnimatedScale(
                  scale: isInView ? 1 : .6,
                  duration: const Duration(milliseconds: 500),
                  child: child,
                );
              },
              child: PresentationWidget.card(index, index.isOdd),
            );
          },
        ),
      ),
    );
  }
}

class Intro extends StatelessWidget {
  final List<String> words;
  const Intro({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              S.of(context).presentationChoseWordsForLearn,
              style: TextStyle(color: context.appColors.text),
            ),
          ),
          Transform.rotate(
            angle: -.2,
            child: FractionalTranslation(
              translation: const Offset(0.3, .5),
              child: Chip(label: Text(words[0])),
            ),
          ),
          Transform.rotate(
            angle: 0.4,
            child: FractionalTranslation(
              translation: const Offset(0.0, 1.7),
              child: Chip(label: Text(words[1])),
            ),
          ),
          Transform.rotate(
            angle: .7,
            child: FractionalTranslation(
              translation: const Offset(-1.2, -.8),
              child: Chip(label: Text(words[2])),
            ),
          ),
          Transform.rotate(
            angle: -.3,
            child: FractionalTranslation(
              translation: const Offset(2, -.5),
              child: Chip(label: Text(words[3])),
            ),
          ),
          Text(
            S.of(context).presentationAndScrollDown,
            style: TextStyle(color: context.appColors.text),
          ),
          SizedBox(height: 3.h),
          const Arrow(),
          const Arrow(),
          const Arrow(),
        ],
      ),
    );
  }
}

class Arrow extends StatefulWidget {
  const Arrow({Key? key}) : super(key: key);

  @override
  State<Arrow> createState() => _ArrowState();
}

class _ArrowState extends State<Arrow> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  final scaleTween = Tween<double>(begin: .6, end: 1.3);
  late final Animation<double> scale;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    scale = controller.drive(scaleTween);
    controller
      ..forward()
      ..addListener(() {
        if (controller.isCompleted) {
          controller.reverse();
        } else if (controller.isDismissed) {
          controller.forward();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: Transform.rotate(
          angle: 4.67, child: const Icon(Icons.arrow_back_ios_new)),
    );
  }
}

class UserInviting extends ConsumerWidget {
  const UserInviting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Text(
            S.of(context).presentationSubscribeToContinue,
            style: TextStyle(color: context.appColors.text),
          ),
          SizedBox(
            height: 3.h,
          ),
          ElevatedButton(
              onPressed: () {
                AppTrackingTransparency.requestTrackingAuthorization();

                ref.read(FirstLaunchDetector.firstLaunchComplete)();
              },
              child: Text(S.of(context).presentationNext)),
          const PolicyasAndTerms(),
        ],
      ),
    );
  }
}
