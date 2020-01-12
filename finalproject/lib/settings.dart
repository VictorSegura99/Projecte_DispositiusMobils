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
                                  userData.userProfilePicture = profile_pictures[index];
                              });
                              Firestore.instance.collection('Users').document(userData.userEmail).updateData({'profilePicture' : userData.userProfilePicture});
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
          SelectorGamesApp.settings(context, userData, inSettings: true),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(color: Colors.black54),
          FlatButton(
            color: Colors.red,
            child: Text('Change Photo'),
            onPressed: () {
                changephoto();
            },
          ),
        ],
      ),
    );
  }
}
