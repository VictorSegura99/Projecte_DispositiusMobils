import 'package:flutter/material.dart';
import 'main.dart';
import 'userData.dart';
import 'game.dart';

class GamesExplorer extends StatefulWidget {
  final UserData userData;

  GamesExplorer(this.userData);

  @override
  _GamesExplorerState createState() => _GamesExplorerState(userData);
}

class _GamesExplorerState extends State<GamesExplorer> {
  UserData userData;

  _GamesExplorerState(UserData userData) {
    this.userData = userData;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Games Explorer'),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          GamesBookShelf.settings(context, userData),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 80,
              child: Container(
                  color: Colors.black54,
                  child: GridView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: Game.allGames.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              color: Colors.black54,
                            ),
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        width: 300,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                        ),
                                        child: Image.asset(
                                          Game.allGames[index].image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        width: 300,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            Game.allGames[index].name,
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.9),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left:120,top: 90),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () {})),
                              ],
                            ),
                          ),
                        );
                      }))),
          GamesBookShelf.mainbottombar(BarActive.Home, context, userData),
        ],
      ),
    );
  }
}
