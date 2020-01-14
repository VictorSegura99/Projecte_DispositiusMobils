import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
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

  color_picking() {
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
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                  side: BorderSide(
                                      color: Colors.white, width: 3)),
                              child: null,
                              onPressed: () {
                                setState(() {
                                  userData.mainColor = Colors.red;
                                  Firestore.instance
                                      .collection('Users')
                                      .document(userData.userEmail)
                                      .updateData({'mainColor': 'red'});
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                  side: BorderSide(
                                      color: Colors.white, width: 3)),
                              child: null,
                              onPressed: () {
                                setState(() {
                                  userData.mainColor = Colors.green;
                                  Firestore.instance
                                      .collection('Users')
                                      .document(userData.userEmail)
                                      .updateData({'mainColor': 'green'});
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                  side: BorderSide(
                                      color: Colors.white, width: 3)),
                              child: null,
                              onPressed: () {
                                setState(() {
                                  userData.mainColor = Colors.blue;
                                  Firestore.instance
                                      .collection('Users')
                                      .document(userData.userEmail)
                                      .updateData({'mainColor': 'blue'});
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.pink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                  side: BorderSide(
                                      color: Colors.white, width: 3)),
                              child: null,
                              onPressed: () {
                                setState(() {
                                  userData.mainColor = Colors.pink;
                                  Firestore.instance
                                      .collection('Users')
                                      .document(userData.userEmail)
                                      .updateData({'mainColor': 'pink'});
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.yellow,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                  side: BorderSide(
                                      color: Colors.white, width: 3)),
                              child: null,
                              onPressed: () {
                                setState(() {
                                  userData.mainColor = Colors.yellow;
                                  Firestore.instance
                                      .collection('Users')
                                      .document(userData.userEmail)
                                      .updateData({'mainColor': 'yellow'});
                                });
                                Navigator.of(context).pop();
                              },
                            ),
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
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.pink[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                  side: BorderSide(
                                      color: Colors.white, width: 3)),
                              child: null,
                              onPressed: () {
                                setState(() {
                                  userData.backgroundColor = Colors.pink[100];
                                  Firestore.instance
                                      .collection('Users')
                                      .document(userData.userEmail)
                                      .updateData({'backgroundColor': 'pink'});
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.green[200],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                  side: BorderSide(
                                      color: Colors.white, width: 3)),
                              child: null,
                              onPressed: () {
                                setState(() {
                                  userData.backgroundColor = Colors.green[200];
                                  Firestore.instance
                                      .collection('Users')
                                      .document(userData.userEmail)
                                      .updateData({'backgroundColor': 'green'});
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.blue[200],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                  side: BorderSide(
                                      color: Colors.white, width: 3)),
                              child: null,
                              onPressed: () {
                                setState(() {
                                  userData.backgroundColor = Colors.blue[200];
                                  Firestore.instance
                                      .collection('Users')
                                      .document(userData.userEmail)
                                      .updateData({'backgroundColor': 'blue'});
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.orange[200],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
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
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.grey[700],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                  side: BorderSide(
                                      color: Colors.white, width: 3)),
                              child: null,
                              onPressed: () {
                                setState(() {
                                  userData.backgroundColor = Colors.black54;
                                  Firestore.instance
                                      .collection('Users')
                                      .document(userData.userEmail)
                                      .updateData({'backgroundColor': 'black'});
                                });
                                Navigator.of(context).pop();
                              },
                            ),
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
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.grey[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                  side: BorderSide(
                                      color: Colors.white, width: 3)),
                              child: null,
                              onPressed: () {
                                setState(() {
                                  userData.buttonBarColor = Colors.black87;
                                  Firestore.instance
                                      .collection('Users')
                                      .document(userData.userEmail)
                                      .updateData({'buttonBarColor': 'grey'});
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.green[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                  side: BorderSide(
                                      color: Colors.white, width: 3)),
                              child: null,
                              onPressed: () {
                                setState(() {
                                  userData.buttonBarColor = Colors.green[900];
                                  Firestore.instance
                                      .collection('Users')
                                      .document(userData.userEmail)
                                      .updateData({'buttonBarColor': 'green'});
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.blueGrey[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                  side: BorderSide(
                                      color: Colors.white, width: 3)),
                              child: null,
                              onPressed: () {
                                setState(() {
                                  userData.buttonBarColor =
                                      Colors.blueGrey[900];
                                  Firestore.instance
                                      .collection('Users')
                                      .document(userData.userEmail)
                                      .updateData({'buttonBarColor': 'blue'});
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.purple[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                  side: BorderSide(
                                      color: Colors.white, width: 3)),
                              child: null,
                              onPressed: () {
                                setState(() {
                                  userData.buttonBarColor = Colors.purple[900];
                                  Firestore.instance
                                      .collection('Users')
                                      .document(userData.userEmail)
                                      .updateData({'buttonBarColor': 'purple'});
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                  side: BorderSide(
                                      color: Colors.white, width: 3)),
                              child: null,
                              onPressed: () {
                                setState(() {
                                  userData.buttonBarColor = Colors.black;
                                  Firestore.instance
                                      .collection('Users')
                                      .document(userData.userEmail)
                                      .updateData({'buttonBarColor': 'black'});
                                });
                                Navigator.of(context).pop();
                              },
                            ),
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
  }

  _launchURL(String website) async{
    if(await canLaunch(website)){
      await launch(website);
    }
    else{
      throw 'Could not launch $website';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: userData.buttonBarColor,
        title: Text('Profile'),
        actions: <Widget>[
          GamesBookShelf.settings(context, userData, inSettings: true),
        ],
      ),
      body: Container(
          color: userData.backgroundColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                child: Row(
                  children: <Widget>[
                    Container(color: userData.buttonBarColor),
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  ExactAssetImage(userData.userProfilePicture),
                            ),
                          ),
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          child: FlatButton(
                            color: Colors.black38,
                            child: Text(
                              'EDIT',
                              style: TextStyle(color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5000)),
                            onPressed: () {
                              changephoto();
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.black),
                            borderRadius: BorderRadius.circular(5000)),
                        child: FlatButton(
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5000)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 48),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Customize',
                                  style: TextStyle(fontSize: 21),
                                ),
                                Text(
                                  'Colors',
                                  style: TextStyle(fontSize: 21),
                                )
                              ],
                            ),
                          ),
                          onPressed: () {
                            color_picking();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 8),
                child: Divider(
                  color: Colors.black54,
                  thickness: 2,
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: FlatButton(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(top: 48),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Change',
                                style: TextStyle(fontSize: 21),
                              ),
                              Text(
                                'Password',
                                style: TextStyle(fontSize: 21),
                              )
                            ],
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        onPressed: () {
                          changephoto();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Color.fromRGBO(255, 255, 255, 0.9),
                            width: 2),
                      ),
                      child: FlatButton(
                        color: Colors.black87,
                        child: Padding(
                          padding: EdgeInsets.only(top: 48),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Change',
                                style: TextStyle(
                                    fontSize: 21, color: Colors.white),
                              ),
                              Text(
                                'Nickname',
                                style: TextStyle(
                                    fontSize: 21, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        onPressed: () {
                          changephoto();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 8),
                child: Divider(
                  color: Colors.black54,
                  thickness: 2,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'About the Devs',
                        style: TextStyle(
                            decoration: TextDecoration.underline, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: ExactAssetImage(
                                          'assets/images/github.png'),
                                    ),
                                  ),
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5000),
                                      ),
                                      onPressed: () {
                                        _launchURL('https://github.com/VictorSegura99/Projecte_DispositiusMobils');
                                      }),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5, top: 3),
                                child: Container(
                                  width: 80,
                                  height: 20,
                                  child: Center(child: Text('Repository',style: TextStyle(fontWeight: FontWeight.bold),)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 2,color: Colors.black),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: ExactAssetImage(
                                          'assets/images/github.png'),
                                    ),
                                  ),
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5000),
                                      ),
                                      onPressed: () {
                                        _launchURL('https://github.com/VictorSegura99');
                                      }),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5, top: 3),
                                child: Container(
                                  width: 80,
                                  height: 20,
                                  child: Center(child: Text('Víctor Page',style: TextStyle(fontWeight: FontWeight.bold),)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 2,color: Colors.black),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: ExactAssetImage(
                                          'assets/images/github.png'),
                                    ),
                                  ),
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5000),
                                      ),
                                      onPressed: () {
                                        _launchURL('https://github.com/OriolCS2');
                                      }),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5, top: 3),
                                child: Container(
                                  width: 80,
                                  height: 20,
                                  child: Center(child: Text('Oriol Page',style: TextStyle(fontWeight: FontWeight.bold),)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 2,color: Colors.black),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: ExactAssetImage(
                                          'assets/images/github.png'),
                                    ),
                                  ),
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5000),
                                      ),
                                      onPressed: () {
                                        _launchURL('https://github.com/LaiaMartinezMotis');
                                      }),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5, top: 3),
                                child: Container(
                                  width: 80,
                                  height: 20,
                                  child: Center(child: Text('Laia Page',style: TextStyle(fontWeight: FontWeight.bold),)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 2,color: Colors.black),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
