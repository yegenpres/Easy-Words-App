import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:wordsapp/extensions.dart';
import 'package:wordsapp/features/create_own_word/controller_own_words.dart';
import 'package:wordsapp/generated/l10n.dart';
import 'package:wordsapp/view/own/words_tamplates_selector.dart';
import 'package:wordsapp/view_model/create_own_state.dart';

class CommonWords extends ConsumerStatefulWidget {
  const CommonWords({super.key});

  @override
  ConsumerState<CommonWords> createState() => _CommonWordsState();
}

class _CommonWordsState extends ConsumerState<CommonWords> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  String _query = "";

  @override
  void initState() {
    _textController.addListener(() {
      _query = _textController.text;
    });
    super.initState();
  }

  Widget buildPart(String part) => Padding(
        padding: const EdgeInsets.all(3.0),
        child: Chip(
          label: Text(part),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final hintText = S.of(context).find_by_part;
    final noCommonWords = S.of(context).Cant_find_any_common_words;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0),
          child: TextField(
            style: TextStyle(color: context.appColors.text),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: context.appColors.hinText),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: ControlButtons(
                  leadingHandler: () {
                    ref
                        .read(OwnWordsController.stateProvider.notifier)
                        .findLeading(_query);
                  },
                  middleHandler: () {
                    ref
                        .read(OwnWordsController.stateProvider.notifier)
                        .findMiddle(_query);
                  },
                  trailingHandler: () {
                    ref
                        .read(OwnWordsController.stateProvider.notifier)
                        .findTrailing(_query);
                  },
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(20),
            ),
            textAlign: TextAlign.center,
            controller: _textController,
          ),
        ),
        SizedBox(
          height: 6.h,
          width: 100.w,
          child: Scrollbar(
            controller: _scrollController,
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: ref.watch(CreateOwnViewModel.commonWords).maybeWhen(
                  successData: (data) {
                    return data.map((part) => buildPart(part)).toList();
                  },
                  empty: () => [Text(noCommonWords)],
                  loading: () => [
                        Padding(
                          padding: EdgeInsets.only(left: 50.w),
                          child: Center(
                            child: platformSelector(
                              material: const CircularProgressIndicator(),
                              cupertino: const CupertinoActivityIndicator(),
                            ),
                          ),
                        )
                      ],
                  initialData: () => [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Center(
                            child: Text(
                              S.of(context).query,
                              style:
                                  TextStyle(color: context.appColors.hinText),
                            ),
                          ),
                        )
                      ],
                  orElse: () {
                    return [const SizedBox()];
                  }),
            ),
          ),
        ),
      ],
    );
  }
}

typedef Handler = void Function();

class ControlButtons extends ConsumerWidget {
  final Handler leadingHandler;
  final Handler middleHandler;
  final Handler trailingHandler;

  const ControlButtons(
      {required this.leadingHandler,
      required this.middleHandler,
      required this.trailingHandler,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
      child: Row(
        children: [
          Button.custom(
              handler: trailingHandler, child: [Text(S.of(context).Abc)]),
          Button.custom(
              handler: middleHandler, child: [Text(S.of(context).a_bc_)]),
          Button.custom(
              handler: leadingHandler, child: [Text(S.of(context).abc_)]),
        ],
      ),
    );
  }
}
