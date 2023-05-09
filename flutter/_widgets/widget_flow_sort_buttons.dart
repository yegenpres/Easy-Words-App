// class FlowSortButtons extends StatefulWidget {
//   const FlowSortButtons({Key? key}) : super(key: key);
//
//   @override
//   State<FlowSortButtons> createState() => _FlowSortButtonsState();
// }
//
// class _FlowSortButtonsState extends State<FlowSortButtons>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late final _buttons = [
//     GestureDetector(
//       onTap: _runAnimation,
//       child: const Icon(Icons.ac_unit_outlined),
//     ),
//     const Icon(Icons.accessibility_new_sharp),
//     GestureDetector(
//       onTap: _runAnimation,
//       child: const Icon(
//         Icons.access_alarm,
//       ),
//     ),
//   ];
//
//   void _runAnimation() {
//     if (_controller.isCompleted) {
//       _controller.reverse();
//     } else {
//       _controller.forward();
//     }
//   }
//
//   @override
//   void initState() {
//     _controller = AnimationController(
//         vsync: this,
//         duration: const Duration(
//           milliseconds: 500,
//         ));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Container(
//           constraints: BoxConstraints.tight(
//               Size(40 * (_buttons.length.toDouble()), 40 + 5)),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Flow(
//               delegate: _SortFlowDelegate(_controller),
//               children: _buttons,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _SortFlowDelegate extends FlowDelegate {
//   final Animation<double> _animation;
//
//   _SortFlowDelegate(this._animation) : super(repaint: _animation);
//
//   @override
//   void paintChildren(FlowPaintingContext context) {
//     for (int i = context.childCount - 1; i >= 1; i--) {
//       final offcet = i * _animation.value * 35;
//
//       final height = context.getChildSize(i)!.height / 4;
//
//       context.paintChild(i,
//           transform: Matrix4.translationValues(
//               offcet, height - height * _animation.value, 0)
//             ..scale(0.4 + 0.6 * _animation.value),
//           opacity: _animation.value);
//     }
//     context.paintChild(0, transform: Matrix4.translationValues(0, 0, 0));
//   }
//
//   @override
//   bool shouldRepaint(_SortFlowDelegate oldDelegate) {
//     return _animation != oldDelegate._animation;
//   }
// }
