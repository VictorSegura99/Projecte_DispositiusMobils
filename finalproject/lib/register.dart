import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'explorer.dart';
import 'userData.dart';
import 'main.dart';
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
  List<String> backgrounds;
  int rngBackground;

  @override
  void initState() {
    emailController = new TextEditingController();
    nameController = new TextEditingController();
    passwordController = new TextEditingController();
    passwordController2 = new TextEditingController();
    codeController = new TextEditingController();

    backgrounds = GamesBookShelf.getbackgrounds();
    rngBackground = (new Random()).nextInt(backgrounds.length);
    super.initState();
  }

  Future<void> canregister() async {
    bool canRegister = false;
    bool empty = false;
    bool password = false;
    bool email = false;
    bool name = false;

    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordController2.text.isNotEmpty) {
      if (passwordController.text.compareTo(passwordController2.text) == 0) {
        if (EmailValidator.validate(emailController.text)) {
          DocumentReference documentReference = Firestore.instance
              .collection('Users')
              .document(emailController.text);
          DocumentSnapshot doc = await documentReference.snapshots().first;
          if (!doc.exists) {
            DocumentSnapshot docNum = await Firestore.instance
                .collection('Users')
                .document('Number')
                .get();
            int num = docNum.data['Num'];
            DocumentSnapshot documents = await Firestore.instance
                .collection('Users')
                .document('Mails')
                .get();
            List<String> emails = new List<String>();
            for (int i = 1; i <= num; ++i) {
              emails.add(documents.data['mail$i']);
            }
            for (int i = 0; i < emails.length; ++i) {
              if ((await Firestore.instance
                          .collection('Users')
                          .document(emails[i])
                          .get())
                      .data['name'] ==
                  nameController.text) {
                name = true;
                break;
              }
            }
            if (!name) {
              canRegister = true;
            }
          }
        } else {
          email = true;
        }
      } else {
        password = true;
      }
    } else {
      empty = true;
    }

    if (canRegister) {
      Map<String, dynamic> data = {
        'name': nameController.text,
        'password': passwordController.text,
        'profilePicture': 'none',
        'numFavs': 0,
        'mainColor': 'blue',
        'backgroundColor': 'black',
        'buttonBarColor': 'grey'
      };
      Firestore.instance
          .collection('Users')
          .document(emailController.text)
          .setData(data);
      DocumentSnapshot docNum =
          await Firestore.instance.collection('Users').document('Number').get();
      int num = docNum.data['Num'];
      Firestore.instance
          .collection('Users')
          .document('Number')
          .updateData({'Num': num + 1});
      ++num;
      Firestore.instance
          .collection('Users')
          .document('Mails')
          .updateData({'mail$num': emailController.text});
      UserData userData = new UserData();
      userData.userName = nameController.text;
      userData.userEmail = emailController.text;
      userData.userPassword = passwordController.text;
      userData.userProfilePicture = 'assets/default_image.png';
      userData.numFavs = 0;
      userData.mainColor = Colors.blue;
      userData.backgroundColor = Colors.black54;
      userData.buttonBarColor = Colors.black87;
      
      GamesExplorer.newUser = true;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => GamesExplorer(userData)),
          (Route<dynamic> route) => false);
    } else {
      String text;
      if (empty) {
        text = 'At least one input text is empty';
      } else if (password) {
        text = 'Password is not the same';
      } else if (email) {
        text = 'Email does not exist';
      } else if (name) {
        text = 'This user name is already used';
      } else {
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
        backgroundColor: Colors.black87,
      ),
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
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(255, 255, 255, 0.85),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 303,
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your name for the application',
                              labelText: 'UserName',
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
                            obscureText: true,
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
                            obscureText: true,
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
                            padding: const EdgeInsets.only(top: 8),
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
