import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'game.dart';
import 'gamePage.dart';
import 'main.dart';
import 'userData.dart';

class Notification {
  String text;
  Game game;
  bool isNew;
  bool isComment;
}

class Notifications extends StatefulWidget {

  final UserData userData;

  Notifications(this.userData);

  @override
  _NotificationsState createState() => _NotificationsState(userData);
}

class _NotificationsState extends State<Notifications> {
  
  UserData userData;
  List<Notification> notifications;
  bool notisLoaded = false;

  _NotificationsState(UserData userData) {
    this.userData = userData;
  }

  @override
  void initState() {
     GamesBookShelf.actualPage = ActualPage.notis;
    loadnotis();
    super.initState();
  }

  void loadnotis() async {
    DocumentSnapshot docNotis = await Firestore.instance.collection('Notifications').document(userData.userEmail).get();
    if (docNotis.exists) {
      notifications = new List<Notification>();
      int numNotis = docNotis.data['numNotis'];
      for (int i = 1; i <= numNotis; ++i) {
        Notification noti = new Notification();
        noti.text = docNotis.data[i.toString()];
        noti.isNew = !docNotis.data[i.toString() + 'Seen'];
        noti.isComment = (docNotis.data[i.toString() + 'Type'] == 'comment') ? true : false;
        for (int j = 0; j < Game.allGames.length;++j) {
          if (Game.allGames[j].name == docNotis.data[i.toString() + 'Game']) {
            noti.game = Game.allGames[j];
            break;
          }
        }
        notifications.insert(0, noti);
        Firestore.instance.collection('Notifications').document(userData.userEmail).updateData({i.toString() + 'Seen' : true});
      }
      Firestore.instance.collection('Notifications').document(userData.userEmail).updateData({'newNotis' : false});
      notisLoaded = true;
    }
    else {
      notisLoaded = true;
    }
    userData.newNoti = false;
    if (GamesBookShelf.actualPage == ActualPage.notis) {
          setState(() {
      
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: userData.buttonBarColor,
        actions: <Widget>[
          GamesBookShelf.settings(context, userData),
        ],
      ),
      body: Container(
        color: userData.backgroundColor,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 80,
                child: (!notisLoaded) ? Center(child: CircularProgressIndicator()) 
                  : (notifications == null) ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('There are no notifications'),
                  )
                  : ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                            color: userData.backgroundColor,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.white38,
                                border: Border.all(
                                  color: (notifications[index].isNew) ? userData.mainColor : Colors.black,
                                  width: 2.0,
                                ),
                              ),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        (notifications[index].isComment) ? Icons.comment : Icons.favorite,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(4, 8, 0, 8),
                                        child: Text(notifications[index].text),
                                      )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: OutlineButton(
                                        child: Text('See'),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        color: Colors.black,
                                        focusColor: Colors.black,
                                        borderSide: BorderSide(width: 2),
                                        highlightedBorderColor: Colors.black,
                                        onPressed: () {
                                          Navigator.push(
                                          context,
                                          SlideRightRoute(0, 1,
                                              page: GamePage(userData, notifications[index].game)));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            
                            );
                        }
                      ),
              ),
              GamesBookShelf.mainbottombar(BarActive.Noti, context, userData),
            ],
          ),
      ),
      );
  }
}
