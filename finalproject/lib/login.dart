import 'dart:math';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register.dart';
import 'userData.dart';
import 'package:flutter/material.dart';
import 'explorer.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController;
  TextEditingController passwordController;
  List<String> backgrounds;
  int rngBackground;
  @override
  void initState() {
    emailController = new TextEditingController();
    passwordController = new TextEditingController();

    backgrounds = GamesBookShelf.getbackgrounds();
    rngBackground = (new Random()).nextInt(backgrounds.length);

    super.initState();
  }

  Future<void> readpassword(String email, String password) async {
    bool success = false;
    UserData userData;
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('Users').getDocuments();
    var list = querySnapshot.documents;
    for (int i = 0; i < list.length; ++i) {
      if (list[i].exists && list[i].documentID == email) {
        if (password == list[i].data['password']) {
          userData = new UserData();
          userData.userPassword = password;
          userData.userName = list[i].data['name'];
          userData.userProfilePicture =
              (list[i].data['profilePicture'] == 'none')
                  ? 'assets/default_image.png'
                  : list[i].data['profilePicture'];
          userData.userEmail = email;
          userData.numFavs = list[i].data['numFavs'];
          String col = list[i].data['mainColor'];
          if (col == 'blue') {
            userData.mainColor = Colors.blue;
          }
          else if (col == 'red') {
            userData.mainColor = Colors.red;
          }
          else if (col == 'green') {
            userData.mainColor = Colors.green;
          }
          else if (col == 'pink') {
            userData.mainColor = Colors.pink;
          }
          else if (col == 'yellow') {
            userData.mainColor = Colors.yellow;
          }

          col= list[i].data['backgroundColor'];
          if (col == 'blue') {
            userData.backgroundColor = Colors.blue;
          }
          else if (col == 'orange') {
            userData.backgroundColor = Colors.orange[200];
          }
          else if (col == 'green') {
            userData.backgroundColor = Colors.green[200];
          }
          else if (col == 'pink') {
            userData.backgroundColor = Colors.pink[100];
          }
          else if (col == 'black') {
            userData.backgroundColor = Colors.black54;
          }

          col= list[i].data['buttonBarColor'];
          if (col == 'blue') {
            userData.buttonBarColor = Colors.blueGrey[900];
          }
          else if (col == 'grey') {
            userData.buttonBarColor = Colors.black87;
          }
          else if (col == 'green') {
            userData.buttonBarColor = Colors.green[900];
          }
          else if (col == 'purple') {
            userData.buttonBarColor = Colors.purple[900];
          }
          else if (col == 'black') {
            userData.buttonBarColor = Colors.black;
          }
          DocumentSnapshot notis = await Firestore.instance.collection('Notifications').document(userData.userEmail).get();
          if (notis.exists) {
            userData.newNoti = notis.data['newNotis'];
          }
          success = true;
          break;
        }
      }
    }
    if (success) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => GamesExplorer(userData)),
          (Route<dynamic> route) => false);
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Email or Password incorrect'),
          actions: <Widget>[
            FlatButton(
              child: Text('CONFIRM'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgrounds[rngBackground]),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(255, 255, 255, 0.85),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 180,
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            height: 50,
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                icon: Icon(
                                  Icons.email,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                              controller: emailController,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            height: 50,
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                icon: Icon(
                                  Icons.screen_lock_portrait,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                              controller: passwordController,
                            ),
                          ),
                          Center(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 15, 0, 0),
                                  child: FlatButton(
                                    child: Text('Register Now'),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.black,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) {
                                          return RegisterPage();
                                        },
                                      ));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(35, 15, 0, 0),
                                  child: OutlineButton(
                                    child: Text('Log In'),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.black,
                                    focusColor: Colors.black,
                                    borderSide: BorderSide(width: 2),
                                    highlightedBorderColor: Colors.black,
                                    onPressed: () {
                                      readpassword(emailController.text,
                                          passwordController.text);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
