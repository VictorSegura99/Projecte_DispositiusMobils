import 'package:flutter/material.dart';
import 'main.dart';
import 'userData.dart';

class Notifications extends StatefulWidget {

  final UserData userData;

  Notifications(this.userData);

  @override
  _NotificationsState createState() => _NotificationsState(userData);
}

class _NotificationsState extends State<Notifications> {
  
  UserData userData;

  _NotificationsState(UserData userData) {
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
        title: Text('Notifications'),
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
                color: userData.backgroundColor,
              )),
          GamesBookShelf.mainbottombar(BarActive.Noti, context, userData),
        ],
      ),
    );
  }
}
