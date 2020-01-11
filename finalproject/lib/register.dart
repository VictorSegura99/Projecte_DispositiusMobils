import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

    TextEditingController nameController;
    TextEditingController emailController;
    TextEditingController passwordController;
    TextEditingController passwordController2;
    TextEditingController codeController;
    int code;

 @override
 void initState() {
   emailController = new TextEditingController();
   nameController = new TextEditingController();
   passwordController = new TextEditingController();
   passwordController2 = new TextEditingController();
   codeController = new TextEditingController();
   super.initState();
 }

  Future<void> canregister() async {
    bool canRegister = false;
    bool empty = false;
    bool password = false;
    bool email = false;

    if (nameController.text.isNotEmpty && emailController.text.isNotEmpty 
        && passwordController.text.isNotEmpty && passwordController2.text.isNotEmpty) 
    {
      if (passwordController.text.compareTo(passwordController2.text) == 0) {
        if (EmailValidator.validate(emailController.text)) {
          DocumentReference documentReference = Firestore.instance.collection(emailController.text).document('BaseInfo');
          DocumentSnapshot doc = await documentReference.snapshots().first;
          if (!doc.exists) {
            canRegister = true;
          }
        }
        else {
          email = true;
        }
      }
      else {
        password = true;
      }
    }
    else {
      empty = true;
    }

    if (canRegister) {
        showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Security Check'),
          content: Column(
            children: <Widget>[
              Text('An email has been sent to your email, please enter the code below'),
              TextField(
                controller: codeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter the code",
                  labelText: 'Code'
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CONFIRM'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            )
          ],
        ),
      );
    }
    else {
      String text;
      if (empty) {
        text = 'At least one input text is empty';
      }
      else if (password) {
        text = 'Password is not the same';
      }
      else if (email) {
        text = 'Email does not exist';
      }
      else {
        text = 'This email is already registered';
      }
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(text),
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
      resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20,10,40,0),
          child: Column(
            children: <Widget>[
              TextField(
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
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your password again',
                  labelText: 'Repeat Password',
                  icon: Icon(
                    Icons.screen_lock_portrait,
                    size: 27,
                    color: Colors.blue,
                  ),
                ),
                controller: passwordController2,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: FlatButton(
                  child: Text('Register'),
                  color: Colors.red,
                  onPressed: () {
                    canregister();
                  },
                ),
              ),
            ],
          ),
        ),
      );
  }

}