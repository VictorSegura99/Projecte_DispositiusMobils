import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


class Game {

  static List<Game> allGames = new List<Game>();

  final String name;

  Game.fromJson(var json)
    : name = json['Name'];

  static _readGames() async {
    String data = await rootBundle.loadString('assets/data.json');
    var games = jsonDecode(data);
    for (var json in games['Games']) {
        allGames.add(Game.fromJson(json));
    }
  }

  
  static void loadgames() {
    _readGames();
  }
}