import 'package:flutter/material.dart';
import 'package:flutter_todo_app/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  //init Hive
  await Hive.initFlutter();

  //open a box
  var box = await Hive.openBox('dataBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'todo list'),
    );
  }
}
