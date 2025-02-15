// lib/models/drawing.dart
import 'dart:typed_data';

class Drawing {
  final String name;
  final Uint8List image;

  Drawing({required this.name, required this.image});
}