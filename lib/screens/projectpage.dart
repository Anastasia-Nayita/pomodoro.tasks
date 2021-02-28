import 'package:flutter/material.dart';
import 'package:what_todo/widgets.dart';

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
                child: ListView(
                  children: [
                    ProjectCard(
                      projTitle: "Work",
                    ),
                    ProjectCard(
                      projTitle: "Reading list",
                    ),
                    ProjectCard(
                      projTitle: "Learn about...",
                    ),
                    ProjectCard(),
                    ProjectCard(),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                width: double.infinity,
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/images/add.png',
                      ),
                    )
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
