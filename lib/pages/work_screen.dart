import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:version2/widgets/pixel_grid.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:ui' as ui;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WorkScreen extends StatefulWidget {
  final int height;
  final int width;

  const WorkScreen({Key? key, required this.height, required this.width}) : super(key: key);

  @override
  _WorkScreenState createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  Color currentColor = Colors.black;
  String currentTool = 'brush';
  GlobalKey _globalKey = GlobalKey();
  late List<List<Color>> colors;

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    colors = List.generate(widget.height, (i) => List.generate(widget.width, (j) {
      return Colors.white; // Background color
    }));
  }

  void _clearGrid() {
    setState(() {
      colors = List.generate(widget.height, (i) => List.generate(widget.width, (j) {
        return Colors.white; // Set all cells to white
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _exporttoGallery,
          ),
        ],
      ),
      body: InteractiveViewer(
        boundaryMargin: EdgeInsets.all(double.infinity),
        minScale: 0.1,
        maxScale: 5.0,
        child: Center(
          child: RepaintBoundary(
            key: _globalKey,
            child: AspectRatio(
              aspectRatio: widget.width / widget.height,
              child: PixelGrid(
                height: widget.height,
                width: widget.width,
                currentColor: currentColor,
                currentTool: currentTool,
                colors: colors,
                onColorChange: (color) {
                  setState(() {
                    currentColor = color;
                  });
                },
                onToolChange: (tool) {
                  setState(() {
                    currentTool = tool;
                  });
                },
                clearGrid: _clearGrid,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                color: currentTool == 'brush' ? Colors.grey : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.brush),
                onPressed: () => setState(() {
                  currentTool = 'brush';
                }),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: currentTool == 'eraser' ? Colors.grey : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(MdiIcons.eraser),
                onPressed: () => setState(() {
                  currentTool = 'eraser';
                }),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: currentColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.color_lens,
                  color: Colors.white,
                ),
                onPressed: _selectColor,
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(MdiIcons.deleteForever),
                onPressed: _clearGrid,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectColor() async {
    int r = currentColor.red;
    int g = currentColor.green;
    int b = currentColor.blue;

    Color? pickedColor = await showDialog<Color>(
      context: context,
      builder: (context) {
        Color tempColor = currentColor;
        return AlertDialog(
          title: Text('Chọn màu'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                BlockPicker(
                  pickerColor: tempColor,
                  onColorChanged: (color) {
                    tempColor = color;
                    r = color.red;
                    g = color.green;
                    b = color.blue;
                  },
                ),
                SizedBox(height: 20),
                Text('Hoặc chọn màu bằng RGB:'),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'R (0-255)'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          r = int.tryParse(value) ?? 0;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'G (0-255)'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          g = int.tryParse(value) ?? 0;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'B (0-255)'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          b = int.tryParse(value) ?? 0;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Chọn'),
              onPressed: () {
                Color rgbColor = Color.fromARGB(255, r.clamp(0, 255), g.clamp(0, 255), b.clamp(0, 255));
                Navigator.of(context).pop(rgbColor);
              },
            ),
          ],
        );
      },
    );

    if (pickedColor != null) {
      setState(() {
        currentColor = pickedColor;
      });
    }
  }

  Future<void> _exporttoGallery() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      double pixelRatio = MediaQuery.of(context).devicePixelRatio;
      ui.Image image = await boundary.toImage(pixelRatio: pixelRatio * 2); // Increase pixel ratio for better quality
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final result = await ImageGallerySaver.saveImage(pngBytes);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Export to Gallery!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error Export to Gallery: $e')));
    }
  }


}