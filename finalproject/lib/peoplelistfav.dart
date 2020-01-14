import 'package:flutter/material.dart';
import 'main.dart';
import 'userData.dart';
import 'game.dart';
import 'main.dart';

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
        title: Text('$name favourites games'),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 80,
              child: Container(
                color: Colors.black54,
              ),
          ),
        ],
      ),
    );
  }
}
