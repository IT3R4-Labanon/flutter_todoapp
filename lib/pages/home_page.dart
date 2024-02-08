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

  void update(
   String taskid,
      bool? value, int index, String name, bool isCheckBoxUpdate) async {
    setState(() {
      db.toDoList[index]['completed'] = value;
    });

    await db.updateTask(taskid,
     value ?? false, name, isCheckBoxUpdate);
  }

  void saveNewTask() {
    db.addTask(_controller.text, false);
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

  void deleteTask(String taskId) {
    db.removeTask(taskId);
    setState(() {
      print('Task deleted');
      db.toDoList.removeAt;
    });
  }

  void editTask(int index,String taskId) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () => update(taskId,false, index, _controller.text, false),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
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
      body: _isInitialized
          ? FutureBuilder(
              future: db.loadTasks(),
              builder: (context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Map<String, dynamic>> tasks = snapshot.data!;

                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      
                      final String id = tasks[index]['id'];
                      return ToDoTile(
                        onTap: () => editTask(index,id),
                        taskName: tasks[index]['name'],
                        taskCompleted: tasks[index]['completed'],
                        onChanged: (value) => update(id,value, index, '', true),
                        deleteTask: (index) => deleteTask(id),
                      );
                    },
                  );
                }
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
