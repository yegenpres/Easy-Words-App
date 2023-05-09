import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordsapp/extensions.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Widget child;

  const AdaptiveScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS || Platform.isIOS) {
      return CupertinoPageScaffold(child: child);
    } else {
      return Scaffold(body: child);
    }
  }
}

class AdaptiveScrollBar extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;
  const AdaptiveScrollBar({Key? key, required this.child, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return platformSelector(
      material: Scrollbar(
        controller: controller,
        child: child,
      ),
      cupertino: CupertinoScrollbar(
        controller: controller,
        child: child,
      ),
    );
  }
}

Widget adaptivePage(
    {Key? key,
    required Widget child,
    PreferredSizeWidget? appBar,
    ObstructingPreferredSizeWidget? navigationBar}) {
  if (Platform.isMacOS || Platform.isIOS) {
    return CupertinoPageScaffold(
      key: key,
      navigationBar: navigationBar,
      child: child,
    );
  } else {
    return Scaffold(key: key, body: child, appBar: appBar);
  }
}

class IOSScrollSafeArea extends StatelessWidget {
  final int index;
  final int lenght;
  final Widget child;
  final bool isReversed;
  const IOSScrollSafeArea(
      {super.key,
      required this.child,
      this.index = 0,
      this.lenght = 1,
      this.isReversed = false});

  Widget _build(BuildContext context) {
    if (Platform.isIOS) {
      return SafeArea(
        top: index == 0 ? true : false,
        bottom: index == lenght - 1 ? true : false,
        child: child,
      );
    }
    return child;
  }

  Widget _buildReversed(BuildContext context) {
    if (Platform.isIOS) {
      return SafeArea(
        bottom: index == 0 ? true : false,
        top: index == lenght - 1 ? true : false,
        child: child,
      );
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return isReversed ? _buildReversed(context) : _build(context);
  }
}

class BouncedWrapper extends StatefulWidget {
  final Widget card;

  const BouncedWrapper({Key? key, required this.card}) : super(key: key);

  @override
  State<BouncedWrapper> createState() => _BouncedWrapperState();
}

class _BouncedWrapperState extends State<BouncedWrapper> {
  double _scale = 1;

  void _onScale([TapDownDetails? details]) => setState(() {
        _scale = 0.97;
      });
  void _onScaleCansel([TapUpDetails? details]) => setState(() {
        _scale = 1;
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: _onScale,
        onTapUp: _onScaleCansel,
        onTapCancel: _onScaleCansel,
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 200),
          child: widget.card,
        ));
  }
}

class CupertinoBlure extends StatelessWidget {
  final double sigmaX, sigmaY, topRadius, bottomRadius;
  final Widget child;
  final double radius;

  const CupertinoBlure({
    Key? key,
    required this.child,
    this.radius = 0,
    this.sigmaX = 10,
    this.sigmaY = 15,
    this.bottomRadius = 0,
    this.topRadius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: ClipRRect(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(topRadius),
              bottom: Radius.circular(bottomRadius)),
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: sigmaX, sigmaY: sigmaY, tileMode: TileMode.mirror),
            child: const ColoredBox(color: Colors.transparent),
          ),
        )),
        child,
      ],
    );
  }
}

mixin CustomAnimatedListDelegate {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final ScrollController controller = ScrollController();

  bool inProcess = false;

  Future<bool> deleteTask(
    int index,
    void Function() onCompleted,
    Widget Function(int index, Widget child, Animation<double> animation)
        builder,
    Duration duration,
  ) {
    listKey.currentState!.removeItem(
      index,
      (context, animation) {
        animation.addStatusListener((status) {
          if (status == AnimationStatus.dismissed) {
            onCompleted();
          }
        });

        return builder(index, items.removeAt(index), animation);
      },
      duration: duration,
    );

    return Future.delayed(duration, () => true);
  }

  var items = <Widget>[];

  var len = 0;

  bool insertItemAt({
    required int index,
    required Widget item,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    if (inProcess) return false;

    items.insert(index, item);
    listKey.currentState!.insertItem(index, duration: duration);
    len = items.length;
    return true;
  }

  Future<bool> deleteAll({
    required Widget Function(
            int index, Widget child, Animation<double> animation)
        builder,
    required Duration Function(int index, int len) durations,
  }) async {
    removeOne() {
      listKey.currentState!.removeItem(
        items.length - 1,
        duration: durations(items.length - 1, len),
        (context, animation) => builder(
          items.length - 1,
          items.removeAt(items.length - 1),
          animation,
        ),
      );
    }

    if (items.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));

      inProcess = false;
      return Future.value(true);
    }
    inProcess = true;
    removeOne();
    await Future.delayed(Duration(
        milliseconds: durations(items.length - 1, len).inMilliseconds + 80));

    return deleteAll(builder: builder, durations: durations);
  }

  Future<bool> removeItemAt({
    required int index,
    Duration duration = const Duration(seconds: 1),
    required Widget Function(BuildContext context, Animation<double> animation)
        builder,
  }) async {
    if (inProcess) return Future.value(false);

    inProcess = true;

    try {
      listKey.currentState!.removeItem(
          index,
          duration: duration,
          (context, animation) => builder(context, animation));
    } catch (e) {
      inProcess = false;
    }

    return Future.delayed(Duration(milliseconds: duration.inMilliseconds + 70),
        () {
      len = items.length;
      inProcess = false;
      return true;
    });
  }

  bool addFew() {
    if (inProcess) return false;

    for (var i = 0; i < 3; i++) {
      items.insert(
          i,
          Container(
            color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0),
            width: 30,
            height: 30,
          ));
      listKey.currentState!.insertItem(0);
      // _items.removeLast();
    }
    return true;
  }
}
