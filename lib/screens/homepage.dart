import 'package:flutter/material.dart';
import 'package:what_todo/widgets.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          Image(
            image: AssetImage(
              'assets/images/blue.png',
            ),
          ),
          Align(
            alignment: Alignment(0.0, -0.5),
            child: Image(
              image: AssetImage(
                'assets/images/todoList.png',
              ),
            ),
          ),
          TaskCardWidget(),
        ],
      ),
    ));
  }
}
