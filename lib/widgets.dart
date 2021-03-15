import 'dart:ui';

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
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
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
                color: isDone ? Colors.white : Colors.white54,
                fontSize: 16.0,
                fontWeight: isDone ? FontWeight.w600 : FontWeight.w400,
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
