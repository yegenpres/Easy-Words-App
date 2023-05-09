import 'package:flutter/material.dart';

class AnimatedIconExpand extends StatefulWidget {
  final bool expanded;

  const AnimatedIconExpand(
    this.expanded, {
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedIconExpand> createState() => _AnimatedIconExpandState();
}

class _AnimatedIconExpandState extends State<AnimatedIconExpand>
    with SingleTickerProviderStateMixin {
  late Animation<double> _myAnimation;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _myAnimation = CurvedAnimation(curve: Curves.linear, parent: _controller);
  }

  @override
  void didUpdateWidget(covariant AnimatedIconExpand oldWidget) {
    if (widget.expanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedIcon(icon: AnimatedIcons.view_list, progress: _myAnimation);
  }
}
