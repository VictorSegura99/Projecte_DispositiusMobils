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