import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/register.dart';
import 'package:flutter/material.dart';

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
  QuerySnapshot querySnapshot = await Firestore.instance.collection(email).getDocuments();
  var list = querySnapshot.documents;
  for (int i = 0; i < list.length; ++i) {
    if (list[i].exists && list[i].documentID == 'BaseInfo') {
      if (password == list[i].data['password']) {
       success = true;
        break;
      }
    }
  }
  if (success) {

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
        appBar: AppBar(
          title: Text('Log In Selector Games App'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20,10,40,0),
          child: Column(
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  icon: Icon(
                    Icons.email,
                    size: 27,
                    color: Colors.blue,
                  ),
                ),
              controller: emailController,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  icon: Icon(
                    Icons.screen_lock_portrait,
                    size: 27,
                    color: Colors.blue,
                  ),
                ),
              controller: passwordController,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60,15,0,0),
                    child: FlatButton(
                      child: Text('Register Now'),
                      color: Colors.red,
                      onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return RegisterPage(); 
                            },
                          ));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35,15,0,0),
                    child: FlatButton(
                      child: Text('Log In'),
                      color: Colors.blue,
                      onPressed: () {
                        readpassword(emailController.text, passwordController.text);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
 }
}