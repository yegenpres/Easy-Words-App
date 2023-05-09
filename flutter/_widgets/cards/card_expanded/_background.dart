part of 'widget_expanded_card.dart';

class _Background extends StatelessWidget {
  final double visibility;
  final Color backgroundColor;
  const _Background({required this.visibility, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Opacity(
        opacity: visibility,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topCenter,
              stops: const [0.4, 1],
              colors: [
                backgroundColor,
                context.appColors.backgroundCardCorner,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
