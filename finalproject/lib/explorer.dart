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
          SelectorGamesApp.mainbottombar(BarActive.Home, context),
        ],
      ),
    );
 }
}