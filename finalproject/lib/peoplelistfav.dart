import 'package:flutter/material.dart';
import 'main.dart';
import 'userData.dart';
import 'game.dart';

class PeopleListFav extends StatefulWidget {

  final String email;
  final String name;
  final UserData userData;

  PeopleListFav(this.email, this.name, this.userData);

  @override
  _PeopleListFavState createState() => _PeopleListFavState(email, name, userData);

}

class _PeopleListFavState extends State<PeopleListFav> {

   String email;
   bool favLoaded = false;
   String name;
   UserData userData;

  _PeopleListFavState(String email, String name, UserData userData) {
    this.email = email;
    this.name = name;
    this.userData = userData;
  }

  @override
  void initState() {
    Game.loadpeoplegames(email, refresh);
    super.initState();
  }

  void refresh() {
    setState(() {
      favLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('$name Favorite Games'),
        backgroundColor: userData.buttonBarColor,
      ),
      body: Container(
        color: userData.backgroundColor,
        child: (!favLoaded) ? Center(child:  CircularProgressIndicator(),) 
          : GamesBookShelf.games_grid(Game.peopleFavGames, refresh, userData, canEdit: false),
      ),
    );
  }
}
