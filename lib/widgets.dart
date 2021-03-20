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

  ProjectCard({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        // color: generateRandomColor(),
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
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  final List<Color> colors = [
    Color(0xFFB1B5A7),
    Color(0xFFF2F3CC),
    Color(0xFFEECCDC),
    Color(0xFFBD9744),
    Color(0xFFFF7C58),
    Color(0xFFCEF6FF),
    Color(0xFF6C97B5),
    Color(0xFF00C9B0),
    Color(0xFF005B4C),
    Color(0xFF005C78),
    Color(0xFF845EC2),
    Color(0xFFD65DB1),
    Color(0xFFFF6F91)
  ];

  void _selectColors(Offset touchPosition) {
    final int colorCount = colors.length;
    final RenderBox renderBox = context.findRenderObject();
    final double blobDiameter = renderBox.size.height;
    final double blobRadius = blobDiameter / 2;
    final double separatorBlob =
        (renderBox.size.width - (colorCount * blobDiameter)) / (colorCount - 1);

    final double touchX =
        touchPosition.dx.clamp(0.0, renderBox.size.width.toDouble());

    final double fractionalTouchPosition =
        ((touchX - blobRadius) / (blobDiameter + separatorBlob))
            .clamp(0.0, (colorCount - 1).toDouble());

    final int leftColorIndex = fractionalTouchPosition.floor();
    final Color leftSelectableColor = colors[leftColorIndex];

    final int rightColorIndex = fractionalTouchPosition.ceil();
    final Color rightSelectableColor = colors[rightColorIndex];

    final Color selectedColor =
        (fractionalTouchPosition - leftColorIndex) <= 0.5
            ? leftSelectableColor
            : rightSelectableColor;

    final Color spectrumColor = Color.lerp(leftSelectableColor.color,
        rightSelectableColor.color, fractionalTouchPosition - leftColorIndex);
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
      child: ColorBar(
        colors: colors,
      ),
    );
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
                color: isDone ? Colors.white54 : Colors.white,
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
