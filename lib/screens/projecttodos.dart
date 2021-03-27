import 'package:flutter/material.dart';
import 'package:what_todo/database_helper.dart';
import 'package:what_todo/models/task.dart';
import 'package:what_todo/models/todo.dart';
import 'package:what_todo/widgets.dart';

class Projecttodos extends StatefulWidget {
  final Task task;

  Projecttodos({@required this.task});

  @override
  _ProjecttodosState createState() => _ProjecttodosState();
}

class _ProjecttodosState extends State<Projecttodos> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  int _taskId = 0;
  String _taskTitle = "";
  Color _projColor = Colors.transparent;
  Color projBlobInvisible = Colors.transparent;
  FocusNode _titleFocus;
  FocusNode _todoFocus;

  bool _contentVisible = false;

  @override
  void initState() {
    if (widget.task != null) {
      _contentVisible = true;
      _taskTitle = widget.task.title;
      _taskId = widget.task.id;

      _projColor = widget.task.projColor;
    }

    _titleFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _todoFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0.0, -0.9),
                child: Image(
                  image: AssetImage(
                    'assets/images/proj_blob.png',
                  ),
                  color: _projColor ?? projBlobInvisible,
                ),
              ),
              Column(
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
                            focusNode: _titleFocus,
                            onSubmitted: (value) async {
                              if (value != '') {
                                if (widget.task == null) {
                                  Task _newTask = Task(title: value);
                                  _taskId =
                                      await _dbHelper.insertTask(_newTask);
                                  setState(() {
                                    _contentVisible = true;
                                    _taskTitle = value;
                                  });
                                } else {
                                  await _dbHelper.updateTaskTitle(
                                      _taskId, value);
                                  print("Updated the existing task");
                                }
                                _todoFocus.requestFocus();
                              }
                            },
                            controller: TextEditingController()
                              ..text = _taskTitle,
                            decoration: InputDecoration(
                              hintText: "Enter Project Title",
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: ColorPicker(
                      onColorSelected: (Color spectrumColor) async {
                        await _dbHelper.updateProjColor(_taskId, _projColor);
                        print("Updated the projColor");
                        setState(() {
                          _projColor = spectrumColor;
                        });
                      },
                    ),
                  ),
                  FutureBuilder(
                    initialData: [],
                    future: _dbHelper.getTodo(_taskId),
                    builder: (context, snapshot) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                if (snapshot.data[index].isDone == 0) {
                                  await _dbHelper.updateTodoDone(
                                      snapshot.data[index].id, 1);
                                } else {
                                  await _dbHelper.updateTodoDone(
                                      snapshot.data[index].id, 0);
                                }
                                setState(() {});
                              },
                              child: TodoWidget(
                                text: snapshot.data[index].title,
                                isDone: snapshot.data[index].isDone == 0
                                    ? false
                                    : true,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: 16.0,
                            ),
                            child: Image(
                                image: AssetImage('assets/images/Circle.png')),
                          ),
                          Expanded(
                            child: TextField(
                              focusNode: _todoFocus,
                              controller: TextEditingController()..text = "",
                              onSubmitted: (value) async {
                                if (value != '') {
                                  if (_taskId != null) {
                                    DatabaseHelper _dbHelper = DatabaseHelper();
                                    Todo _newTodo = Todo(
                                      title: value,
                                      isDone: 0,
                                      taskId: _taskId,
                                    );
                                    await _dbHelper.insertTodo(_newTodo);
                                    setState(() {});
                                    _todoFocus.requestFocus();
                                  } else {
                                    print('task is not added');
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Add ToDo item",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: _contentVisible,
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: GestureDetector(
                    onTap: () async {
                      if (_taskId != 0) {
                        await _dbHelper.deleteTask(_taskId);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      child: Image(
                        image: AssetImage(
                          'assets/images/delete.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
