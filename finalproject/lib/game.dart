import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

import 'userData.dart';

class Game {

  static List<Game> allGames = new List<Game>();
  static List<Game> favGames = new List<Game>();
  static List<Game> peopleFavGames = new List<Game>();

  final String name;
  final String image;
  IconData icon=Icons.favorite_border;
  final String company;

  Game.fromJson(var json)
    : name = json['Name'],
    image=json['Image'],
    company=json['Company'];

  Game.fromGame(Game game)
    : name = game.name,
    image = game.image,
    company=game.company;

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
      Firestore.instance.collection('Favorites').document(userData.userEmail).setData(data);
      refresh();
    }
    else {
      DocumentSnapshot documents = await Firestore.instance.collection('Favorites').document(userData.userEmail).get();
      for (int i = 0; i < allGames.length; ++i) {
        if (documents.data[allGames[i].name]) {
          favGames.add(allGames[i]);
          favGames.last.icon = Icons.favorite;
        }
      }      
      refresh();
    }
  }

  static _readPeopleGames(String email, Function refresh) async {
    peopleFavGames.clear();
    DocumentSnapshot documents = await Firestore.instance.collection('Favorites').document(email).get();
    for (int i = 0; i < allGames.length; ++i) {
      if (documents.data[allGames[i].name]) {
        peopleFavGames.add(Game.fromGame(allGames[i]));
        peopleFavGames.last.icon = Icons.favorite;
      }
    }      
    refresh();
  }
  
  static void loadgames(UserData userData, bool justCreated, Function refresh) async {
    _readGames(justCreated, userData, refresh);
  }

  static void loadpeoplegames(String email, Function refresh) async {
    _readPeopleGames(email, refresh);
  }
}