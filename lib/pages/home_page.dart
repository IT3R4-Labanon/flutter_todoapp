import 'dart:js_util';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/util/dialog_box.dart';
import 'package:flutter_todo_app/util/todo_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //text controller
  final _controller = TextEditingController();

//list of  task
  List toDoList = [
    ['KaHero@sample.com', false],
    ['DO@sample.com', false],
  ];

  //check box
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

//save task no validation
  // void saveNewTask() {
  //   setState(() {
  //     toDoList.add([_controller.text, false]);
  //   });
  //   Navigator.of(context).pop();
  // }

//save task with validation
  void saveNewTask() {
    bool isVAlid = EmailValidator.validate(_controller.text);
    if (isVAlid) {
      setState(() {
        toDoList.add([_controller.text, false]);
      });
    } else {
      final snackbar = SnackBar(content: Text('Invalid email'));

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    Navigator.of(context).pop();
  }

//new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //delete task
  // void deleteTask(int index) {
  //   setState(() {
  //     toDoList.removeAt(index);
  //   });
  // }

// delete even task
  void deleteTask(int index) {
    if (index % 2 != 0) {
      setState(() {
        toDoList.removeAt(index);
      });
    } else {
      final snackbar = SnackBar(content: Text('Unable to delete'));

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  //editTask
  void editTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: upDate,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

//save the new task and remove old task
  void upDate() {
    setState(() {
      toDoList.add([_controller.text, false]);
    });
    removeTask;
    Navigator.of(context).pop();
  }

  //delete task
  void removeTask(int index) {
    setState(() {
      deleteTask(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              onTap: editTask,
              taskName: toDoList[index][0],
              taskCompleted: toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteTask: (context) => deleteTask(index),
            );
          }),
    );
  }
}
