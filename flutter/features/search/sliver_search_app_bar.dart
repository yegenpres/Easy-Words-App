import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/extensions.dart';
import 'package:wordsapp/features/search/search_controller.dart';

class SliverPersistensSearchAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  SliverPersistensSearchAppBar({
    required this.expandedHeight,
  });

  Widget _searchField(shrinkOffset, search) {
    if (_currentHeight(shrinkOffset) > 25) {
      return CupertinoSearchTextField(
        onChanged: search,
      );
    }
    return const SizedBox();
  }

  double _currentHeight(double shrinkOffset) {
    double height = expandedHeight - shrinkOffset;
    return height > 0 ? height : 0;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Consumer(
      builder: (context, ref, child) => Padding(
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: context.appColors.cardColor,
          ),
          child: SizedBox(
            height: _currentHeight(shrinkOffset),
            child: Opacity(
              opacity: 1,
              child: _searchField(
                  shrinkOffset, ref.read(Search.provider.notifier).search),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get minExtent => 0;

  @override
  double get maxExtent => expandedHeight + 35;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    if (oldDelegate != this) return true;
    return false;
  }
}
