part of 'widget_expanded_card.dart';

class _AssociationText extends StatelessWidget {
  final String text;
  const _AssociationText({required this.text});

  static RichText _associationText(String assotiation, Color color) {
    final associationArr = assotiation.split('');
    List<TextSpan> finalText = [];

    for (var i = 0; i < associationArr.length; i++) {
      final piece = associationArr[i];
      TextSpan parsedPiece;

      RegExp regExp = RegExp(r'^[А-Я]$');
      bool isUppercase = regExp.hasMatch(piece);

      if (isUppercase) {
        parsedPiece = TextSpan(
          text: piece,
          style: TextStyle(color: color),
        );
      } else {
        parsedPiece = TextSpan(
          text: i == 0 ? piece.toUpperCase() : piece,
          style: TextStyle(color: Colors.grey.shade600),
        );
      }

      finalText.add(parsedPiece);
    }

    return RichText(
      text: TextSpan(
        children: finalText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.zero,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: platformSelector(
                material: context.appColors.cardColor,
                cupertino: context.appColors.cardColor.withOpacity(.7),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, platformSelector(material: 20, cupertino: 5), 10, 10),
              child: _associationText(text, context.coloredPrimaryText),
            ),
          ),
        ),
      ),
    );
  }
}
