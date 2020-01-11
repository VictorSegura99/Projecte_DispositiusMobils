import 'package:flutter/material.dart';
import 'package:finalproject/main.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

 @override
 void initState() {

   super.initState();
 }


 @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('MainPage'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 80,
            child: Container(color: Colors.blue,)
          ),
          SelectorGamesApp.mainbottombar(),
        ],
      ),
    );
 }
}