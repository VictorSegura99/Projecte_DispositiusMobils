import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

import 'userData.dart';

class Game {

  static List<Game> allGames = new List<Game>();
  static List<Game> favGames = new List<Game>();

  final String name;
  final String image;
  IconData icon=Icons.favorite_border;

  Game.fromJson(var json)
    : name = json['Name'],
    image=json['Image'];

  static _readGames(bool justCreated, UserData userData, Function refresh) async {
    String data = await rootBundle.loadString('assets/data.json');
    var games = jsonDecode(data);
    for (var json in games['Games']) {
        allGames.add(Game.fromJson(json));
    }
    if (justCreated) {
      Map<String, dynamic> data = new Map<String, dynamic>();
      for (int i = 0; i < allGames.length; ++i) {
        data[allGames[i].name] = false;
      }
      Firestore.instance.collection('Favourites').document(userData.userEmail).setData(data);
    }
    else {
      DocumentSnapshot documents = await Firestore.instance.collection('Favourites').document(userData.userEmail).get();
      for (int i = 0; i < allGames.length; ++i) {
        if (documents.data[allGames[i].name]) {
          favGames.add(allGames[i]);
          favGames.last.icon = Icons.favorite;
        }
      }
      refresh();
    }
  }

  
  static void loadgames(UserData userData, bool justCreated, Function refresh) async {
    _readGames(justCreated, userData, refresh);
  }
}