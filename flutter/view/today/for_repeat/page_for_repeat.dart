import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wordsapp/_widgets/utils.dart';

class WordsForRepeatList extends StatefulWidget {
  final bool newWordsAvailable;
  final List<Widget> children;
  final void Function() onRepeatCallback;
  const WordsForRepeatList(
      {super.key,
      required this.children,
      required this.onRepeatCallback,
      required this.newWordsAvailable});

  @override
  State<WordsForRepeatList> createState() => _WordsForRepeatListState();
}

class _WordsForRepeatListState extends State<WordsForRepeatList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double? _listOffset;

  void _fitHeight(double height) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _listOffset = height;
      });
    });
  }

  double get maxHeight {
    if (_listOffset == null) return 100.h;
    if (_listOffset! < 100.h) return 100.h;
    return (_listOffset! + 20.h) * _controller.value;
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 2000,
        ));
    _controller.value = 1;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (!widget.newWordsAvailable) return false;

        if (notification.metrics.maxScrollExtent == 0 ||
            notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
          Future.delayed(const Duration(seconds: 1), () {
            if (!mounted) return false;

            _controller.reverse().whenCompleteOrCancel(() {
              widget.onRepeatCallback();
            });
          });
        }

        return false;
      },
      child: AdaptiveScrollBar(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) => LimitedBox(
              maxHeight: maxHeight,
              child: child,
            ),
            child: SafeArea(
              bottom: false,
              child: Flow(
                delegate: _TestForRepeatFLowDelegate(
                  onFitHeight: _fitHeight,
                  animation: _controller,
                  animations: [
                    for (var i = 1; i <= widget.children.length; i++)
                      Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: Interval(
                            i / (widget.children.length * 3),
                            i / (widget.children.length),
                            curve: Curves.easeInOut,
                          ),
                        ),
                      ),
                  ],
                ),
                children: [
                  ...widget.children,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TestForRepeatFLowDelegate extends FlowDelegate {
  final Animation<double> animation;
  final List<Animation<double>> animations;
  void Function(double height) onFitHeight;

  _TestForRepeatFLowDelegate(
      {required this.animation,
      required this.animations,
      required this.onFitHeight})
      : super(repaint: animation);

  double calculateCurrentOffset(int i, Size? Function(int value) calculation) {
    double result = 0;

    for (var j = i - 1; j >= 0; j--) {
      result += calculation(j)!.height;
    }

    return result;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = context.childCount - 1; i >= 0; i--) {
      final value = animations[i].value;
      final offset = calculateCurrentOffset(i, context.getChildSize);

      context.paintChild(
        i,
        transform:
            Matrix4.translationValues(40.w * (1 - value), offset * value, 0)
              ..scale(0.2 + 0.8 * value),
        opacity: value < .3 ? value : 1,
      );
    }

    onFitHeight(
        calculateCurrentOffset(context.childCount, context.getChildSize));
  }

  @override
  bool shouldRepaint(_TestForRepeatFLowDelegate oldDelegate) {
    return animation.value != oldDelegate.animation.value;
  }
}
