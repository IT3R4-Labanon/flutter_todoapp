import "package:flutter/material.dart";

class AddBtn extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  AddBtn({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
