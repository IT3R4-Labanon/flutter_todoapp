import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;

  ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteTask});

  // Slidable(
  //   endActionPane: ActionPane(motion: StretchMotion(), children: [
  //     SlidableAction(
  //       onPressed: deleteTask,
  //       icon: Icons.delete,
  //       backgroundColor: Colors.red,
  //       borderRadius: BorderRadius.circular(12),
  //     )

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(12)),
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(children: [
              //check box
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              //task name
              Expanded(
                child: Text(taskName,
                    style: TextStyle(
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    )),
              ),
              //delete btn here
            ])),
      ),
    );
  }
}
