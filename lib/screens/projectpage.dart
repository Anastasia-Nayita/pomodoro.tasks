import 'package:flutter/material.dart';
import 'package:what_todo/widgets.dart';
import 'package:what_todo/screens/homepage.dart';
import 'package:what_todo/screens/projecttodos.dart';

class Projectpage extends StatefulWidget {
  @override
  _ProjectpageState createState() => _ProjectpageState();
}

class _ProjectpageState extends State<Projectpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ScrollConfiguration(
                  behavior: NoScrollGlow(),
                  child: ListView(
                    children: [
                      ProjectCard(
                        projTitle: "Work",
                      ),
                      ProjectCard(
                        projTitle: "Reading list",
                      ),
                      ProjectCard(),
                      ProjectCard(),
                      ProjectCard(),
                      ProjectCard(),
                      ProjectCard(),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Homepage()),
                        );
                      },
                      child: Image(
                        image: AssetImage(
                          'assets/images/ArrowLeft.png',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Projecttodos()),
                        );
                      },
                      child: Image(
                        image: AssetImage(
                          'assets/images/add.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
