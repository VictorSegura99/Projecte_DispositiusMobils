import 'package:finalproject/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(SelectorGamesApp());

class SelectorGamesApp extends StatelessWidget {
  // This widget is the root of your application.

  static Expanded mainbottombar() {
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
                      color: Colors.red,
                      onPressed: () {

                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_border,
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
                        Icons.people_outline,
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
                        Icons.notifications_none,
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

