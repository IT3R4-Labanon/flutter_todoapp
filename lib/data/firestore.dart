import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoDataBase {
  final CollectionReference _todoCollection =
      FirebaseFirestore.instance.collection('todos');

  List<Map<String, dynamic>> toDoList = [];

  Future<void> initialize() async {
    print('displaying todo list');
  }

  Future<List<Map<String, dynamic>>> loadTasks() async {
    QuerySnapshot querySnapshot = await _todoCollection.get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> addTask(String taskName, bool completed) async {
    print('task added');
    await _todoCollection.add({'name': taskName, 'completed': completed});
  }

  Future<void> updateTask(String taskId, bool completed) async {
    await _todoCollection.doc(taskId).update({'completed': completed});
  }

  Future<void> removeTask(String taskId) async {
    await _todoCollection.doc(taskId).delete();
  }
}
