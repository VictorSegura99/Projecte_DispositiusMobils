import 'package:flutter/material.dart';
import 'package:finalproject/main.dart';

class GamesExplorer extends StatefulWidget {
  @override
  _GamesExplorerState createState() => _GamesExplorerState();
}

class _GamesExplorerState extends State<GamesExplorer> {

 @override
 void initState() {

   super.initState();
 }


 @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Games Explorer'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 80,
            child: Container(color: Colors.blue,)
          ),
          SelectorGamesApp.mainbottombar(BarActive.Home, context),
        ],
      ),
    );
 }
}