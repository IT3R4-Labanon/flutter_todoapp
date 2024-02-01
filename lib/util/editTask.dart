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
    return AlertDialog(
        content: SizedBox(  
      height: 120,
      child: Column(children: [
        TextField(
            controller: controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Add new todo"
                ),
                ),
                
                
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //save btn
            AddBtn(text: "save", onPressed: onSave),

            const SizedBox(width: 8),
            //cancel btn
            AddBtn(text: "cancel", onPressed: onCancel)
          ],
        ),
      ]),
    ));
  }
}
