import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class Game {

  static List<Game> allGames = new List<Game>();
  static List<Game> favGames = new List<Game>();

  final String name;
  final String image;
  IconData icon=Icons.favorite_border;

  Game.fromJson(var json)
    : name = json['Name'],
    image=json['Image'];

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