import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'userData.dart';

class PeopleFav extends StatefulWidget {
  final UserData userData;

  PeopleFav(this.userData);

  @override
  _PeopleFavState createState() => _PeopleFavState(userData);
}

class _PeopleFavState extends State<PeopleFav> {
   UserData userData;

  _PeopleFavState(UserData userData) {
    this.userData = userData;
  }
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('People Favourites'),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          GamesBookShelf.settings(context, userData),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 80,
            child: Stack(
              children: <Widget>[
                Container(
                color: Colors.black54,
                ),
                StreamBuilder(
                  stream: Firestore.instance.collection('Users').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      print('object');
                      return Center(child: CircularProgressIndicator());
                    }
                    List<DocumentSnapshot> docs = snapshot.data.documents;
                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = docs[index].data;
                        if (docs[index].documentID == 'Mails' || docs[index].documentID == 'Number' || docs[index].documentID == userData.userEmail) {
                          return Container();
                        }
                        Widget widgetFavs;
                        if (data['numFavs'] > 9) {
                          widgetFavs = Padding(
                            padding: const EdgeInsets.fromLTRB(10, 9, 0, 0),
                            child: Text(
                              data['numFavs'].toString(),
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          );
                        }
                        else {
                          widgetFavs = Padding(
                            padding: const EdgeInsets.fromLTRB(15, 9, 0, 0),
                            child: Text(
                              data['numFavs'].toString(),
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white70,
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black54, 
                                      width: 2.0,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: ExactAssetImage((data['profilePicture'] == 'none') ? 'assets/default_image.png' : data['profilePicture']),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  data['name'],
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Stack(
                                  children: <Widget>[
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                    widgetFavs,
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: FlatButton(
                                  child: Text("See Favs"),
                                  onPressed: () {

                                  },
                                ),
                              ),
                            ],
                          ),
                          ), 
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          GamesBookShelf.mainbottombar(BarActive.People, context, userData),
        ],
      ),
    );
  }
}
