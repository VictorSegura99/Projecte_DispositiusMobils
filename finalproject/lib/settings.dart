import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'userData.dart';

class Settings extends StatefulWidget {
  final UserData userData;

  Settings(this.userData);

  @override
  _SettingsState createState() => _SettingsState(userData);
}

class _SettingsState extends State<Settings> {
  UserData userData;

  _SettingsState(UserData userData) {
    this.userData = userData;
  }

  List<String> profile_pictures;

  @override
  void initState() {
    loadprofilepictures();
    super.initState();
  }

  void loadprofilepictures() {
    setState(() {
      profile_pictures = new List<String>();
      profile_pictures.add('assets/default_image.png');
      profile_pictures.add('assets/creeper.jpg');
      profile_pictures.add('assets/bee_minecraft.png');
    });
  }

  changephoto() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.green[200],
        title: Text('Available Profile Photos'),
        content: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 250,
                  width: 300,
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(profile_pictures.length, (index) {
                      return FlatButton(
                        onPressed: () {
                          setState(() {
                            userData.userProfilePicture =
                                profile_pictures[index];
                          });
                          Firestore.instance
                              .collection('Users')
                              .document(userData.userEmail)
                              .updateData({
                            'profilePicture': userData.userProfilePicture
                          });
                        },
                        padding: EdgeInsets.all(5),
                        child: Image.asset(profile_pictures[index]),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('ACCEPT'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Profile'),
        actions: <Widget>[
          GamesBookShelf.settings(context, userData, inSettings: true),
        ],
      ),
      body: Container(
        color: Colors.black26,
        child: Column(
          children: <Widget>[
            Container(color: Colors.black54),
            FlatButton(
              color: Colors.red,
              child: Text('Change Photo'),
              onPressed: () {
                changephoto();
              },
            ),
            FlatButton(
              color: Colors.blue,
              child: Text('Personalize App Colors'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.grey[900],
                    title: Center(
                      child: Text(
                        'Choose your Colors',
                        style: TextStyle(color: Colors.white, fontSize: 28),
                      ),
                    ),
                    content: Container(
                      height: 270,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Text(
                                    "Main Color",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            side: BorderSide(
                                                color: Colors.white, width: 3)),
                                        child: null,
                                        onPressed: () {
                                          setState(() {
                                            userData.mainColor = Colors.red;
                                            Firestore.instance
                                                .collection('Users')
                                                .document(userData.userEmail)
                                                .updateData(
                                                    {'mainColor': 'red'});
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        color: Colors.green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            side: BorderSide(
                                                color: Colors.white, width: 3)),
                                        child: null,
                                        onPressed: () {
                                          setState(() {
                                            userData.mainColor = Colors.green;
                                            Firestore.instance
                                                .collection('Users')
                                                .document(userData.userEmail)
                                                .updateData(
                                                    {'mainColor': 'green'});
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        color: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            side: BorderSide(
                                                color: Colors.white, width: 3)),
                                        child: null,
                                        onPressed: () {
                                          setState(() {
                                            userData.mainColor = Colors.blue;
                                            Firestore.instance
                                                .collection('Users')
                                                .document(userData.userEmail)
                                                .updateData(
                                                    {'mainColor': 'blue'});
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        color: Colors.pink,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            side: BorderSide(
                                                color: Colors.white, width: 3)),
                                        child: null,
                                        onPressed: () {
                                          setState(() {
                                            userData.mainColor = Colors.pink;
                                            Firestore.instance
                                                .collection('Users')
                                                .document(userData.userEmail)
                                                .updateData(
                                                    {'mainColor': 'pink'});
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        color: Colors.yellow,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            side: BorderSide(
                                                color: Colors.white, width: 3)),
                                        child: null,
                                        onPressed: () {
                                          setState(() {
                                            userData.mainColor = Colors.yellow;
                                            Firestore.instance
                                                .collection('Users')
                                                .document(userData.userEmail)
                                                .updateData(
                                                    {'mainColor': 'yellow'});
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                                  child: Text(
                                    "Background Color",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        color: Colors.pink[100],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            side: BorderSide(
                                                color: Colors.white, width: 3)),
                                        child: null,
                                        onPressed: () {
                                          setState(() {
                                            userData.backgroundColor = Colors.pink[100];
                                            Firestore.instance
                                                .collection('Users')
                                                .document(userData.userEmail)
                                                .updateData(
                                                    {'backgroundColor': 'pink'});
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        color: Colors.green[200],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            side: BorderSide(
                                                color: Colors.white, width: 3)),
                                        child: null,
                                        onPressed: () {
                                          setState(() {
                                            userData.backgroundColor = Colors.green[200];
                                            Firestore.instance
                                                .collection('Users')
                                                .document(userData.userEmail)
                                                .updateData(
                                                    {'backgroundColor': 'green'});
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        color: Colors.blue[200],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            side: BorderSide(
                                                color: Colors.white, width: 3)),
                                        child: null,
                                        onPressed: () {
                                          setState(() {
                                            userData.backgroundColor = Colors.blue[200];
                                            Firestore.instance
                                                .collection('Users')
                                                .document(userData.userEmail)
                                                .updateData(
                                                    {'backgroundColor': 'blue'});
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        color: Colors.orange[200],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            side: BorderSide(
                                                color: Colors.white, width: 3)),
                                        child: null,
                                        onPressed: () {
                                          setState(() {
                                            userData.backgroundColor = Colors.orange[200];
                                            Firestore.instance
                                                .collection('Users')
                                                .document(userData.userEmail)
                                                .updateData(
                                                    {'backgroundColor': 'orange'});
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        color: Colors.grey[700],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            side: BorderSide(
                                                color: Colors.white, width: 3)),
                                        child: null,
                                        onPressed: () {
                                          setState(() {
                                            userData.backgroundColor = Colors.black54;
                                            Firestore.instance
                                                .collection('Users')
                                                .document(userData.userEmail)
                                                .updateData(
                                                    {'backgroundColor': 'black'});
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                                  child: Text(
                                    "ButtonBar Color",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            side: BorderSide(
                                                color: Colors.white, width: 3)),
                                        child: null,
                                        onPressed: () {
                                          setState(() {
                                            userData.mainColor = Colors.red;
                                            Firestore.instance
                                                .collection('Users')
                                                .document(userData.userEmail)
                                                .updateData(
                                                    {'mainColor': 'red'});
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        color: Colors.green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            side: BorderSide(
                                                color: Colors.white, width: 3)),
                                        child: null,
                                        onPressed: () {
                                          setState(() {
                                            userData.mainColor = Colors.green;
                                            Firestore.instance
                                                .collection('Users')
                                                .document(userData.userEmail)
                                                .updateData(
                                                    {'mainColor': 'green'});
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        color: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            side: BorderSide(
                                                color: Colors.white, width: 3)),
                                        child: null,
                                        onPressed: () {
                                          setState(() {
                                            userData.mainColor = Colors.blue;
                                            Firestore.instance
                                                .collection('Users')
                                                .document(userData.userEmail)
                                                .updateData(
                                                    {'mainColor': 'blue'});
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        color: Colors.pink,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            side: BorderSide(
                                                color: Colors.white, width: 3)),
                                        child: null,
                                        onPressed: () {
                                          setState(() {
                                            userData.mainColor = Colors.pink;
                                            Firestore.instance
                                                .collection('Users')
                                                .document(userData.userEmail)
                                                .updateData(
                                                    {'mainColor': 'pink'});
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: FlatButton(
                                        color: Colors.yellow,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            side: BorderSide(
                                                color: Colors.white, width: 3)),
                                        child: null,
                                        onPressed: () {
                                          setState(() {
                                            userData.mainColor = Colors.yellow;
                                            Firestore.instance
                                                .collection('Users')
                                                .document(userData.userEmail)
                                                .updateData(
                                                    {'mainColor': 'yellow'});
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
