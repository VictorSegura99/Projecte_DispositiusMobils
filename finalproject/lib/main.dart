import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/gamePage.dart';

import 'explorer.dart';
import 'fav.dart';
import 'login.dart';
import 'notifications.dart';
import 'peoplefav.dart';
import 'settings.dart';
import 'package:flutter/material.dart';
import 'game.dart';
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
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
          shape: BoxShape.circle,
          color: Colors.blue,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: ExactAssetImage(userData.userProfilePicture),
          ),
        ),
      ),
      onPressed: () {
        if (!inSettings) {
          Navigator.push(
              context, SlideRightRoute(0, 1, page: Settings(userData)));
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
                      (active == BarActive.Home) ? userData.mainColor : Colors.white,
                  onPressed: () {
                    if (active != BarActive.Home) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          SlideRightRoute(-1, 0, page: GamesExplorer(userData)),
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
                      (active == BarActive.Favs) ? userData.mainColor : Colors.white,
                  onPressed: () {
                    if (active != BarActive.Favs) {
                      if (active == BarActive.Home) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            SlideRightRoute(1, 0, page: Fav(userData)),
                            (Route<dynamic> route) => false);
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            SlideRightRoute(-1, 0, page: Fav(userData)),
                            (Route<dynamic> route) => false);
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
                      (active == BarActive.People) ? userData.mainColor : Colors.white,
                  onPressed: () {
                    if (active != BarActive.People) {
                      if (active == BarActive.Noti) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            SlideRightRoute(-1, 0, page: PeopleFav(userData)),
                            (Route<dynamic> route) => false);
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            SlideRightRoute(1, 0, page: PeopleFav(userData)),
                            (Route<dynamic> route) => false);
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
                      (active == BarActive.Noti) ? userData.mainColor : Colors.white,
                  onPressed: () {
                    if (active != BarActive.Noti) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          SlideRightRoute(1, 0, page: Notifications(userData)),
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

  static GridView games_grid(List<Game> gamesList, Function refresh, UserData userData) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      itemCount: gamesList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        Widget favIcon;
        if (gamesList[index].icon == Icons.favorite_border) {
          favIcon = Icon(
            gamesList[index].icon,
            color: Colors.white,
            size: 30,
          );
        } else {
          favIcon = Icon(
            gamesList[index].icon,
            color: Colors.red[300],
            size: 30,
          );
        }
        return Container(
          padding: EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.black54,
            ),
            child: FlatButton(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: Image.asset(
                              gamesList[index].image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                          ),
                          child: Center(
                            child: Text(
                              gamesList[index].name,
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.9),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 120, top: 90),
                      child: IconButton(
                          icon: favIcon,
                          onPressed: () {
                            if (gamesList[index].icon ==
                                Icons.favorite_border) {
                              gamesList[index].icon = Icons.favorite;
                              ++userData.numFavs;
                              Firestore.instance.collection('Users').document(userData.userEmail).updateData({'numFavs' : userData.numFavs});
                              Firestore.instance.collection('Favourites').document(userData.userEmail).updateData({gamesList[index].name : true});
                              Game.favGames.add(gamesList[index]);
                            } else {
                              gamesList[index].icon = Icons.favorite_border;
                              --userData.numFavs;
                              Firestore.instance.collection('Users').document(userData.userEmail).updateData({'numFavs' : userData.numFavs});
                              Firestore.instance.collection('Favourites').document(userData.userEmail).updateData({gamesList[index].name : false});
                              Game.favGames.remove(gamesList[index]);
                            }
                            refresh();
                          })),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context, SlideRightRoute(0, 1, page: GamePage(userData, gamesList[index])));
              },
            ),
          ),
        );
      },
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
