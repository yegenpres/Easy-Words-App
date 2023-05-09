class CardDelegate {
  Position position;
  late bool isExpanded;
  final int index;
  late bool topBorder, bottomBorder, underline;
  final void Function() handler;

  CardDelegate({
    required this.isExpanded,
    required this.index,
    required this.topBorder,
    required this.bottomBorder,
    required underline,
    required this.position,
    required this.handler,
  }) : underline = position == Position.single ? false : underline;

  CardDelegate.expanded({
    required this.index,
    required this.position,
    required this.handler,
  }) {
    expand();
  }

  CardDelegate.shrinked({
    required this.index,
    required this.position,
    required this.handler,
  }) {
    shrink();
  }

  void becomeFirst() {
    position = Position.first;
    if (!isExpanded) {
      topBorder = true;
    }
  }

  void becomeLast() {
    position = Position.last;
    if (!isExpanded) {
      bottomBorder = true;
    }
  }

  void becomeMiddle() {
    position = Position.middle;
  }

  void expand() {
    isExpanded = true;
    bottomBorder = true;
    topBorder = true;
    underline = false;
  }

  void shrink() {
    isExpanded = false;

    switch (position) {
      case Position.first:
        {
          topBorder = true;
          bottomBorder = false;
          underline = true;
          break;
        }
      case Position.middle:
        {
          topBorder = false;
          bottomBorder = false;
          underline = true;
          break;
        }
      case Position.last:
        {
          topBorder = false;
          bottomBorder = true;
          underline = false;
          break;
        }
      case Position.single:
        {
          topBorder = true;
          bottomBorder = true;
          underline = false;
          break;
        }
    }
  }

  void bottomCorners({required bool isRounded}) {
    bottomBorder = isRounded;
  }

  void topCorners({required bool isRounded}) {
    topBorder = isRounded;
  }

  @override
  String toString() {
    return "index: $index isExpanded: $isExpanded topBorder: $topBorder bottomBorder $bottomBorder underline: $underline position: $position";
  }
}

enum Position {
  first,
  middle,
  last,
  single,
}
