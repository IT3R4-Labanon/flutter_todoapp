import "package:flutter/material.dart";
import "package:flutter_todo_app/util/addBtn.dart";

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: SizedBox(
      height: 120,
      child: Column(children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: "Todos "),
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
