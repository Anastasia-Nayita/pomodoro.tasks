import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0.0, 0.3),
      child: Text(
        "Getting things done with Todocious",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
