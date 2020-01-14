import 'package:flutter/material.dart';
import 'game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'userData.dart';

class Comment {
  String comment;
  String userEmail;
  String userName;
  String userPicture;
  List<Comment> answers;
}


class GamePage extends StatefulWidget {

  final UserData userData;
  final Game game;

  GamePage(this.userData, this.game);

  @override
  _GamePageState createState() => _GamePageState(userData, game);
}

class _GamePageState extends State<GamePage> {
  
  UserData userData;
  Game game;
  bool commentsLoaded = false;
  List<Comment> comments;

  _GamePageState(UserData userData, Game game) {
    this.userData = userData;
    this.game = game;
  }
  
  @override
  void initState() {
    if (comments != null) {
      setState(() {
        comments.clear();
        comments = null;
      });
    }
    loadcomments();
    super.initState();
  }

  void loadcomments() async {
    DocumentSnapshot doc = await Firestore.instance.collection('Comments').document(game.name).snapshots().first;
    if (doc.exists) {
      comments = new List<Comment>();
      int numComments = doc.data['numComments'];
      for (int i = 1; i <= numComments; ++i) {
        Comment comment = new Comment();
        DocumentReference docComments = Firestore.instance.collection('Comments').document(game.name).collection('CommentsData').document(i.toString());    
        DocumentSnapshot docBaseComment = await docComments.get();
        comment.comment = docBaseComment.data['comment'];
        comment.userEmail = docBaseComment.data['answerBy'];
        DocumentSnapshot userDoc = await Firestore.instance.collection('Users').document(comment.userEmail).get();
        comment.userName = userDoc.data['name'];
        comment.userPicture = userDoc.data['profilePicture'];
        int numAnswers = docBaseComment.data['numAnswers'];
        for (int j = 1; j <= numAnswers; ++j) {
          DocumentSnapshot answerDoc = await Firestore.instance.collection('Comments').document(game.name).collection('CommentsData').document(i.toString()).collection('AnswerData').document(j.toString()).get();   
          Comment answer = new Comment();
          answer.comment = answerDoc.data['comment'];
          answer.userEmail = answerDoc.data['answerBy'];
          DocumentSnapshot userDocAnswer = await Firestore.instance.collection('Users').document(answer.userEmail).get();
          answer.userName = userDocAnswer.data['name'];
          answer.userPicture = userDocAnswer.data['profilePicture'];
          comment.answers.add(answer);
        }
        comments.add(comment);
      }
    }
    commentsLoaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: userData.backgroundColor,
      appBar: AppBar(
        title: Text('${game.name}'),
        backgroundColor: userData.buttonBarColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 30,
            child: Container(
              padding: EdgeInsets.all(8),
              color: userData.backgroundColor,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white38,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 80,
            child: Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              color: userData.backgroundColor,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white38,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Comments',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                      (!commentsLoaded) ?
                       Center(child: CircularProgressIndicator())
                      :  (comments == null) ? Text('There are no comments')
                      : Text('There are comments'),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}