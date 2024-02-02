import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/datas/database.dart';
import 'package:flutter_todo_app/util/dialog_box.dart';
import 'package:flutter_todo_app/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //local storage
  final _dataBox = Hive.box('dataBox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_dataBox.get("TODOLIST") == null) {
      db.initializeList();
      db.updateDataBase();
    } else {
      db.loadDataBase();
    }

    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  //check box
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
      _controller.clear();
    });

    db.updateDataBase();
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
        db.toDoList.add([_controller.text, false]);
      });
    } else {
      const snackbar = SnackBar(content: Text('Invalid email'));

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    Navigator.of(context).pop();
    _controller.clear();
    db.updateDataBase();
  }

//new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () {
              Navigator.of(context).pop();
              _controller.clear();
            });
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
        db.toDoList.removeAt(index);
      });
    } else {
      const snackbar = SnackBar(content: Text('Unable to delete odd indices'));

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    db.updateDataBase();
  }

  //editTask
  void editTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () => upDate(index),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

//save the new task and remove old task
  void upDate(int index) {
    bool isVAlid = EmailValidator.validate(_controller.text);
    if (isVAlid) {
      setState(() {
        db.toDoList[index] = [_controller.text, false];
      });
      Navigator.of(context).pop();
    } else {
      const snackbar = SnackBar(content: Text('invalid email'));

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    db.updateDataBase();
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
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              onTap: () => editTask(index),
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteTask: (context) => deleteTask(index),
            );
          }),
    );
  }
}
