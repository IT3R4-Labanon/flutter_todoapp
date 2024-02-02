import "package:flutter/material.dart";

class addBtn extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  addBtn({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
