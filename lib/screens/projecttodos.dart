import 'package:flutter/material.dart';
import 'package:what_todo/widgets.dart';

class Projecttodos extends StatefulWidget {
  @override
  _ProjecttodosState createState() => _ProjecttodosState();
}

class _ProjecttodosState extends State<Projecttodos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(19.0),
                        child: Image(
                          image: AssetImage('assets/images/ArrowLeft.png'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter Project Title",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Add description",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TodoWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
