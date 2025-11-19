import 'package:flutter/material.dart';

class AppGridWidgets extends StatelessWidget {
  final int? crossAxisCount;
  final double? maxCrossAxisExtent;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double spacing;
  final double runSpacing;

  const AppGridWidgets({
    super.key,
    this.crossAxisCount,
    this.maxCrossAxisExtent,
    required this.itemCount,
    required this.itemBuilder,
    this.spacing = 16,
    this.runSpacing = 16,
  });

  int _getCrossAxisCount(double width) {
    if (crossAxisCount != null) return crossAxisCount!;

    int count;

    if (maxCrossAxisExtent != null && maxCrossAxisExtent! > 0) {
      count = (width / maxCrossAxisExtent!).floor().clamp(1, 6);
    } else {
      if (width < 576) {
        count = 1;
      } else if (width < 768) {
        count = 2;
      } else if (width < 992) {
        count = 3;
      } else if (width < 1400) {
        count = 4;
      } else if (width < 1600) {
        count = 5;
      } else {
        count = 6;
      }
    }

    return count.clamp(1, itemCount);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final count = _getCrossAxisCount(width);
        final availableWidth = width - (spacing * (count - 1));
        final itemWidth = availableWidth / count;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: List.generate(itemCount, (index) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: itemWidth,
                minWidth: itemWidth,
              ),
              child: itemBuilder(context, index),
            );
          }),
        );
      },
    );
  }
}
