import 'package:finalproject/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(SelectorGamesApp());

class SelectorGamesApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinalProject',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LogIn(),
    );
  }
}
