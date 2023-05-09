part of 'widget_expanded_card.dart';

class _Underline extends StatelessWidget {
  const _Underline();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 20,
      right: 0,
      child: const SizedBox().decorated(
        border: Border(
          bottom: BorderSide(
            color: context.appColors.separator,
            width: .5,
          ),
        ),
      ),
    );
  }
}
