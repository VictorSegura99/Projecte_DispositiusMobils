import 'package:finalproject/explorer.dart';
import 'package:finalproject/fav.dart';
import 'package:finalproject/login.dart';
import 'package:finalproject/notifications.dart';
import 'package:finalproject/peoplefav.dart';
import 'package:flutter/material.dart';

  enum BarActive {
    Home,
    Favs,
    People,
    Noti
  }

void main() => runApp(SelectorGamesApp());

class SelectorGamesApp extends StatelessWidget {

  static Expanded mainbottombar(BarActive active, contex) {
    return Expanded(
            flex: 10,
            child: Container(
              color: Colors.green,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(
                        Icons.sort,
                        size: 40,
                      ),
                      color: (active == BarActive.Home) ? Colors.red : Colors.blue,
                      onPressed: () {
                        Navigator.of(contex).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        GamesExplorer()), (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(
                        (active == BarActive.Favs) ? Icons.favorite : Icons.favorite_border,
                        size: 40,
                      ),
                      color: Colors.red,
                      onPressed: () {
                        Navigator.of(contex).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        Fav()), (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(
                        (active == BarActive.People) ? Icons.people : Icons.people_outline,
                        size: 40,
                      ),
                      color: Colors.red,
                      onPressed: () {
                        Navigator.of(contex).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        PeopleFav()), (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(
                        (active == BarActive.Noti) ? Icons.notifications : Icons.notifications_none,
                        size: 40,
                      ),
                      color: Colors.red,
                      onPressed: () {
                        Navigator.of(contex).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        Notifications()), (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinalProject',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LogIn(),
    );
  }
}

