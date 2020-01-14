import 'package:flutter/material.dart';
import 'main.dart';
import 'userData.dart';
import 'game.dart';
import 'main.dart';

class Fav extends StatefulWidget {
  final UserData userData;

  Fav(this.userData);

  @override
  _FavState createState() => _FavState(userData);
}

class _FavState extends State<Fav> {
  UserData userData;

  _FavState(UserData userData) {
    this.userData = userData;
  }

  @override
  void initState() {
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Favorite Games'),
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
                  color: userData.backgroundColor,
                  child: GamesBookShelf.games_grid(
                      Game.favGames, refresh, userData))),
          GamesBookShelf.mainbottombar(BarActive.Favs, context, userData),
        ],
      ),
    );
  }
}
