import 'dart:ui';

import 'dart:math';

import 'package:flutter/material.dart';

class IntroWidget extends StatelessWidget {
  final String title;
  final String desc;

  IntroWidget({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 25.0,
        horizontal: 20.0,
      ),
      margin: EdgeInsets.only(
        bottom: 8.0,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
            ),
            child: Text(
              title ?? "Getting things done with Todocious",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
            ),
            child: Text(
                desc ??
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vitae, a velit facilisis aliquet suscipit.",
                style: TextStyle(color: Colors.white, fontSize: 13.0),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final Color projColor;
  ProjectCard({this.title, this.projColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        color: projColor ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            spreadRadius: 6,
            blurRadius: 7,
            offset: Offset(0, 4),
          )
        ],
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 40.0,
      ),
      child: Text(
        title ?? "(Unnamed project)",
        style: TextStyle(
            color: Colors.black54, fontSize: 18.0, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  ColorPicker({
    this.onColorSelected,
  });

  final List<Color> paletteColors = [
    Color(0xFFF2F3CC),
    //Color(0xFFB1B5A7),
    Color(0xFFBD9744),
    // Color(0xFFFF7C58),
    // Color(0xFFEECCDC),
    Color(0xFFCEF6FF),
    Color(0xFF6C97B5),
    Color(0xFF00C9B0),
    Color(0xFF005B4C),
    //Color(0xFF005C78),
    Color(0xFF845EC2),
    // Color(0xFFD65DB1),
    Color(0xFFFF6F91)
  ];
  final Function(Color spectrumColor) onColorSelected;

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  void _selectColors(Offset touchPosition) {
    if (widget.onColorSelected == null) {
      return;
    }

    final RenderBox renderBox = context.findRenderObject();

    final ColorBlobSpectrum colorBlobSpectrum =
        ColorBlobSpectrum.fromPhysicalDimensions(
            size: renderBox.size, paletteColors: widget.paletteColors);

    widget.onColorSelected(
        colorBlobSpectrum.calculateSpectrumColor(touchPosition.dx));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (DragDownDetails details) {
        _selectColors(details.localPosition);
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        _selectColors(details.localPosition);
      },
      child: ClipPath(
        clipper: BlobSpectrumClipper(
          colorCount: widget.paletteColors.length,
          lineThickness: 10,
        ),
        child: ColorBar(
          colors: widget.paletteColors,
        ),
      ),
    );
  }
}

class BlobSpectrumClipper extends CustomClipper<Path> {
  BlobSpectrumClipper({
    @required this.colorCount,
    @required this.lineThickness,
  });

  final int colorCount;
  final double lineThickness;

  @override
  Path getClip(Size size) {
    final double blobDiameter = size.height;
    final double separatorSpace =
        (size.width - (colorCount * blobDiameter)) / (colorCount - 1);

    Path path = Path();
    _addHorizontalLine(path, size, lineThickness);
    for (int i = 0; i < colorCount; ++i) {
      _addBlob(path, size, blobDiameter, separatorSpace, i);
    }
    return path;
  }

  void _addHorizontalLine(
      Path path, Size availableSpace, double lineThickness) {
    path.addRect(Rect.fromLTWH(
      0,
      (availableSpace.height - lineThickness) / 2,
      availableSpace.width,
      lineThickness,
    ));
  }

  void _addBlob(Path path, Size availableSpace, double blobDiameter,
      double separatorSpace, int index) {
    final blobRadius = blobDiameter / 2;

    path.addOval(Rect.fromCircle(
      center: Offset(
        blobRadius + (index * (blobDiameter + separatorSpace)),
        availableSpace.height / 2,
      ),
      radius: blobRadius,
    ));
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class ColorBlobSpectrum {
  factory ColorBlobSpectrum.fromPhysicalDimensions({
    @required Size size,
    @required List<Color> paletteColors,
  }) {
    return ColorBlobSpectrum(
      blobDiameter: size.height,
      spectrumWidth: size.width,
      paletteColors: paletteColors,
    );
  }

  ColorBlobSpectrum({
    @required this.blobDiameter,
    @required this.spectrumWidth,
    @required this.paletteColors,
  }) : blobRadius = blobDiameter / 2;

  final double blobDiameter;
  final double blobRadius;
  final double spectrumWidth;
  final List<Color> paletteColors;

  Color calculateSpectrumColor(double touchX) {
    final int colorCount = paletteColors.length;
    final double separatorBlob =
        (spectrumWidth - (colorCount * blobDiameter)) / (colorCount - 1);

    final double position = touchX.clamp(0.0, spectrumWidth);

    final double fractionalTouchPosition =
        ((position - blobRadius) / (blobDiameter + separatorBlob))
            .clamp(0.0, (colorCount - 1).toDouble());

    final int leftColorIndex = fractionalTouchPosition.floor();
    final Color leftSelectableColor = paletteColors[leftColorIndex];

    final int rightColorIndex = fractionalTouchPosition.ceil();
    final Color rightSelectableColor = paletteColors[rightColorIndex];

    return Color.lerp(leftSelectableColor, rightSelectableColor,
        fractionalTouchPosition - leftColorIndex);
  }
}

class ColorBar extends StatelessWidget {
  const ColorBar({
    Key key,
    @required this.colors,
  }) : super(key: key);

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
      child: SizedBox(),
    );
  }
}

class TodoWidget extends StatelessWidget {
  final String text;
  final bool isDone;

  TodoWidget({this.text, this.isDone = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 16.0,
            ),
            child: Image(
                image: isDone
                    ? AssetImage('assets/images/CheckCircle.png')
                    : AssetImage('assets/images/Circle.png')),
          ),
          Flexible(
            child: Text(
              text ?? '(Unnamed Todo)',
              style: TextStyle(
                color: isDone ? Colors.black45 : Colors.black,
                fontSize: 16.0,
                fontWeight: isDone ? FontWeight.w300 : FontWeight.w600,
                decoration:
                    isDone ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
