import 'package:flutter/cupertino.dart';

class Task {
  final int id;
  final String title;
  final Color projColor;

  Task({this.id, this.title, this.projColor});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'projColor': projColor,
    };
  }
}
