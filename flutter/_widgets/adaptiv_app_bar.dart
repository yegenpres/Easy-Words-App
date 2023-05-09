import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class AdaptiveAppBar extends StatefulWidget {
  final Widget? middle;
  final Widget? trailing;
  final Widget? largeTitle;
  final Widget? leftButton;

  const AdaptiveAppBar({
    super.key,
    this.middle,
    this.trailing,
    this.largeTitle,
    this.leftButton,
  });

  @override
  State<AdaptiveAppBar> createState() => _AdaptiveAppBarState();
}

class _AdaptiveAppBarState extends State<AdaptiveAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverStack(
      insetOnOverlap: true,
      positionedAlignment: Alignment.centerLeft,
      children: [
        if (Platform.isIOS)
          CupertinoSliverNavigationBar(
            middle: widget.middle,
            trailing: widget.trailing,
            largeTitle: widget.largeTitle,
          ),
        if (Platform.isAndroid)
          SliverAppBar(
            title: widget.middle,
            actions: [widget.trailing!],
            flexibleSpace: widget.largeTitle,
          ),
        SliverPinnedHeader(
            child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 50),
          child: widget.leftButton,
        )),
      ],
    );
  }
}

class AdaptiveAppBar2 extends StatefulWidget {
  final Widget? middle;
  final Widget? trailing;
  final Widget? largeTitle;
  final Widget? leftButton;

  const AdaptiveAppBar2({
    super.key,
    this.middle,
    this.trailing,
    this.largeTitle,
    this.leftButton,
  });

  @override
  State<AdaptiveAppBar2> createState() => _AdaptiveAppBarState2();
}

class _AdaptiveAppBarState2 extends State<AdaptiveAppBar2> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoSliverNavigationBar(
        middle: widget.middle,
        trailing: widget.trailing,
        largeTitle: widget.largeTitle,
      );
    } else {
      return SliverAppBar(
        title: widget.middle,
        actions: [widget.trailing!],
        flexibleSpace: widget.largeTitle,
      );
    }
  }
}
