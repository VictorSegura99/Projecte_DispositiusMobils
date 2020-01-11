import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


  @override
  Widget build(BuildContext context) {
      TextEditingController nameController;
    TextEditingController emailController;
    TextEditingController passwordController;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Register'),
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
      );
  }
}