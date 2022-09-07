import 'package:flutter/material.dart';
import 'package:mysqltodo/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class SQLToDo extends StatefulWidget {
  const SQLToDo({Key? key}) : super(key: key);

  @override
  State<SQLToDo> createState() => _SQLToDoState();
}

class _SQLToDoState extends State<SQLToDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
