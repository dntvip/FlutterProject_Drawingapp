import 'package:flutter/material.dart';

class PixelPainter extends CustomPainter {
  final List<List<Color>> colors;
  final double pixelSize;

  PixelPainter(this.colors, this.pixelSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (int i = 0; i < colors.length; i++) {
      for (int j = 0; j < colors[i].length; j++) {
        paint.color = colors[i][j];
        canvas.drawRect(
          Rect.fromLTWH(j * pixelSize, i * pixelSize, pixelSize + 1, pixelSize + 1),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}