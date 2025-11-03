import 'package:flutter/material.dart';

class ReorderableGridView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final void Function(int, int) onReorder;
  final EdgeInsets padding;
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const ReorderableGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onReorder,
    required this.crossAxisCount,
    this.padding = EdgeInsets.zero,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      padding: padding,
      itemCount: (itemCount / crossAxisCount).ceil(),
      onReorder: (oldRowIndex, newRowIndex) {
        final oldIndex = oldRowIndex * crossAxisCount;
        final newIndex = newRowIndex * crossAxisCount;
        onReorder(oldIndex, newIndex);
      },
      proxyDecorator: (child, index, animation) {
        return Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          child: child,
        );
      },
      itemBuilder: (context, rowIndex) {
        final startIndex = rowIndex * crossAxisCount;
        final endIndex = (startIndex + crossAxisCount < itemCount)
            ? startIndex + crossAxisCount
            : itemCount;

        return Container(
          key: ValueKey('row_$rowIndex'),
          margin: EdgeInsets.only(bottom: mainAxisSpacing),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = startIndex; i < endIndex; i++) ...[
                Expanded(
                  child: LongPressDraggable<int>(
                    data: i,
                    feedback: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: (MediaQuery.of(context).size.width - 
                                padding.horizontal - 
                                (crossAxisSpacing * (crossAxisCount - 1))) / 
                               crossAxisCount,
                        child: Opacity(
                          opacity: 0.8,
                          child: itemBuilder(context, i),
                        ),
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.3,
                      child: itemBuilder(context, i),
                    ),
                    child: DragTarget<int>(
                      onAcceptWithDetails: (details) {
                        onReorder(details.data, i);
                      },
                      builder: (context, candidateData, rejectedData) {
                        return itemBuilder(context, i);
                      },
                    ),
                  ),
                ),
                if (i < endIndex - 1) SizedBox(width: crossAxisSpacing),
              ],
              // Fill remaining space if last row is incomplete
              if (endIndex - startIndex < crossAxisCount)
                ...List.generate(
                  crossAxisCount - (endIndex - startIndex),
                  (index) => Expanded(child: Container()),
                ),
            ],
          ),
        );
      },
    );
  }
}