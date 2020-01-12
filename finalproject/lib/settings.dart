import 'package:finalproject/main.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/userData.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

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
                                  UserData.userProfilePicture = profile_pictures[index];
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
          SelectorGamesApp.settings(context),
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
