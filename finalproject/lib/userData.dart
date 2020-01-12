import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {

  static String userEmail;
  static String userName;
  static String userPassword;
  static String userProfilePicture;

  static void setdatabymail(String mail) async {
    DocumentSnapshot document = await Firestore.instance.collection('Users').document(mail).get();
    userEmail = mail;
    userProfilePicture = (document.data['profilePicture'] == 'none') ? 'assets/default_image.png' : document.data['profilePicture'];
    userName = document.data['name'];
    userPassword = document.data['password'];
  }
}