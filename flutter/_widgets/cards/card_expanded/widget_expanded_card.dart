import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:wordsapp/_widgets/cards/Image_container.dart';
import 'package:wordsapp/_widgets/cards/adaptive_colors.dart';
import 'package:wordsapp/_widgets/cards/card_delegate.dart';
import 'package:wordsapp/extensions.dart';
import 'package:wordsapp/features/word/word.dart';
import 'package:wordsapp/view/my_words/page_progress_list.dart';

part '_associationText.dart';
part '_background.dart';
part '_title.dart';
part '_underline.dart';
part 'inner_animation.dart';
part 'wrapper_animation.dart';

// ignore: must_be_immutable
class ExpandedCard extends StatefulWidget {
  final bool isImaged;
  final bool bottomBorder;
  final bool topBorder;
  final bool underline;
  final Word _word;
  final void Function() _handler;
  bool isExpanded;

  ExpandedCard({
    Key? key,
    required Word word,
    this.isExpanded = false,
    this.bottomBorder = true,
    this.topBorder = true,
    this.underline = true,
  })  : _handler = (() {}),
        _word = word,
        isImaged = word.isImaged,
        super(key: key ?? ValueKey(word.wordID));

  ExpandedCard.grouped({
    Key? key,
    required Word word,
    required CardDelegate delegate,
  })  : isExpanded = delegate.isExpanded,
        _handler = delegate.handler,
        _word = word,
        bottomBorder = delegate.bottomBorder,
        topBorder = delegate.topBorder,
        underline = delegate.underline,
        isImaged = word.isImaged,
        super(key: key ?? ValueKey(word.wordID));

  @override
  State<ExpandedCard> createState() => _ExpandedCardState();
}

class _ExpandedCardState extends State<ExpandedCard>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<ExpandedCard>,
        _WrapperAnimation,
        _InnerAnimation {
  @override
  bool get wantKeepAlive {
    bool? globalExpand =
        context.findAncestorStateOfType<ProgressListState>()?.isExpanded;
    if (widget.isExpanded == globalExpand) return false;
    return true;
  }

  late final Animation<double> ratio;

  @override
  void initState() {
    super.initState();
    backgroundColor = AdaptiveColors.getOrdered(widget._word.wordID);
    _innerAnimation = AnimationController(
      duration: _innerDuration,
      vsync: this,
    );

    final Animatable<double> ratioTween =
        Tween<double>(begin: 4 / .5, end: widget.isImaged ? 4 / 4.9 : 4 / 2.5);
    ratio = _innerAnimation.drive(ratioTween.chain(_easeInTween));

    _topBorderController = AnimationController(
      vsync: this,
      duration: _innerDuration,
    );
    _bottomBorderController = AnimationController(
      vsync: this,
      duration: _innerDuration,
    );

    _setupInnerAnimation();
    _setupWrapperAnimation();

    const duration = Duration(microseconds: 1);
    if (widget.isExpanded) {
      _innerAnimation.animateTo(1, duration: duration);
      _topBorderController.animateTo(1, duration: duration);
      _bottomBorderController.animateTo(1, duration: duration);
    }

    _wrapperAnimation(duration);
  }

  @override
  void dispose() {
    _innerAnimation.dispose();
    _topBorderController.dispose();
    _bottomBorderController.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      widget.isExpanded = !widget.isExpanded;
      if (widget.isExpanded) {
        _innerAnimation.forward();
      } else {
        _innerAnimation.reverse();
      }
      _wrapperAnimation(_wrapperDuratio);

      widget._handler();
    });
  }

  Widget _wrapper(BuildContext context, Widget? child) {
    return Padding(
      padding:
          EdgeInsets.only(top: _paddingTop.value, bottom: _paddingBottom.value),
      child: PhysicalModel(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(_borderRadiusTop.value),
          bottom: Radius.circular(_borderRadiusBottom.value),
        ),
        color: context.appColors.cardColor,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _build(context, child),
            if (widget.underline) const _Underline(),
          ],
        ),
      ),
    );
  }

  Widget _build(BuildContext context, Widget? child) {
    return PhysicalModel(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(0),
      color: Colors.transparent,
      // shadowColor: context.appColors.cardColor,
      // elevation: _innerAnimation.value * 6,
      child: GestureDetector(
        onTap: _handleTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: AspectRatio(
            aspectRatio: ratio.value,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _Background(
                  visibility: _innerAnimation.value,
                  backgroundColor: backgroundColor,
                ),
                ImageContainer(
                  key: ValueKey(
                      "${widget._word.wordID}imagedContainerExpandedItem"),
                  word: widget._word,
                  opacity: _innerAnimation.value,
                  scale: _innerAnimation.value,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _Title(
                      animatedValue: _innerAnimation,
                      english: widget._word.english,
                      translate: widget._word.ruTranslate,
                      background: Colors.transparent,
                      borderRadius: _innerAnimation.value,
                      titleColor: _titleFontColor.value,
                      fontSize: _fontSize.value,
                    ),
                    Align(
                      heightFactor: _heightFactor
                          .drive(CurveTween(curve: const Interval(.5, 1)))
                          .value,
                      child: SlideTransition(
                        position: trsAnimation,
                        child: _AssociationText(
                          text: widget._word.assotiation,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _innerAnimation,
          _topBorderController,
          _bottomBorderController,
        ]),
        builder: _wrapper,
      ),
    );
  }
}
