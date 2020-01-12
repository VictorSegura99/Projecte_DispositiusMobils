import 'package:flutter/material.dart';
import 'main.dart';
import 'userData.dart';

class GamesExplorer extends StatefulWidget {

  final UserData userData;

  GamesExplorer(this.userData);

  @override
  _GamesExplorerState createState() => _GamesExplorerState(userData);
}

class _GamesExplorerState extends State<GamesExplorer> {

  UserData userData;

  _GamesExplorerState(UserData userData) {
    this.userData = userData;
  }

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
          GamesBookShelf.settings(context, userData),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 80,
              child: Container(
                color: Colors.black54,
              )),
          GamesBookShelf.mainbottombar(BarActive.Home, context, userData),
        ],
      ),
    );
  }
}
