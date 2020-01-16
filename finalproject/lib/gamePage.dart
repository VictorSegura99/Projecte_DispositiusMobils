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

  int getanswerslenght() {
    if (answers != null) {
      return answers.length;
    }
    return 0;
  }
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
    DocumentSnapshot doc = await Firestore.instance
        .collection('Comments')
        .document(game.name)
        .snapshots()
        .first;
    if (doc.exists) {
      comments = new List<Comment>();
      int numComments = doc.data['numComments'];
      for (int i = 1; i <= numComments; ++i) {
        Comment comment = new Comment();
        DocumentReference docComments = Firestore.instance
            .collection('Comments')
            .document(game.name)
            .collection('CommentsData')
            .document(i.toString());
        DocumentSnapshot docBaseComment = await docComments.get();
        comment.comment = docBaseComment.data['comment'];
        comment.userEmail = docBaseComment.data['answerBy'];
        DocumentSnapshot userDoc = await Firestore.instance
            .collection('Users')
            .document(comment.userEmail)
            .get();
        comment.userName = userDoc.data['name'];
        comment.userPicture = userDoc.data['profilePicture'];
        int numAnswers = docBaseComment.data['numAnswers'];
        for (int j = 1; j <= numAnswers; ++j) {
          DocumentSnapshot answerDoc = await Firestore.instance
              .collection('Comments')
              .document(game.name)
              .collection('CommentsData')
              .document(i.toString())
              .collection('AnswersData')
              .document(j.toString())
              .get();
          Comment answer = new Comment();
          answer.comment = answerDoc.data['comment'];
          answer.userEmail = answerDoc.data['answerBy'];
          DocumentSnapshot userDocAnswer = await Firestore.instance
              .collection('Users')
              .document(answer.userEmail)
              .get();
          answer.userName = userDocAnswer.data['name'];
          answer.userPicture = userDocAnswer.data['profilePicture'];
          if (comment.answers == null) {
            comment.answers = new List<Comment>();
          }
          comment.answers.add(answer);
        }
        comments.add(comment);
      }
    }
    commentsLoaded = true;
    setState(() {});
  }


  Widget rendercomments() {
    List<Widget> containers = new List<Widget>();
    for (int i = 0; i < comments.length; ++i) {
      List<Widget> answers;
      if (comments[i].answers != null) {
        answers = new List<Widget>();
        for (int j = 0; j < comments[i].answers.length; ++j) {
          answers.add(
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        shape: BoxShape.circle,
                        color: Colors.blue,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: ExactAssetImage(
                              comments[i].answers[j].userPicture),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 11, 65, 0),
                      child: Container(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            comments[i].answers[j].userName,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 5, 68, 8),
                      child: Container(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(comments[i].answers[j].comment),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      } else {
        answers = new List<Widget>();
        answers.add(Container());
      }
      containers.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white38,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: ExactAssetImage(
                                        comments[i].userPicture),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(65, 8, 0, 0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                comments[i].userName,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(68, 30, 8, 0),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(comments[i].comment)),
                          ),
                        ],
                      ),
                      Column(children: answers),
                      /*Align(
                            alignment: Alignment.bottomRight,
                            child: FlatButton(
                              child: Text('Answer'),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10)),
                              color: Colors.black,
                              textColor: Colors.white,
                              onPressed: () {
                                
                              },
                            ),
                          ),*/
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      child: Text('Answer'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () {
                        addanswer(i);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Stack(
      children: <Widget>[
        Column(
          children: containers,
        ),
      ],
    );
  }

  void addnewcomment() {
    TextEditingController controller = new TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('New Comment'),
        content: Container(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                labelText: 'Write your comment', hintText: 'Comment'),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('MAKE COMMENT'),
            onPressed: () async {
              if (controller.text.isNotEmpty) {
              DocumentSnapshot docNum = await Firestore.instance.collection('Comments').document(game.name).get();
              int numComments = 0;
              if (docNum.exists) {
                numComments = docNum.data['numComments'] + 1;
                Firestore.instance.collection('Comments').document(game.name).updateData({'numComments' : numComments});
              }
              else {
                numComments = 1;
                Firestore.instance.collection('Comments').document(game.name).setData({'numComments' : 1});
              }
              Map<String, dynamic> data = {
                'answerBy' : userData.userEmail,
                'comment' : controller.text,
                'numAnswers' : 0,
                'numTalkers' : 1,
                '1' : userData.userEmail
              };
              Firestore.instance.collection('Comments').document(game.name).collection('CommentsData').document(numComments.toString()).setData(data);
              if (comments != null) {
                setState(() {
                  commentsLoaded = false;
                  comments.clear();
                  comments = null;
                });
              }
              loadcomments();
              Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  void setanswernotification(String email, int numComment) async {
    DocumentSnapshot documentSnapshot = await Firestore.instance.collection('Comments').document(game.name).collection('CommentsData').document(numComment.toString()).get();
    List<String> toNotify = new List<String>();
    for (int i = 1; i <= documentSnapshot.data['numTalkers']; ++i) {
      toNotify.add(documentSnapshot.data[i.toString()]);
    }
    for (int i = 0; i < toNotify.length; ++i) {
      if (toNotify[i] != userData.userEmail) {
        DocumentSnapshot docNot = await Firestore.instance.collection('Notifications').document(toNotify[i]).get();
        if (docNot.exists) {
          Map<String, dynamic> data = docNot.data;
          int numNoti = docNot.data['numNotis'] + 1;
          data['numNotis'] = numNoti;
          data['newNotis'] = true;
          data[numNoti.toString()] = 'Someone commented in a ${game.name} post you talked';
          data['${numNoti}Type'] = 'comment';
          data['${numNoti}Game'] = game.name;
          data['${numNoti}Seen'] = false;
          Firestore.instance.collection('Notifications').document(toNotify[i]).setData(data);
        }
        else {
        Firestore.instance.collection('Notifications').document(toNotify[i]).setData(
          {
            'numNotis' : 1,
            'newNotis' : true,
            '1' : 'Someone commented in a ${game.name} post you talked',
            '1Type' : 'comment',
            '1Game' :  game.name,
            '1Seen' : false,
          }
        );
      }
      }
    }

  }

  void addanswer(int comment) {
    int comment_ = comment + 1;
    TextEditingController controller = new TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('New Answer'),
        content: Container(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                labelText: 'Write your answer', hintText: 'Answer'),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('MAKE COMMENT'),
            onPressed: () async {
              if (controller.text.isNotEmpty) {
              DocumentSnapshot docNum = await Firestore.instance.collection('Comments').document(game.name).collection('CommentsData').document(comment_.toString()).get();
              int numTalkers = docNum.data['numTalkers'];
              bool isNew = true;
              for (int i = 1; i <= numTalkers; ++i) {
                if (docNum.data[i.toString()] == userData.userEmail) {
                  isNew = false;
                  break;
                }
              }
              if (isNew) {
                ++numTalkers;
                docNum.data[numTalkers.toString()] = userData.userEmail;
                docNum.data['numTalkers'] = numTalkers;
                Firestore.instance.collection('Comments').document(game.name).collection('CommentsData').document(comment_.toString()).setData(docNum.data);
              }
              
              int numAnswers = 0;
              numAnswers = docNum.data['numAnswers'] + 1;
              Firestore.instance.collection('Comments').document(game.name).collection('CommentsData').document(comment_.toString()).updateData({'numAnswers' : numAnswers});
              Map<String, dynamic> data = {
                'answerBy' : userData.userEmail,
                'comment' : controller.text,
                'numAnswers' : 0
              };
              Firestore.instance.collection('Comments').document(game.name).collection('CommentsData').document(comment_.toString()).collection('AnswersData').document(numAnswers.toString()).setData(data);
              if (comments != null) {
                setState(() {
                  commentsLoaded = false;
                  comments.clear();
                  comments = null;
                });
              }
              loadcomments();
              Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: userData.backgroundColor,
      appBar: AppBar(
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
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ClipRRect(
                            child: Container(height: 200,child: Image.asset(game.image,fit: BoxFit.fitHeight,)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${game.name}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Text(
                              '${game.company}',
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 80,
            child: Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
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
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      (!commentsLoaded)
                          ? Center(child: CircularProgressIndicator())
                          : (comments == null)
                              ? Text('There are no comments')
                              : rendercomments(),
                      OutlineButton(
                        child: Text('Add New Comment'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.black,
                        focusColor: Colors.black,
                        borderSide: BorderSide(width: 2),
                        highlightedBorderColor: Colors.black,
                        onPressed: () {
                          addnewcomment();
                        },
                      ),
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
