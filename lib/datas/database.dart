import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  //box reference
  final _dataBox = Hive.box('dataBox');

  //init data
  void initializeList() {
    toDoList = [
      ['todo@sample.com', false],
      ['task@sample.com', false]
    ];
  }

  //load data from DB
  void loadDataBase() {
    toDoList = _dataBox.get("TODOLIST");
  }

  //update DB
  void updateDataBase() {
    toDoList = _dataBox.put("TODOLIST", toDoList) as List;
  }
}
