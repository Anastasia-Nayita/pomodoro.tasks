import 'package:flutter/material.dart';
import 'package:what_todo/widgets.dart';
import 'package:what_todo/screens/homepage.dart';
import 'package:what_todo/screens/projecttodos.dart';

import '../database_helper.dart';

class Projectpage extends StatefulWidget {
  @override
  _ProjectpageState createState() => _ProjectpageState();
}

class _ProjectpageState extends State<Projectpage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FutureBuilder(
                  initialData: [],
                  future: _dbHelper.getTasks(),
                  builder: (context, snapshot) {
                    return ScrollConfiguration(
                      behavior: NoScrollGlow(),
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: Alignment.topCenter,
                              heightFactor: 0.8,
                              child: GestureDetector(
                                onTap: () {
                                  Future.delayed(
                                    Duration(milliseconds: 500),
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Projecttodos(
                                            task: snapshot.data[index],
                                          ),
                                        ),
                                      ).then(
                                        (value) {
                                          setState(() {});
                                        },
                                      );
                                    },
                                  );
                                },
                                child: ProjectCard(
                                  title: snapshot.data[index].title,
                                ),
                              ),
                            );
                          }),
                    );
                  },
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
                              builder: (context) => Projecttodos(
                                    task: null,
                                  )),
                        ).then((value) {
                          setState(() {});
                        });
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
