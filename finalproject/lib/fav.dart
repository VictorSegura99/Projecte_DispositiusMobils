import 'package:flutter/material.dart';
import 'package:finalproject/main.dart';

class Fav extends StatefulWidget {
  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {

 @override
 void initState() {

   super.initState();
 }


 @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Favourite Games'),
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
          SelectorGamesApp.mainbottombar(BarActive.Favs, context),
        ],
      ),
    );
 }
}