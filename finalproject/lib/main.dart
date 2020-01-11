import 'package:finalproject/login.dart';
import 'package:flutter/material.dart';

  enum BarActive {
    Home,
    Favs,
    People,
    Noti
  }

void main() => runApp(SelectorGamesApp());

class SelectorGamesApp extends StatelessWidget {

  static Expanded mainbottombar(BarActive active) {
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

