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
        backgroundColor: Colors.black87,
        actions: <Widget>[
          SelectorGamesApp.settings(context),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 80,
              child: Container(
                color: Colors.black54,
              )),
          SelectorGamesApp.mainbottombar(BarActive.People, context),
        ],
      ),
    );
  }
}
