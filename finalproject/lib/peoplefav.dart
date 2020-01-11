import 'package:flutter/material.dart';
import 'package:finalproject/main.dart';

class PeopleFav extends StatefulWidget {
  @override
  _PeopleFavState createState() => _PeopleFavState();
}

class _PeopleFavState extends State<PeopleFav> {

 @override
 void initState() {

   super.initState();
 }


 @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('People Favourites'),
        actions: <Widget>[
          SelectorGamesApp.settings(context),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 80,
            child: Container(color: Colors.blue,)
          ),
          SelectorGamesApp.mainbottombar(BarActive.People, context),
        ],
      ),
    );
 }
}