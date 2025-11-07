import 'package:flutter/material.dart';

class ReorderableGridView extends StatefulWidget {
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
  State<ReorderableGridView> createState() => _ReorderableGridViewState();
}

class _ReorderableGridViewState extends State<ReorderableGridView> {
  int? _draggingIndex;
  int? _hoveringIndex;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth - 
            widget.padding.left - 
            widget.padding.right -
            (widget.crossAxisSpacing * (widget.crossAxisCount - 1));
        final itemWidth = availableWidth / widget.crossAxisCount;
        final itemHeight = itemWidth / widget.childAspectRatio;

        return SingleChildScrollView(
          padding: widget.padding,
          child: Wrap(
            spacing: widget.crossAxisSpacing,
            runSpacing: widget.mainAxisSpacing,
            children: List.generate(widget.itemCount, (index) {
              return _buildDraggableItem(
                context,
                index,
                itemWidth,
                itemHeight,
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildDraggableItem(
    BuildContext context,
    int index,
    double width,
    double height,
  ) {
    final isDragging = _draggingIndex == index;
    final isHovering = _hoveringIndex == index;

    return SizedBox(
      width: width,
      height: height,
      child: LongPressDraggable<int>(
        data: index,
        onDragStarted: () {
          setState(() {
            _draggingIndex = index;
          });
        },
        onDragEnd: (_) {
          setState(() {
            _draggingIndex = null;
            _hoveringIndex = null;
          });
        },
        feedback: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: width,
            height: height,
            child: Opacity(
              opacity: 0.9,
              child: widget.itemBuilder(context, index),
            ),
          ),
        ),
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: widget.itemBuilder(context, index),
        ),
        child: DragTarget<int>(
          onWillAcceptWithDetails: (details) {
            if (details.data != index) {
              setState(() {
                _hoveringIndex = index;
              });
            }
            return details.data != index;
          },
          onLeave: (_) {
            setState(() {
              _hoveringIndex = null;
            });
          },
          onAcceptWithDetails: (details) {
            widget.onReorder(details.data, index);
            setState(() {
              _hoveringIndex = null;
            });
          },
          builder: (context, candidateData, rejectedData) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: isHovering
                    ? Border.all(
                        color: Colors.blue,
                        width: 2,
                      )
                    : null,
              ),
              child: widget.itemBuilder(context, index),
            );
          },
        ),
      ),
    );
  }
}