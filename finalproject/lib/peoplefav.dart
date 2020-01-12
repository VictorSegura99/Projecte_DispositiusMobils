import 'package:flutter/material.dart';
import 'main.dart';
import 'userData.dart';

class PeopleFav extends StatefulWidget {
  final UserData userData;

  PeopleFav(this.userData);

  @override
  _PeopleFavState createState() => _PeopleFavState(userData);
}

class _PeopleFavState extends State<PeopleFav> {
   UserData userData;

  _PeopleFavState(UserData userData) {
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
        title: Text('People Favourites'),
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
          GamesBookShelf.mainbottombar(BarActive.People, context, userData),
        ],
      ),
    );
  }
}
