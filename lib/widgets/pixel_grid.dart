import 'package:flutter/material.dart';
import 'pixel_painter.dart';

class PixelGrid extends StatefulWidget {
  final int height;
  final int width;
  final Color currentColor;
  final String currentTool;
  final List<List<Color>> colors;
  final ValueChanged<Color> onColorChange;
  final ValueChanged<String> onToolChange;
  final VoidCallback clearGrid;

  PixelGrid({
    required this.height,
    required this.width,
    required this.currentColor,
    required this.currentTool,
    required this.colors,
    required this.onColorChange,
    required this.onToolChange,
    required this.clearGrid,
  });

  @override
  _PixelGridState createState() => _PixelGridState();
}

class _PixelGridState extends State<PixelGrid> {
  @override
  void initState() {
    super.initState();
  }

  void _draw(int i, int j) {
    setState(() {
      if (widget.currentTool == 'brush') {
        widget.colors[i][j] = widget.currentColor; // Draw color
      } else if (widget.currentTool == 'eraser') {
        widget.colors[i][j] = Colors.white; // Erase color
      }
    });
  }

  void _onPanUpdate(DragUpdateDetails details, double pixelSize) {
    int i = (details.localPosition.dy / pixelSize).floor();
    int j = (details.localPosition.dx / pixelSize).floor();

    if (i >= 0 && i < widget.height && j >= 0 && j < widget.width) {
      _draw(i, j);
    }
  }

  void _onPanStart(DragStartDetails details, double pixelSize) {
    _onPanUpdate(DragUpdateDetails(
      globalPosition: details.globalPosition,
      localPosition: details.localPosition,
      delta: Offset.zero,
    ), pixelSize);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double pixelSize = constraints.maxWidth / widget.width;
        final double gridHeight = pixelSize * widget.height;
        final double gridWidth = pixelSize * widget.width;

        return Center(
          child: Container(
            width: gridWidth,
            height: gridHeight,
            child: GestureDetector(
              onPanUpdate: (details) => _onPanUpdate(details, pixelSize),
              onPanStart: (details) => _onPanStart(details, pixelSize),
              child: CustomPaint(
                size: Size(gridWidth, gridHeight),
                painter: PixelPainter(widget.colors, pixelSize),
              ),
            ),
          ),
        );
      },
    );
  }
}