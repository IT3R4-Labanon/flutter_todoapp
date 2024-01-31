import "package:flutter/material.dart";

class editTask extends StatelessWidget {
  final controller;
  VoidCallback update;
  VoidCallback cancel;

  editTask(
      {super.key,
      required this.controller,
      required this.update,
      required this.cancel});

//create modal for updating task
  @override
  Widget build(BuildContext context) {
    return AlertDialog();
  }
}
