import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'userData.dart';
import 'game.dart';

class GamesExplorer extends StatefulWidget {
  final UserData userData;
  static bool gamesLoaded = false;
  static bool newUser = false;
  GamesExplorer(this.userData);

  @override
  _GamesExplorerState createState() => _GamesExplorerState(userData);
}

class _GamesExplorerState extends State<GamesExplorer> {
  UserData userData;

  _GamesExplorerState(UserData userData) {
    this.userData = userData;
  }

  void looknotis() async {
    DocumentSnapshot notis = await Firestore.instance.collection('Notifications').document(userData.userEmail).get();
    if (notis.exists) {
      setState(() {
        userData.newNoti = notis.data['newNotis'];
      });
    }
  }

  @override
  void initState() {
    looknotis();
    super.initState();
    if (!GamesExplorer.gamesLoaded) {
      setState(() {
        Game.loadgames(userData, GamesExplorer.newUser, refresh);
        GamesExplorer.gamesLoaded = true;
      });
    }
  }

  void refresh() {
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Games Explorer'),
        backgroundColor: userData.buttonBarColor,
        actions: <Widget>[
          GamesBookShelf.settings(context, userData),
        ],
      ),
      body: (!GamesExplorer.gamesLoaded) ? Center(child:  CircularProgressIndicator(),)
        : Column(
        children: <Widget>[
          Expanded(
            flex: 80,
            child: Container(
                color: userData.backgroundColor,
                child: GamesBookShelf.games_grid(Game.allGames, refresh, userData)),
          ),
          GamesBookShelf.mainbottombar(BarActive.Home, context, userData),
        ],
      ),
    );
  }
}
