import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoDataBase {
  final CollectionReference _todoCollection =
      FirebaseFirestore.instance.collection('todos');

  List<Map<String, dynamic>> toDoList = [];

  Future<void> initialize() async {
    {}
  }

  Future<List<Map<String, dynamic>>> loadTasks() async {
    QuerySnapshot querySnapshot = await _todoCollection.get();
    List<Map<String, dynamic>> finalTodo = [];

    for (var myDoc in querySnapshot.docs) {
      final data = myDoc.data() as Map<String, dynamic>;

      Map<String, dynamic> formattedData = {
        'id': myDoc.id,
        'name': data['name'],
        'completed': data['completed'],
      };

      finalTodo.add(formattedData);
    }

    return finalTodo;
  }

  Future<void> addTask(String taskName, bool completed) async {
    await _todoCollection.add({'name': taskName, 'completed': completed});
  }

  Future<void> updateTask(
      String taskId, bool completed, String name, bool isCheckBoxUpdate) async {
    final Map<String, dynamic> updateData = {};
    if (isCheckBoxUpdate) {
      updateData['completed'] = completed;
    } else {
      updateData['completed'] = completed;
      updateData['name'] = name;
    }

    await _todoCollection.doc(taskId).update(updateData);
  }

  Future<void> removeTask(String taskId) async {
    await _todoCollection.doc(taskId).delete();
  }
}
