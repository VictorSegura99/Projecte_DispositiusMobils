import 'explorer.dart';
import 'fav.dart';
import 'login.dart';
import 'notifications.dart';
import 'peoplefav.dart';
import 'settings.dart';
import 'package:flutter/material.dart';

import 'userData.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  final double directionH;
  final double directionV;
  SlideRightRoute(this.directionH, this.directionV, {this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(directionH, directionV),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
        );
}


enum BarActive { Home, Favs, People, Noti }

void main() => runApp(GamesBookShelf());

class GamesBookShelf extends StatelessWidget {
  
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
          Navigator.push(context, SlideRightRoute(0, 1, page: Settings(userData)));
        }
      },
    );
  }

  static Expanded mainbottombar(BarActive active, context, UserData userData) {
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
                        Navigator.pushAndRemoveUntil(context, SlideRightRoute(-1, 0, page: GamesExplorer(userData)), (Route<dynamic> route) => false);
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
                      if (active == BarActive.Home) {
                        Navigator.pushAndRemoveUntil(context, SlideRightRoute(1, 0, page: Fav(userData)), (Route<dynamic> route) => false);
                      }
                      else {
                        Navigator.pushAndRemoveUntil(context, SlideRightRoute(-1, 0, page: Fav(userData)), (Route<dynamic> route) => false);
                      }
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
                      if (active == BarActive.Noti) {
                        Navigator.pushAndRemoveUntil(context, SlideRightRoute(-1, 0, page: PeopleFav(userData)), (Route<dynamic> route) => false);
                      }
                      else {
                        Navigator.pushAndRemoveUntil(context, SlideRightRoute(1, 0, page: PeopleFav(userData)), (Route<dynamic> route) => false);
                      }
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
                      Navigator.pushAndRemoveUntil(context, SlideRightRoute(1, 0, page: Notifications(userData)), (Route<dynamic> route) => false);
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
