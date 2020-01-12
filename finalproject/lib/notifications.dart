import 'package:flutter/material.dart';
import 'package:finalproject/main.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

 @override
 void initState() {

   super.initState();
 }


 @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          SelectorGamesApp.settings(context),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 80,
            child: Container(color: Colors.black54,)
          ),
          SelectorGamesApp.mainbottombar(BarActive.Noti, context),
        ],
      ),
    );
 }
}