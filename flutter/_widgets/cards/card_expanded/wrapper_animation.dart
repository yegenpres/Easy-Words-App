part of 'widget_expanded_card.dart';

mixin _WrapperAnimation on State<ExpandedCard> {
  final _wrapperDuratio = const Duration(milliseconds: 600);

  late final AnimationController _topBorderController;
  late final AnimationController _bottomBorderController;

  final Animatable<double> _borderRadiusTween =
      Tween<double>(begin: 0, end: 11);

  late Animation<double> _borderRadiusTop;
  late Animation<double> _borderRadiusBottom;

  final Animatable<double> _paddingTween = Tween<double>(begin: 0, end: 7);

  late Animation<double> _paddingTop;
  late Animation<double> _paddingBottom;

  void _setupWrapperAnimation() {
    _borderRadiusTop = _borderRadiusTween.animate(CurvedAnimation(
        parent: _topBorderController, curve: const Interval(0, 0.6)));
    _borderRadiusBottom = _borderRadiusTween.animate(CurvedAnimation(
        parent: _bottomBorderController, curve: const Interval(0, 0.6)));

    _paddingTop = _paddingTween.animate(CurvedAnimation(
        parent: _topBorderController, curve: const Interval(0.4, 1)));
    _paddingBottom = _paddingTween.animate(CurvedAnimation(
        parent: _bottomBorderController, curve: const Interval(0.4, 1)));
  }

  void _wrapperAnimation(Duration duration) {
    final forvardDuration = Duration(milliseconds: duration.inMilliseconds);
    final reverseDuration = Duration(milliseconds: duration.inMilliseconds);

    if (widget.topBorder) {
      _topBorderController.animateTo(1, duration: forvardDuration);
    } else {
      _topBorderController.animateTo(0, duration: reverseDuration);
    }

    if (widget.bottomBorder) {
      _bottomBorderController.animateTo(1, duration: forvardDuration);
    } else {
      _bottomBorderController.animateTo(0, duration: reverseDuration);
    }
  }

  @override
  void didUpdateWidget(ExpandedCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.topBorder != widget.topBorder ||
        oldWidget.bottomBorder != widget.bottomBorder) {
      _wrapperAnimation(_wrapperDuratio);
    }
  }
}
