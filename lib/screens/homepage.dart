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
            Positioned(
              bottom: 165,
              right: 20,
              left: 20,
              child: TaskCardWidget(),
            ),
            Align(
              alignment: Alignment(0.0, 0.8),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 100.0,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFC9B07F),
                ),
                child: Text(
                  'Get Started!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
