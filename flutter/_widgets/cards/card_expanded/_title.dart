part of 'widget_expanded_card.dart';

class _Title extends StatelessWidget {
  final Color? titleColor;
  final double fontSize;
  final double borderRadius;
  final Color? background;
  final String english, translate;
  final Animation<double> animatedValue;

  _Title({
    required animatedValue,
    required this.english,
    required this.translate,
    required this.background,
    required this.borderRadius,
    required this.titleColor,
    required this.fontSize,
  }) : animatedValue = animatedValue.drive(
          CurveTween(
            curve: const Interval(.5, .85),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(50 * borderRadius)),
        child: SizedBox(
          width: double.infinity,
          child: LayoutBuilder(builder: (_, c) {
            return Stack(
              children: [
                Positioned(
                    top: (c.maxHeight -
                            (c.maxHeight * (1 - animatedValue.value))) *
                        .7,
                    bottom: (c.maxHeight -
                            (c.maxHeight * (1 - animatedValue.value))) *
                        .0,
                    left: (c.maxWidth -
                            (c.maxWidth * (1 - animatedValue.value))) *
                        .1,
                    right: (c.maxWidth -
                            (c.maxWidth * (1 - animatedValue.value))) *
                        .9,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.appColors.cardColor,
                        borderRadius: BorderRadius.circular(
                          context.appGeometry.borderRadius *
                              animatedValue.value *
                              7,
                        ),
                      ),
                    )),
                Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20 + 5,
                    ),
                    child: FittedBox(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(english,
                              style: TextStyle(
                                color: titleColor,
                                fontSize: fontSize,
                                fontWeight: FontWeight.w600,
                              )),
                          Text(
                            translate,
                            style: TextStyle(
                              color: titleColor,
                              fontSize: fontSize - 2,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
