import 'explorer.dart';
import 'fav.dart';
import 'login.dart';
import 'notifications.dart';
import 'peoplefav.dart';
import 'settings.dart';
import 'package:flutter/material.dart';

import 'userData.dart';

enum BarActive { Home, Favs, People, Noti }

void main() => runApp(SelectorGamesApp());

class SelectorGamesApp extends StatelessWidget {
  
  static settings(context, UserData userData, {inSettings = false}) {
    return FlatButton(
      child: Container(
        height: 40,
        child: ClipOval(
          child: Image.asset(
                userData.userProfilePicture,
                fit: BoxFit.cover,
            ),
        ),
      ),
      onPressed: () {
        if (!inSettings) {
          Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return Settings(userData); 
                },
              ));
        }
      },
    );
  }

  static Expanded mainbottombar(BarActive active, contex, UserData userData) {
    return Expanded(
      flex: 10,
      child: Container(
        color: Colors.black87,
        child: Padding(
          padding: EdgeInsets.only(bottom: 7),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.sort,
                    size: 40,
                  ),
                  color:
                      (active == BarActive.Home) ? Colors.blue : Colors.white,
                  onPressed: () {
                    if (active != BarActive.Home) {
                      Navigator.of(contex).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => GamesExplorer(userData)),
                          (Route<dynamic> route) => false);
                    }
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    (active == BarActive.Favs)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 40,
                  ),
                  color:
                      (active == BarActive.Favs) ? Colors.blue : Colors.white,
                  onPressed: () {
                    if (active != BarActive.Favs) {
                      Navigator.of(contex).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Fav(userData)),
                          (Route<dynamic> route) => false);
                    }
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    (active == BarActive.People)
                        ? Icons.people
                        : Icons.people_outline,
                    size: 40,
                  ),
                  color:
                      (active == BarActive.People) ? Colors.blue : Colors.white,
                  onPressed: () {
                    if (active != BarActive.People) {
                      Navigator.of(contex).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => PeopleFav(userData)),
                          (Route<dynamic> route) => false);
                    }
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    (active == BarActive.Noti)
                        ? Icons.notifications
                        : Icons.notifications_none,
                    size: 40,
                  ),
                  color:
                      (active == BarActive.Noti) ? Colors.blue : Colors.white,
                  onPressed: () {
                    if (active != BarActive.Noti) {
                      Navigator.of(contex).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => Notifications(userData)),
                          (Route<dynamic> route) => false);
                    }
                  },
                ),
              ),
            ],
          ),
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
