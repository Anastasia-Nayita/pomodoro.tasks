import 'dart:ui';

import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String desc;
  TaskCardWidget({this.title, this.desc});

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
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.deepPurple,
          width: 4,
        ),
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
