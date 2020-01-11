import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/register.dart';
import 'package:flutter/material.dart';
import 'package:unique_identifier/unique_identifier.dart';

void main() => runApp(SelectorGamesApp());

class SelectorGamesApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinalProject',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LogIn(),
    );
  }
}

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  String deviceID = 'Unknown';
  bool new_account = false;
 @override
 void initState() {
   super.initState();
   getdeviceid();
 }

 Future<void> getdeviceid() async {
   String _deviceID;
    _deviceID = await UniqueIdentifier.serial;
   setState(() {
     deviceID = _deviceID;
   });
 }

 @override
 Widget build(BuildContext context) {
      TextEditingController emailController;
      TextEditingController passwordController;
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
              controller: emailController,
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

                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      /*TextEditingController nameController;
      TextEditingController emailController;
      TextEditingController passwordController;
      widget = Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Welcome to the Selector Games App'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20,10,40,0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Enter your name for the application',
              labelText: 'Name',
              icon: Icon(
                Icons.account_circle,
                size: 27,
                color: Colors.blue,
              ),
            ),
            controller: nameController,
          ),
        ),
      );*/
 }

}
