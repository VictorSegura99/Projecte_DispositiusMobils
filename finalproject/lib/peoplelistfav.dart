import 'package:flutter/material.dart';
import 'main.dart';
import 'userData.dart';
import 'game.dart';
import 'main.dart';

class PeopleListFav extends StatefulWidget {

  final String email;

  PeopleListFav(this.email);

  @override
  _PeopleListFavState createState() => _PeopleListFavState(email);

}

class _PeopleListFavState extends State<PeopleListFav> {

   String email;
   bool favLoaded = false;

  _PeopleListFavState(String userData) {
    this.email = userData;
  }

  @override
  void initState() {
    super.initState();
  }

  void refresh() {
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Favourite Games'),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          GamesBookShelf.settings(context, email),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 80,
              child: Container(
                color: Colors.black54,child: GamesBookShelf.games_grid(Game.favGames, refresh, email))),
          GamesBookShelf.mainbottombar(BarActive.Favs, context, email),
        ],
      ),
    );
  }
}
