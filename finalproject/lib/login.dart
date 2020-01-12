import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/game.dart';
import 'package:finalproject/main.dart';
import 'package:finalproject/register.dart';
import 'package:finalproject/userData.dart';
import 'package:finalproject/settings.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/explorer.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  void initState() {
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    super.initState();
  }

  Future<void> readpassword(String email, String password) async {
    bool success = false;
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('Users').getDocuments();
    var list = querySnapshot.documents;
    for (int i = 0; i < list.length; ++i) {
      if (list[i].exists && list[i].documentID == email) {
        if (password == list[i].data['password']) {
          success = true;
          break;
        }
      }
    }
  if (success) {
    UserData.setdatabymail(email);
    Game.loadgames();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    GamesExplorer()), (Route<dynamic> route) => false);
  } 
  else {
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
                image: AssetImage("assets/images/log_minecraft.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white70,
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
                                  padding: const EdgeInsets.fromLTRB(30, 15, 0, 0),
                                  child: FlatButton(
                                    child: Text('Register Now'),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    color: Colors.black,
                                    focusColor: Colors.black,
                                    borderSide: BorderSide(width: 2),
                                    highlightedBorderColor: Colors.black,
                                    onPressed: () {
                                      readpassword(emailController.text, passwordController.text);
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
