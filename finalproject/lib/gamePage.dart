import 'package:flutter/material.dart';
import 'game.dart';
import 'main.dart';
import 'userData.dart';

class GamePage extends StatefulWidget {

  final UserData userData;
  final Game game;

  GamePage(this.userData, this.game);

  @override
  _GamePageState createState() => _GamePageState(userData, game);
}

class _GamePageState extends State<GamePage> {
  
  UserData userData;
  Game game;

  _GamePageState(UserData userData, Game game) {
    this.userData = userData;
    this.game = game;
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
        title: Text('${game.name}'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black54,
      ),
    );
  }
}