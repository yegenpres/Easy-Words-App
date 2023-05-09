part of 'widget_expanded_card.dart';

mixin _InnerAnimation on State<ExpandedCard> {
  final _innerDuration = const Duration(milliseconds: 600);

  late final AnimationController _innerAnimation;

  late final Color backgroundColor;
  final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  final _alignmentTween = AlignmentTween(
      begin: const Alignment(-1, -1), end: const Alignment(1, 1));
  final _alignmentTweenNotImaged = AlignmentTween(
      begin: const Alignment(-1, -1), end: const Alignment(0, 0));

  late final Animatable<double> _heightTween;
  late Animation<Offset> trsAnimation;

  late Animation<Alignment> _align;
  late Animation<double> _heightFactor;
  late Animation<double> _fontSize;
  late Animation<Color?> _titleBackground;
  late Animation<Color?> _titleFontColor;

  void _setupInnerAnimation() {
    _heightFactor = _innerAnimation.drive(_easeInTween.chain(_heightTween));
    _align = _innerAnimation.drive(
      widget._word.isImaged
          ? _alignmentTween.chain(_easeInTween)
          : _alignmentTweenNotImaged.chain(_easeInTween),
    );
  }

  @override
  void initState() {
    _heightTween = Tween<double>(begin: 0.0, end: 1);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final ColorTween colorTweenBackground =
        ColorTween(begin: context.appColors.cardColor, end: Colors.transparent);
    _titleBackground = colorTweenBackground.animate(_innerAnimation);

    final ColorTween colorTweenTitleFont =
        ColorTween(begin: context.appColors.text, end: CupertinoColors.white);
    _titleFontColor = colorTweenTitleFont.animate(_innerAnimation);

    final Animatable<double> fontSizeTween =
        Tween<double>(begin: context.appGeometry.textSize, end: 30);
    _fontSize = _innerAnimation.drive(fontSizeTween.chain(_easeInTween));

    trsAnimation = Tween<Offset>(
      begin: const Offset(
        0,
        20,
      ),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _innerAnimation,
        curve: const Interval(.5, 1),
      ),
    );
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ExpandedCard oldWidget) {
    if (oldWidget.isExpanded != widget.isExpanded) {
      if (widget.isExpanded) {
        _innerAnimation.forward();
      } else {
        _innerAnimation.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }
}
