import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/firestore.dart';
import 'package:flutter_todo_app/util/dialog_box.dart';
import 'package:flutter_todo_app/util/todo_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final ToDoDataBase db = ToDoDataBase();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeToDoList();
  }

  Future<void> initializeToDoList() async {
    {
      await db.initialize();
      setState(() {
        _isInitialized = true;
      });
    }
  }

  void getData() async {
    {
      List<Map<String, dynamic>> tasks = await db.loadTasks();
      print('Tasks retrieved: $tasks');
    }
  }

  void checkBoxChanged(bool? value, int index) async {
    setState(() {
      db.toDoList[index]['completed'] = value;
    });

    await db.updateTask(db.toDoList[index]['id'], value ?? false);
  }

  void saveNewTask() {
    bool isValid = EmailValidator.validate(_controller.text);
    if (isValid) {
      db.addTask(_controller.text, false);
      initializeToDoList();
    } else {
      const snackbar = SnackBar(content: Text('Invalid email'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    Navigator.of(context).pop();
    _controller.clear();
  }

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

  void deleteTask(int index) {
    if (index % 2 != 0) {
      setState(() {
        db.toDoList.removeAt(index);
      });
      db.removeTask(db.toDoList[index]['id']);
    } else {
      const snackbar = SnackBar(content: Text('Unable to delete odd'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

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

  void upDate(int index) {
    bool isValid = EmailValidator.validate(_controller.text);
    if (isValid) {
      db.updateTask(db.toDoList[index]['id'], _controller.text as bool);
      initializeToDoList();
      Navigator.of(context).pop();
    } else {
      const snackbar = SnackBar(content: Text('Invalid email'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      print('this is scaffold');
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
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
}
