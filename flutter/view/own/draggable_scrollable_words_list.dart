import 'package:flutter/cupertino.dart';
import 'package:wordsapp/extensions.dart';

class DraggableScrollableWordsList extends StatefulWidget {
  final List<Widget> children;
  final void Function(DraggableScrollableController)? controllerListener;
  const DraggableScrollableWordsList(
      {super.key, required this.children, this.controllerListener});

  @override
  State<DraggableScrollableWordsList> createState() =>
      _DraggableScrollableWordsListState();
}

class _DraggableScrollableWordsListState
    extends State<DraggableScrollableWordsList> {
  final DraggableScrollableController controller =
      DraggableScrollableController();

  @override
  void initState() {
    controller.addListener(() {
      if (widget.controllerListener != null) {
        widget.controllerListener!(controller);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DraggableScrollableSheet(
        controller: controller,
        maxChildSize: 0.9,
        initialChildSize: .75,
        builder: (context, scrollController) {
          return PhysicalModel(
            clipBehavior: Clip.hardEdge,
            color: context.appColors.draggableLIst,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20), bottom: Radius.circular(20)),
            child: Stack(
              children: [
                ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  controller: scrollController,
                  children: widget.children,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
